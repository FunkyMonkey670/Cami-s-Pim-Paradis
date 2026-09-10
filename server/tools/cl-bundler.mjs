#!/usr/bin/env node

import { createHash, randomUUID } from "node:crypto";
import { watch as watchFile } from "node:fs";
import {
  access,
  mkdir,
  readFile,
  realpath,
  rename,
  rm,
  stat,
  writeFile,
} from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import { fileURLToPath } from "node:url";

const APP_NAME = "AOTTG2 Map Logic Bundler";
const APP_VERSION = "2.0.0";
const DEFAULT_MANIFEST = "build-order.json";
const UTF8_DECODER = new TextDecoder("utf-8", { fatal: true });
const SCRIPT_SERVER_ROOT = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

export class BundlerError extends Error {
  constructor(message, details = []) {
    super(message);
    this.name = "BundlerError";
    this.details = Array.isArray(details) ? details : [details];
  }
}

function sha256(value) {
  return createHash("sha256").update(value).digest("hex");
}

function slash(value) {
  return value.split(path.sep).join("/");
}

function isInside(parent, candidate) {
  const relative = path.relative(parent, candidate);
  return (
    relative === "" ||
    (!relative.startsWith(".." + path.sep) && relative !== ".." && !path.isAbsolute(relative))
  );
}

function resolveProjectPath(serverRoot, relativePath, label) {
  if (typeof relativePath !== "string" || relativePath.trim() === "") {
    throw new BundlerError(label + " must be a non-empty relative path.");
  }
  if (path.isAbsolute(relativePath)) {
    throw new BundlerError(label + " must be relative to the server directory: " + relativePath);
  }
  const resolved = path.resolve(serverRoot, relativePath);
  if (!isInside(serverRoot, resolved)) {
    throw new BundlerError(label + " escapes the server directory: " + relativePath);
  }
  return resolved;
}

async function pathExists(target) {
  try {
    await access(target);
    return true;
  } catch {
    return false;
  }
}

async function readUtf8(target, label) {
  let data;
  try {
    data = await readFile(target);
  } catch (error) {
    throw new BundlerError("Unable to read " + label + ": " + target, error.message);
  }
  try {
    let value = UTF8_DECODER.decode(data);
    if (value.charCodeAt(0) === 0xfeff) value = value.slice(1);
    return value;
  } catch {
    throw new BundlerError(label + " is not valid UTF-8: " + target);
  }
}

function normalizeSource(value) {
  return value.replace(/\r\n?/g, "\n").replace(/\n+$/g, "");
}

function applyLineEndings(value, mode) {
  return mode === "crlf" ? value.replace(/\n/g, "\r\n") : value;
}

function countLines(value) {
  if (value === "") return 0;
  return value.split("\n").length;
}

function requireObject(value, label) {
  if (!value || typeof value !== "object" || Array.isArray(value)) {
    throw new BundlerError(label + " must be a JSON object.");
  }
}

function requirePath(value, label) {
  if (typeof value !== "string" || value.trim() === "") {
    throw new BundlerError(label + " must be a non-empty relative path.");
  }
}

function requireBoolean(value, label) {
  if (value !== undefined && typeof value !== "boolean") {
    throw new BundlerError(label + " must be true or false.");
  }
}

function validateManifestShape(raw, displayPath) {
  requireObject(raw, displayPath);
  if (raw.formatVersion !== 2) {
    throw new BundlerError(displayPath + ' must define "formatVersion": 2.');
  }
  if (raw.target !== "aottg2-map") {
    throw new BundlerError(displayPath + ' must define "target": "aottg2-map".');
  }
  if (raw.lineEndings !== undefined && !["lf", "crlf"].includes(raw.lineEndings)) {
    throw new BundlerError('"lineEndings" must be "lf" or "crlf".');
  }
  requireBoolean(raw.sourceMarkers, '"sourceMarkers"');
  requireBoolean(raw.header, '"header"');
  requireBoolean(raw.failOnEmpty, '"failOnEmpty"');

  requireObject(raw.logic, '"logic"');
  requirePath(raw.logic.output, '"logic.output"');
  requirePath(raw.logic.lineMap, '"logic.lineMap"');
  if (!raw.logic.output.toLowerCase().endsWith(".cl")) {
    throw new BundlerError("logic.output must end in .cl: " + raw.logic.output);
  }
  if (!Array.isArray(raw.logic.files) || raw.logic.files.length === 0) {
    throw new BundlerError('"logic.files" must be a non-empty array.');
  }
  for (let index = 0; index < raw.logic.files.length; index += 1) {
    requirePath(raw.logic.files[index], "logic.files[" + index + "]");
    if (!raw.logic.files[index].toLowerCase().endsWith(".cl")) {
      throw new BundlerError("Logic input must end in .cl: " + raw.logic.files[index]);
    }
  }

  requireObject(raw.map, '"map"');
  requirePath(raw.map.template, '"map.template"');
  requirePath(raw.map.logicStart, '"map.logicStart"');
  requirePath(raw.map.logicEnd, '"map.logicEnd"');
  requirePath(raw.map.output, '"map.output"');
  requirePath(raw.map.lineMap, '"map.lineMap"');

  if (raw.map.logicStart === raw.map.logicEnd) {
    throw new BundlerError("map.logicStart and map.logicEnd must be different.");
  }

  if (raw.validation !== undefined) {
    requireObject(raw.validation, '"validation"');
    requireBoolean(raw.validation.delimiters, '"validation.delimiters"');
    requireBoolean(raw.validation.duplicateDeclarations, '"validation.duplicateDeclarations"');
    requireBoolean(raw.validation.requireMain, '"validation.requireMain"');
    if (
      raw.validation.requiredNetworkedComponents !== undefined &&
      !Array.isArray(raw.validation.requiredNetworkedComponents)
    ) {
      throw new BundlerError('"validation.requiredNetworkedComponents" must be an array.');
    }
    for (const component of raw.validation.requiredNetworkedComponents ?? []) {
      if (typeof component !== "string" || component.trim() === "") {
        throw new BundlerError("Every required networked component must be a non-empty string.");
      }
    }
  }
}

function validateDelimiters(source, sourceName) {
  const opening = new Map([
    ["(", ")"],
    ["[", "]"],
    ["{", "}"],
  ]);
  const closing = new Set(opening.values());
  const stack = [];
  let state = "code";
  let line = 1;
  let stateStartLine = 0;

  for (let index = 0; index < source.length; index += 1) {
    const current = source[index];
    const next = source[index + 1];

    if (current === "\n") {
      line += 1;
      if (state === "line-comment") state = "code";
      continue;
    }
    if (state === "line-comment") continue;
    if (state === "block-comment") {
      if (current === "*" && next === "/") {
        state = "code";
        index += 1;
      }
      continue;
    }
    if (state === "string") {
      if (current === "\\") index += 1;
      else if (current === '"') state = "code";
      continue;
    }
    if (state === "character") {
      if (current === "\\") index += 1;
      else if (current === "'") state = "code";
      continue;
    }

    if (current === "#") {
      state = "line-comment";
      continue;
    }
    if (current === "/" && next === "/") {
      state = "line-comment";
      index += 1;
      continue;
    }
    if (current === "/" && next === "*") {
      state = "block-comment";
      stateStartLine = line;
      index += 1;
      continue;
    }
    if (current === '"') {
      state = "string";
      stateStartLine = line;
      continue;
    }
    if (current === "'") {
      state = "character";
      stateStartLine = line;
      continue;
    }
    if (opening.has(current)) {
      stack.push({ symbol: current, line });
      continue;
    }
    if (closing.has(current)) {
      const last = stack.pop();
      if (!last) {
        throw new BundlerError(sourceName + ":" + line + " has an unmatched '" + current + "'.");
      }
      const expected = opening.get(last.symbol);
      if (current !== expected) {
        throw new BundlerError(
          sourceName +
            ":" +
            line +
            " closes '" +
            last.symbol +
            "' from line " +
            last.line +
            " with '" +
            current +
            "' instead of '" +
            expected +
            "'.",
        );
      }
    }
  }

  if (state === "block-comment") {
    throw new BundlerError(sourceName + ":" + stateStartLine + " has an unterminated block comment.");
  }
  if (state === "string" || state === "character") {
    throw new BundlerError(
      sourceName + ":" + stateStartLine + " has an unterminated string or character literal.",
    );
  }
  if (stack.length > 0) {
    const last = stack.at(-1);
    throw new BundlerError(sourceName + ":" + last.line + " has an unclosed '" + last.symbol + "'.");
  }
}

function findDeclarations(source, sourceName) {
  const pattern = /^(class|extension|component|addon)\s+([A-Za-z_][A-Za-z0-9_]*)\s*$/gm;
  const declarations = [];
  let match;
  while ((match = pattern.exec(source)) !== null) {
    const line = source.slice(0, match.index).split("\n").length;
    declarations.push({ kind: match[1], name: match[2], source: sourceName, line });
  }
  return declarations;
}

async function findServerRoot(startDirectory, manifestName) {
  const checked = new Set();
  const candidates = [];
  let current = path.resolve(startDirectory);
  while (true) {
    candidates.push(current, path.join(current, "server"));
    const parent = path.dirname(current);
    if (parent === current) break;
    current = parent;
  }
  candidates.push(SCRIPT_SERVER_ROOT);

  for (const candidate of candidates) {
    const key = path.normalize(candidate).toLowerCase();
    if (checked.has(key)) continue;
    checked.add(key);
    if (await pathExists(path.join(candidate, manifestName))) return candidate;
  }
  throw new BundlerError(
    "Unable to find " + manifestName + ". Run from the repository/server directory or pass --server.",
  );
}

export async function loadProject(options = {}) {
  const manifestName = options.manifest ?? DEFAULT_MANIFEST;
  const requestedRoot = options.serverRoot
    ? path.resolve(options.serverRoot)
    : await findServerRoot(process.cwd(), manifestName);

  let serverRoot;
  try {
    const rootStats = await stat(requestedRoot);
    if (!rootStats.isDirectory()) throw new Error("not a directory");
    serverRoot = await realpath(requestedRoot);
  } catch {
    throw new BundlerError("Server directory does not exist: " + requestedRoot);
  }

  const manifestPath = resolveProjectPath(serverRoot, manifestName, "Manifest path");
  const manifestDisplayPath = slash(path.relative(serverRoot, manifestPath));
  if (!(await pathExists(manifestPath))) {
    throw new BundlerError("Manifest not found: " + manifestPath);
  }

  let raw;
  const manifestText = await readUtf8(manifestPath, "manifest");
  try {
    raw = JSON.parse(manifestText);
  } catch (error) {
    throw new BundlerError("Invalid JSON in " + manifestDisplayPath + ".", error.message);
  }
  validateManifestShape(raw, manifestDisplayPath);

  const logicOutputPath = resolveProjectPath(serverRoot, raw.logic.output, "Logic output path");
  const logicLineMapPath = resolveProjectPath(serverRoot, raw.logic.lineMap, "Logic line-map path");
  const mapTemplatePath = resolveProjectPath(serverRoot, raw.map.template, "Map template path");
  const mapOutputPath = resolveProjectPath(serverRoot, raw.map.output, "Map output path");
  const mapLineMapPath = resolveProjectPath(serverRoot, raw.map.lineMap, "Map line-map path");

  const reserved = new Map();
  for (const [label, target] of [
    ["manifest", manifestPath],
    ["logic output", logicOutputPath],
    ["logic line map", logicLineMapPath],
    ["map template", mapTemplatePath],
    ["map output", mapOutputPath],
    ["map line map", mapLineMapPath],
  ]) {
    const key = path.normalize(target).toLowerCase();
    if (reserved.has(key)) {
      throw new BundlerError(label + " conflicts with " + reserved.get(key) + ": " + target);
    }
    reserved.set(key, label);
  }

  const seenInputs = new Set();
  const sourceFiles = raw.logic.files.map((declaredPath, index) => {
    const absolutePath = resolveProjectPath(serverRoot, declaredPath, "logic.files[" + index + "]");
    const key = path.normalize(absolutePath).toLowerCase();
    if (seenInputs.has(key)) {
      throw new BundlerError("Duplicate logic input: " + declaredPath);
    }
    if (reserved.has(key)) {
      throw new BundlerError("Logic input conflicts with " + reserved.get(key) + ": " + declaredPath);
    }
    seenInputs.add(key);
    return {
      absolutePath,
      displayPath: slash(path.relative(serverRoot, absolutePath)),
    };
  });

  return {
    serverRoot,
    manifestPath,
    manifestDisplayPath,
    manifestText,
    raw,
    lineEndings: raw.lineEndings ?? "lf",
    sourceMarkers: raw.sourceMarkers ?? false,
    header: raw.header ?? false,
    failOnEmpty: raw.failOnEmpty ?? true,
    validation: {
      delimiters: raw.validation?.delimiters ?? true,
      duplicateDeclarations: raw.validation?.duplicateDeclarations ?? true,
      requireMain: raw.validation?.requireMain ?? true,
      requiredNetworkedComponents: raw.validation?.requiredNetworkedComponents ?? [],
    },
    logic: {
      outputPath: logicOutputPath,
      outputDisplayPath: slash(path.relative(serverRoot, logicOutputPath)),
      lineMapPath: logicLineMapPath,
      lineMapDisplayPath: slash(path.relative(serverRoot, logicLineMapPath)),
      sourceFiles,
    },
    map: {
      templatePath: mapTemplatePath,
      templateDisplayPath: slash(path.relative(serverRoot, mapTemplatePath)),
      outputPath: mapOutputPath,
      outputDisplayPath: slash(path.relative(serverRoot, mapOutputPath)),
      lineMapPath: mapLineMapPath,
      lineMapDisplayPath: slash(path.relative(serverRoot, mapLineMapPath)),
      logicStart: raw.map.logicStart,
      logicEnd: raw.map.logicEnd,
    },
  };
}

async function readLogicSources(project) {
  const sources = [];
  for (const sourceFile of project.logic.sourceFiles) {
    if (!(await pathExists(sourceFile.absolutePath))) {
      throw new BundlerError("Logic source is missing: " + sourceFile.displayPath);
    }
    const raw = await readUtf8(sourceFile.absolutePath, sourceFile.displayPath);
    const normalized = normalizeSource(raw);
    if (project.failOnEmpty && normalized.trim() === "") {
      throw new BundlerError("Logic source is empty: " + sourceFile.displayPath);
    }
    if (project.validation.delimiters) {
      validateDelimiters(normalized, sourceFile.displayPath);
    }
    sources.push({
      ...sourceFile,
      content: normalized,
      sha256: sha256(normalized),
    });
  }
  return sources;
}

export async function createLogicBundle(project) {
  const sources = await readLogicSources(project);
  const declarations = [];
  for (const source of sources) {
    declarations.push(...findDeclarations(source.content, source.displayPath));
  }

  if (project.validation.duplicateDeclarations) {
    const owners = new Map();
    for (const declaration of declarations) {
      const existing = owners.get(declaration.name);
      if (existing) {
        throw new BundlerError(
          "Duplicate top-level declaration '" +
            declaration.name +
            "': " +
            existing.source +
            ":" +
            existing.line +
            " and " +
            declaration.source +
            ":" +
            declaration.line +
            ".",
        );
      }
      owners.set(declaration.name, declaration);
    }
  }
  if (
    project.validation.requireMain &&
    !declarations.some((item) => item.kind === "class" && item.name === "Main")
  ) {
    throw new BundlerError("Logic bundle does not contain class Main.");
  }

  const lines = [];
  if (project.header) {
    lines.push(
      "# ============================================================================",
      "# GENERATED BY AOTTG2 MAP LOGIC BUNDLER - DO NOT EDIT",
      "# Manifest: " + project.manifestDisplayPath,
      "# Source files: " + sources.length,
      "# ============================================================================",
      "",
    );
  }

  const mappings = [];
  for (const source of sources) {
    let markerLine = null;
    if (project.sourceMarkers) {
      if (lines.length > 0 && lines.at(-1) !== "") lines.push("");
      lines.push(
        "# ============================================================================",
        "# SOURCE: " + source.displayPath,
        "# ============================================================================",
      );
      markerLine = lines.length - 1;
    }

    const sourceLines = source.content === "" ? [] : source.content.split("\n");
    const generatedStartLine = lines.length + 1;
    lines.push(...sourceLines);
    const generatedEndLine = lines.length;
    mappings.push({
      source: source.displayPath,
      sourceSha256: source.sha256,
      generatedStartLine,
      generatedEndLine,
      sourceStartLine: 1,
      sourceEndLine: sourceLines.length,
      markerLine,
    });
  }

  const lfOutput = lines.join("\n").replace(/\n*$/g, "") + "\n";
  const output = applyLineEndings(lfOutput, project.lineEndings);
  const lineMap = {
    formatVersion: 2,
    kind: "logic",
    generatedFile: project.logic.outputDisplayPath,
    manifest: project.manifestDisplayPath,
    manifestSha256: sha256(project.manifestText),
    contentSha256: sha256(output),
    lineEndings: project.lineEndings,
    sources: mappings,
  };
  const lineMapOutput = JSON.stringify(lineMap, null, 2) + "\n";

  return {
    project,
    sources,
    declarations,
    lfOutput,
    output,
    contentSha256: lineMap.contentSha256,
    lineMap,
    lineMapOutput,
  };
}

function markerIndex(lines, marker, label) {
  const matches = [];
  for (let index = 0; index < lines.length; index += 1) {
    if (lines[index].trim() === marker) matches.push(index);
  }
  if (matches.length !== 1) {
    throw new BundlerError(
      "Map template must contain exactly one " +
        label +
        " marker '" +
        marker +
        "'; found " +
        matches.length +
        ".",
    );
  }
  return matches[0];
}

function escapeRegExp(value) {
  return value.replace(/[.*+?^$()|{}[\]\\]/g, "\\$&");
}

function enableRequiredNetworkComponents(lines, endIndex, required) {
  const found = new Set();
  const enabled = new Set();

  for (let index = 0; index < endIndex; index += 1) {
    const line = lines[index];
    if (!line.startsWith("Scene,")) continue;
    const fields = line.split(",");

    for (const component of required) {
      const pattern = new RegExp("(?:^|[;,])" + escapeRegExp(component) + "\\|");
      if (!pattern.test(line)) continue;
      found.add(component);
      if (fields.length <= 7 || !/^[01]$/.test(fields[7])) {
        throw new BundlerError(
          "Cannot identify the Networked field for " +
            component +
            " on map line " +
            (index + 1) +
            ".",
        );
      }
      if (fields[7] !== "1") {
        fields[7] = "1";
        enabled.add(component);
      }
    }
    lines[index] = fields.join(",");
  }

  const missing = required.filter((component) => !found.has(component));
  if (missing.length > 0) {
    throw new BundlerError(
      "Map is missing required network component objects: " + missing.join(", ") + ".",
    );
  }
  return { found: [...found], enabled: [...enabled] };
}

export async function createMapBundle(project, logicBundle) {
  if (!(await pathExists(project.map.templatePath))) {
    throw new BundlerError("Map template is missing: " + project.map.templateDisplayPath);
  }
  const templateRaw = await readUtf8(project.map.templatePath, project.map.templateDisplayPath);
  const templateLf = normalizeSource(templateRaw);
  if (templateLf.trim() === "") {
    throw new BundlerError("Map template is empty: " + project.map.templateDisplayPath);
  }

  const templateLines = templateLf.split("\n");
  const logicStartIndex = markerIndex(templateLines, project.map.logicStart, "logic-start");
  const logicEndIndex = markerIndex(templateLines, project.map.logicEnd, "logic-end");
  if (logicEndIndex <= logicStartIndex) {
    throw new BundlerError("Map logic-end marker must appear after the logic-start marker.");
  }

  const network = enableRequiredNetworkComponents(
    templateLines,
    logicStartIndex,
    project.validation.requiredNetworkedComponents,
  );

  const logicLines = normalizeSource(logicBundle.lfOutput).split("\n");
  const prefix = templateLines.slice(0, logicStartIndex + 1);
  const suffix = templateLines.slice(logicEndIndex);
  const outputLines = [...prefix, ...logicLines, ...suffix];
  const lfOutput = outputLines.join("\n").replace(/\n*$/g, "") + "\n";
  const output = applyLineEndings(lfOutput, project.lineEndings);

  const logicOffset = prefix.length;
  const embeddedSources = logicBundle.lineMap.sources.map((source) => ({
    ...source,
    generatedStartLine: source.generatedStartLine + logicOffset,
    generatedEndLine: source.generatedEndLine + logicOffset,
    markerLine: source.markerLine === null ? null : source.markerLine + logicOffset,
  }));
  const suffixGeneratedStartLine = prefix.length + logicLines.length + 1;
  const lineMap = {
    formatVersion: 2,
    kind: "aottg2-map",
    generatedFile: project.map.outputDisplayPath,
    manifest: project.manifestDisplayPath,
    manifestSha256: sha256(project.manifestText),
    contentSha256: sha256(output),
    lineEndings: project.lineEndings,
    mapTemplate: project.map.templateDisplayPath,
    embeddedLogic: {
      generatedStartLine: prefix.length + 1,
      generatedEndLine: prefix.length + logicLines.length,
      logicFile: project.logic.outputDisplayPath,
      logicSha256: logicBundle.contentSha256,
    },
    templateSections: [
      {
        generatedStartLine: 1,
        generatedEndLine: prefix.length,
        templateStartLine: 1,
        templateEndLine: prefix.length,
      },
      {
        generatedStartLine: suffixGeneratedStartLine,
        generatedEndLine: outputLines.length,
        templateStartLine: logicEndIndex + 1,
        templateEndLine: templateLines.length,
      },
    ],
    sources: embeddedSources,
    networkedComponentsFound: network.found,
    networkedComponentsEnabledDuringBuild: network.enabled,
  };
  const lineMapOutput = JSON.stringify(lineMap, null, 2) + "\n";

  return {
    project,
    lfOutput,
    output,
    contentSha256: lineMap.contentSha256,
    lineMap,
    lineMapOutput,
    network,
  };
}

async function readIfPresent(target) {
  try {
    return await readFile(target, "utf8");
  } catch (error) {
    if (error.code === "ENOENT") return null;
    throw error;
  }
}

async function writeIfChanged(target, content) {
  const existing = await readIfPresent(target);
  if (existing === content) return false;
  await mkdir(path.dirname(target), { recursive: true });
  const temporary = target + ".tmp-" + process.pid + "-" + randomUUID();
  try {
    await writeFile(temporary, content, "utf8");
    await rename(temporary, target);
  } catch (error) {
    await rm(temporary, { force: true }).catch(() => {});
    throw error;
  }
  return true;
}

export async function createProjectBuild(options = {}, logicOnly = false) {
  const project = await loadProject(options);
  const logic = await createLogicBundle(project);
  const map = logicOnly ? null : await createMapBundle(project, logic);
  return { project, logic, map };
}

export async function writeProjectBuild(build) {
  const changes = [];
  changes.push({
    file: build.project.logic.outputDisplayPath,
    changed: await writeIfChanged(build.project.logic.outputPath, build.logic.output),
  });
  changes.push({
    file: build.project.logic.lineMapDisplayPath,
    changed: await writeIfChanged(build.project.logic.lineMapPath, build.logic.lineMapOutput),
  });
  if (build.map) {
    changes.push({
      file: build.project.map.outputDisplayPath,
      changed: await writeIfChanged(build.project.map.outputPath, build.map.output),
    });
    changes.push({
      file: build.project.map.lineMapDisplayPath,
      changed: await writeIfChanged(build.project.map.lineMapPath, build.map.lineMapOutput),
    });
  }
  return changes;
}

async function checkExpected(target, expected, displayPath, problems) {
  const existing = await readIfPresent(target);
  if (existing === null) problems.push("Generated output is missing: " + displayPath);
  else if (existing !== expected) problems.push("Generated output is stale: " + displayPath);
}

export async function checkProjectBuild(build) {
  const problems = [];
  await checkExpected(
    build.project.logic.outputPath,
    build.logic.output,
    build.project.logic.outputDisplayPath,
    problems,
  );
  await checkExpected(
    build.project.logic.lineMapPath,
    build.logic.lineMapOutput,
    build.project.logic.lineMapDisplayPath,
    problems,
  );
  if (build.map) {
    await checkExpected(
      build.project.map.outputPath,
      build.map.output,
      build.project.map.outputDisplayPath,
      problems,
    );
    await checkExpected(
      build.project.map.lineMapPath,
      build.map.lineMapOutput,
      build.project.map.lineMapDisplayPath,
      problems,
    );
  }
  return problems;
}

export function resolveGeneratedLine(lineMap, generatedLine) {
  if (!Number.isInteger(generatedLine) || generatedLine < 1) {
    throw new BundlerError("Generated line must be a positive integer.");
  }
  for (const source of lineMap.sources ?? []) {
    if (
      generatedLine >= source.generatedStartLine &&
      generatedLine <= source.generatedEndLine
    ) {
      return {
        kind: "source",
        source: source.source,
        sourceLine: source.sourceStartLine + generatedLine - source.generatedStartLine,
      };
    }
    if (source.markerLine === generatedLine) {
      return { kind: "marker", source: source.source };
    }
  }
  for (const section of lineMap.templateSections ?? []) {
    if (
      generatedLine >= section.generatedStartLine &&
      generatedLine <= section.generatedEndLine
    ) {
      return {
        kind: "template",
        source: lineMap.mapTemplate,
        sourceLine: section.templateStartLine + generatedLine - section.generatedStartLine,
      };
    }
  }
  return { kind: "generated" };
}

function parseArguments(argv) {
  const positional = [];
  const options = {};
  for (let index = 0; index < argv.length; index += 1) {
    const value = argv[index];
    if (value === "--server" || value === "-s") options.serverRoot = argv[++index];
    else if (value === "--manifest" || value === "-m") options.manifest = argv[++index];
    else if (value === "--line-map") options.lineMap = argv[++index];
    else if (value === "--logic") options.logic = true;
    else if (value === "--quiet" || value === "-q") options.quiet = true;
    else if (value === "--help" || value === "-h") options.help = true;
    else if (value === "--version" || value === "-v") options.version = true;
    else if (value.startsWith("-")) throw new BundlerError("Unknown option: " + value);
    else positional.push(value);
  }
  return { positional, options };
}

function printHelp() {
  console.log(
    [
      APP_NAME + " " + APP_VERSION,
      "",
      "Usage:",
      "  cl-bundler build [--server <directory>]",
      "  cl-bundler build-logic [--server <directory>]",
      "  cl-bundler check [--server <directory>]",
      "  cl-bundler check-logic [--server <directory>]",
      "  cl-bundler doctor [--server <directory>]",
      "  cl-bundler list [--server <directory>]",
      "  cl-bundler map <generated-line> [--logic] [--server <directory>]",
      "  cl-bundler watch [--server <directory>]",
      "",
      "build        Build the logic bundle and final playable map.",
      "build-logic  Build only the combined logic and its line map.",
      "check        Verify every generated output is current.",
      "check-logic  Verify only the generated logic outputs.",
      "doctor       Validate all inputs and assemble in memory without writing.",
      "list         Display the exact source order.",
      "map          Translate a generated error line back to its source.",
      "watch        Rebuild when the manifest, source, asset, or map changes.",
    ].join("\n"),
  );
}

function projectOptions(options) {
  return {
    serverRoot: options.serverRoot,
    manifest: options.manifest,
  };
}

async function runBuild(options, logicOnly) {
  const build = await createProjectBuild(projectOptions(options), logicOnly);
  const changes = await writeProjectBuild(build);
  if (!options.quiet) {
    for (const item of changes) {
      console.log((item.changed ? "Built: " : "Already current: ") + item.file);
    }
    console.log("Logic sources: " + build.logic.sources.length);
    console.log("Top-level declarations: " + build.logic.declarations.length);
    if (build.map) {
      console.log("Final map SHA-256: " + build.map.contentSha256);
      if (build.map.network.enabled.length > 0) {
        console.log("Enabled Networked map objects: " + build.map.network.enabled.join(", "));
      }
    }
  }
  return build;
}

async function runCheck(options, logicOnly) {
  const build = await createProjectBuild(projectOptions(options), logicOnly);
  const problems = await checkProjectBuild(build);
  if (problems.length > 0) {
    throw new BundlerError("Generated outputs are not current.", problems);
  }
  if (!options.quiet) {
    console.log(logicOnly ? "Logic outputs are current." : "All generated outputs are current.");
  }
}

async function runDoctor(options) {
  const build = await createProjectBuild(projectOptions(options), false);
  console.log("Project is valid.");
  console.log("Logic sources: " + build.logic.sources.length);
  console.log("Top-level declarations: " + build.logic.declarations.length);
  console.log("Logic lines: " + countLines(normalizeSource(build.logic.lfOutput)));
  console.log("Final map lines: " + countLines(normalizeSource(build.map.lfOutput)));
  console.log(
    "Required network components: " +
      (build.map.network.found.length > 0 ? build.map.network.found.join(", ") : "none"),
  );
}

async function runList(options) {
  const project = await loadProject(projectOptions(options));
  project.logic.sourceFiles.forEach((source, index) => {
    console.log(String(index + 1).padStart(3, " ") + ". " + source.displayPath);
  });
  console.log("Total: " + project.logic.sourceFiles.length);
}

async function runMap(options, positional) {
  if (positional.length !== 1) {
    throw new BundlerError("map requires exactly one generated line number.");
  }
  const generatedLine = Number(positional[0]);
  if (!Number.isInteger(generatedLine) || generatedLine < 1) {
    throw new BundlerError("Generated line must be a positive integer.");
  }
  const project = await loadProject(projectOptions(options));
  const selectedPath = options.lineMap
    ? resolveProjectPath(project.serverRoot, options.lineMap, "Line-map path")
    : options.logic
      ? project.logic.lineMapPath
      : project.map.lineMapPath;
  let lineMap;
  try {
    lineMap = JSON.parse(await readUtf8(selectedPath, "line map"));
  } catch (error) {
    if (error instanceof BundlerError) throw error;
    throw new BundlerError("Invalid line-map JSON: " + selectedPath, error.message);
  }
  const resolved = resolveGeneratedLine(lineMap, generatedLine);
  if (resolved.kind === "source" || resolved.kind === "template") {
    console.log(
      lineMap.generatedFile +
        ":" +
        generatedLine +
        " -> " +
        resolved.source +
        ":" +
        resolved.sourceLine,
    );
  } else if (resolved.kind === "marker") {
    console.log(
      lineMap.generatedFile + ":" + generatedLine + " is the marker for " + resolved.source + ".",
    );
  } else {
    console.log(lineMap.generatedFile + ":" + generatedLine + " is generated separator text.");
  }
}

async function runWatch(options) {
  let watchers = [];
  let timer = null;
  let running = false;
  let queued = false;

  const closeWatchers = () => {
    for (const watcher of watchers) watcher.close();
    watchers = [];
  };

  const rebuild = async () => {
    if (running) {
      queued = true;
      return;
    }
    running = true;
    try {
      const build = await runBuild(options, false);
      closeWatchers();
      const targets = [
        build.project.manifestPath,
        build.project.map.templatePath,
        ...build.project.logic.sourceFiles.map((source) => source.absolutePath),
      ];
      for (const target of targets) {
        watchers.push(
          watchFile(target, () => {
            clearTimeout(timer);
            timer = setTimeout(rebuild, 150);
          }),
        );
      }
      console.log("Watching " + targets.length + " inputs. Press Ctrl+C to stop.");
    } catch (error) {
      printError(error);
    } finally {
      running = false;
      if (queued) {
        queued = false;
        await rebuild();
      }
    }
  };

  process.on("SIGINT", () => {
    closeWatchers();
    process.exit(0);
  });
  await rebuild();
}

function printError(error) {
  if (error instanceof BundlerError) {
    console.error("Error: " + error.message);
    for (const detail of error.details) {
      if (detail) console.error("  - " + detail);
    }
  } else {
    console.error(error?.stack ?? String(error));
  }
}

export async function runCli(argv = process.argv.slice(2)) {
  try {
    const { positional, options } = parseArguments(argv);
    if (options.version) {
      console.log(APP_VERSION);
      return 0;
    }
    const command = positional.shift();
    if (options.help || !command) {
      printHelp();
      return 0;
    }
    if (command === "build") await runBuild(options, false);
    else if (command === "build-logic") await runBuild(options, true);
    else if (command === "check") await runCheck(options, false);
    else if (command === "check-logic") await runCheck(options, true);
    else if (command === "doctor") await runDoctor(options);
    else if (command === "list") await runList(options);
    else if (command === "map") await runMap(options, positional);
    else if (command === "watch") await runWatch(options);
    else {
      throw new BundlerError("Unknown command: " + command, "Run cl-bundler --help for usage.");
    }
    return 0;
  } catch (error) {
    printError(error);
    return 1;
  }
}

const isMain =
  process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url);
if (isMain) {
  process.exitCode = await runCli();
}
