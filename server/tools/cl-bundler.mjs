#!/usr/bin/env node

import { createHash, randomUUID } from "node:crypto";
import {
  access,
  mkdir,
  readFile,
  realpath,
  rename,
  rm,
  stat,
  watch as watchFileSystem,
  writeFile,
} from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import { fileURLToPath } from "node:url";

const APP_NAME = "AOTTG2 CL Bundler";
const APP_VERSION = "1.0.0";
const DEFAULT_MANIFEST = "build-order.json";
const UTF8_DECODER = new TextDecoder("utf-8", { fatal: true });

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
  return relative === "" || (!relative.startsWith(`..${path.sep}`) && relative !== ".." && !path.isAbsolute(relative));
}

function resolveProjectPath(serverRoot, relativePath, label) {
  if (typeof relativePath !== "string" || relativePath.trim() === "") {
    throw new BundlerError(`${label} must be a non-empty relative path.`);
  }
  if (path.isAbsolute(relativePath)) {
    throw new BundlerError(`${label} must be relative to the server directory: ${relativePath}`);
  }
  const resolved = path.resolve(serverRoot, relativePath);
  if (!isInside(serverRoot, resolved)) {
    throw new BundlerError(`${label} escapes the server directory: ${relativePath}`);
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
    throw new BundlerError(`Unable to read ${label}: ${target}`, error.message);
  }
  try {
    let value = UTF8_DECODER.decode(data);
    if (value.charCodeAt(0) === 0xfeff) {
      value = value.slice(1);
    }
    return value;
  } catch {
    throw new BundlerError(`${label} is not valid UTF-8: ${target}`);
  }
}

function normalizeSource(value) {
  return value.replace(/\r\n?/g, "\n").replace(/\n+$/g, "");
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
  let stringStartLine = 0;
  let blockCommentStartLine = 0;

  for (let index = 0; index < source.length; index += 1) {
    const current = source[index];
    const next = source[index + 1];

    if (current === "\n") {
      line += 1;
      if (state === "line-comment") {
        state = "code";
      }
      continue;
    }

    if (state === "line-comment") {
      continue;
    }
    if (state === "block-comment") {
      if (current === "*" && next === "/") {
        state = "code";
        index += 1;
      }
      continue;
    }
    if (state === "string") {
      if (current === "\\") {
        index += 1;
      } else if (current === '"') {
        state = "code";
      }
      continue;
    }
    if (state === "character") {
      if (current === "\\") {
        index += 1;
      } else if (current === "'") {
        state = "code";
      }
      continue;
    }

    if (current === "/" && next === "/") {
      state = "line-comment";
      index += 1;
      continue;
    }
    if (current === "/" && next === "*") {
      state = "block-comment";
      blockCommentStartLine = line;
      index += 1;
      continue;
    }
    if (current === '"') {
      state = "string";
      stringStartLine = line;
      continue;
    }
    if (current === "'") {
      state = "character";
      stringStartLine = line;
      continue;
    }
    if (opening.has(current)) {
      stack.push({ symbol: current, line });
      continue;
    }
    if (closing.has(current)) {
      const last = stack.pop();
      if (!last) {
        throw new BundlerError(`${sourceName}:${line} has an unmatched '${current}'.`);
      }
      const expected = opening.get(last.symbol);
      if (current !== expected) {
        throw new BundlerError(
          `${sourceName}:${line} closes '${last.symbol}' from line ${last.line} with '${current}' instead of '${expected}'.`,
        );
      }
    }
  }

  if (state === "block-comment") {
    throw new BundlerError(`${sourceName}:${blockCommentStartLine} has an unterminated block comment.`);
  }
  if (state === "string" || state === "character") {
    throw new BundlerError(`${sourceName}:${stringStartLine} has an unterminated string or character literal.`);
  }
  if (stack.length > 0) {
    const last = stack.at(-1);
    throw new BundlerError(`${sourceName}:${last.line} has an unclosed '${last.symbol}'.`);
  }
}

function validateManifestShape(raw, manifestDisplayPath) {
  if (!raw || typeof raw !== "object" || Array.isArray(raw)) {
    throw new BundlerError(`${manifestDisplayPath} must contain a JSON object.`);
  }
  if (typeof raw.output !== "string" || raw.output.trim() === "") {
    throw new BundlerError(`${manifestDisplayPath} must define a non-empty "output" path.`);
  }
  if (!raw.output.toLowerCase().endsWith(".cl")) {
    throw new BundlerError(`Manifest output must end in .cl: ${raw.output}`);
  }
  if (!Array.isArray(raw.files) || raw.files.length === 0) {
    throw new BundlerError(`${manifestDisplayPath} must define a non-empty "files" array.`);
  }
  for (let index = 0; index < raw.files.length; index += 1) {
    if (typeof raw.files[index] !== "string" || raw.files[index].trim() === "") {
      throw new BundlerError(`Manifest files[${index}] must be a non-empty relative path.`);
    }
    if (!raw.files[index].toLowerCase().endsWith(".cl")) {
      throw new BundlerError(`Manifest input must end in .cl: ${raw.files[index]}`);
    }
  }
  if (raw.lineMap !== undefined && (typeof raw.lineMap !== "string" || raw.lineMap.trim() === "")) {
    throw new BundlerError('Optional manifest field "lineMap" must be a non-empty relative path.');
  }
  if (raw.lineEndings !== undefined && !["lf", "crlf"].includes(raw.lineEndings)) {
    throw new BundlerError('Optional manifest field "lineEndings" must be "lf" or "crlf".');
  }
  for (const field of ["sourceMarkers", "header", "validateDelimiters", "failOnEmpty"]) {
    if (raw[field] !== undefined && typeof raw[field] !== "boolean") {
      throw new BundlerError(`Optional manifest field "${field}" must be true or false.`);
    }
  }
}

export async function loadProject(options = {}) {
  const requestedRoot = path.resolve(options.serverRoot ?? process.cwd());
  let serverRoot;
  try {
    const rootStats = await stat(requestedRoot);
    if (!rootStats.isDirectory()) {
      throw new BundlerError(`Server path is not a directory: ${requestedRoot}`);
    }
    serverRoot = await realpath(requestedRoot);
  } catch (error) {
    if (error instanceof BundlerError) {
      throw error;
    }
    throw new BundlerError(`Server directory does not exist: ${requestedRoot}`);
  }

  const manifestName = options.manifest ?? DEFAULT_MANIFEST;
  const manifestPath = resolveProjectPath(serverRoot, manifestName, "Manifest path");
  if (!(await pathExists(manifestPath))) {
    throw new BundlerError(
      `Manifest not found: ${manifestPath}`,
      `Run the command from the server root or pass --server <directory>.`,
    );
  }

  const manifestDisplayPath = slash(path.relative(serverRoot, manifestPath));
  const manifestText = await readUtf8(manifestPath, "manifest");
  let raw;
  try {
    raw = JSON.parse(manifestText);
  } catch (error) {
    throw new BundlerError(`Invalid JSON in ${manifestDisplayPath}.`, error.message);
  }
  validateManifestShape(raw, manifestDisplayPath);

  const outputPath = resolveProjectPath(serverRoot, raw.output, "Output path");
  const lineMapName = raw.lineMap ?? `${raw.output}.map.json`;
  const lineMapPath = resolveProjectPath(serverRoot, lineMapName, "Line-map path");
  const outputKey = path.normalize(outputPath).toLowerCase();
  const mapKey = path.normalize(lineMapPath).toLowerCase();
  const manifestKey = path.normalize(manifestPath).toLowerCase();

  if (outputKey === mapKey) {
    throw new BundlerError("Output and line-map paths must be different.");
  }
  if (outputKey === manifestKey || mapKey === manifestKey) {
    throw new BundlerError("Output and line-map paths cannot overwrite the manifest.");
  }

  const seen = new Map();
  const sources = [];
  for (const declaredPath of raw.files) {
    const sourcePath = resolveProjectPath(serverRoot, declaredPath, "Input path");
    const key = path.normalize(sourcePath).toLowerCase();
    if (seen.has(key)) {
      throw new BundlerError(`Input is listed more than once: ${declaredPath}`, `First occurrence: ${seen.get(key)}`);
    }
    if (key === outputKey || key === mapKey || key === manifestKey) {
      throw new BundlerError(`Input collides with a generated or configuration file: ${declaredPath}`);
    }
    seen.set(key, declaredPath);
    sources.push({ declaredPath, sourcePath });
  }

  return {
    serverRoot,
    manifestPath,
    manifestDisplayPath,
    manifestText,
    outputPath,
    outputDisplayPath: slash(path.relative(serverRoot, outputPath)),
    lineMapPath,
    lineMapDisplayPath: slash(path.relative(serverRoot, lineMapPath)),
    sourceMarkers: raw.sourceMarkers ?? true,
    header: raw.header ?? true,
    validateDelimiters: raw.validateDelimiters ?? true,
    failOnEmpty: raw.failOnEmpty ?? false,
    lineEndings: raw.lineEndings ?? "lf",
    sources,
  };
}

export async function createBundle(options = {}) {
  const project = await loadProject(options);
  const sourceFiles = [];
  const warnings = [];

  for (const source of project.sources) {
    if (!(await pathExists(source.sourcePath))) {
      throw new BundlerError(`Input file does not exist: ${source.declaredPath}`);
    }
    const sourceStats = await stat(source.sourcePath);
    if (!sourceStats.isFile()) {
      throw new BundlerError(`Input path is not a file: ${source.declaredPath}`);
    }
    const canonicalPath = await realpath(source.sourcePath);
    if (!isInside(project.serverRoot, canonicalPath)) {
      throw new BundlerError(`Input resolves outside the server directory: ${source.declaredPath}`);
    }
    const text = normalizeSource(await readUtf8(source.sourcePath, source.declaredPath));
    if (text.trim() === "") {
      const message = `Input file is empty: ${source.declaredPath}`;
      if (project.failOnEmpty) {
        throw new BundlerError(message);
      }
      warnings.push(message);
    }
    if (project.validateDelimiters) {
      validateDelimiters(text, source.declaredPath);
    }
    sourceFiles.push({ ...source, text });
  }

  const lines = [];
  const mappings = [];

  if (project.header) {
    lines.push("// ============================================================================");
    lines.push("// GENERATED BY AOTTG2 CL BUNDLER - DO NOT EDIT THIS FILE DIRECTLY");
    lines.push(`// Manifest: ${project.manifestDisplayPath}`);
    lines.push(`// Source files: ${sourceFiles.length}`);
    lines.push("// ============================================================================");
    lines.push("");
  }

  for (const source of sourceFiles) {
    const markerStartLine = project.sourceMarkers ? lines.length + 1 : null;
    if (project.sourceMarkers) {
      lines.push("// ============================================================================");
      lines.push(`// SOURCE: ${slash(source.declaredPath)}`);
      lines.push("// ============================================================================");
    }

    const sourceLines = source.text === "" ? [] : source.text.split("\n");
    const generatedStartLine = sourceLines.length > 0 ? lines.length + 1 : null;
    lines.push(...sourceLines);
    const generatedEndLine = sourceLines.length > 0 ? lines.length : null;

    mappings.push({
      source: slash(source.declaredPath),
      sourceLineCount: sourceLines.length,
      markerStartLine,
      generatedStartLine,
      generatedEndLine,
      contentSha256: sha256(source.text),
    });
    lines.push("");
  }

  const lfOutput = `${lines.join("\n")}\n`;
  const output = project.lineEndings === "crlf" ? lfOutput.replace(/\n/g, "\r\n") : lfOutput;
  const contentSha256 = sha256(output);
  const lineMap = {
    formatVersion: 1,
    generator: `${APP_NAME} ${APP_VERSION}`,
    generatedFile: project.outputDisplayPath,
    manifest: project.manifestDisplayPath,
    lineEndings: project.lineEndings,
    generatedLineCount: lines.length,
    contentSha256,
    sources: mappings,
  };
  const lineMapOutput = `${JSON.stringify(lineMap, null, 2)}\n`;

  return { project, output, lineMap, lineMapOutput, warnings, contentSha256 };
}

async function readIfPresent(target) {
  try {
    return await readFile(target, "utf8");
  } catch (error) {
    if (error.code === "ENOENT") {
      return null;
    }
    throw error;
  }
}

async function writeIfChanged(target, content) {
  const existing = await readIfPresent(target);
  if (existing === content) {
    return false;
  }
  await mkdir(path.dirname(target), { recursive: true });
  const temporary = `${target}.tmp-${process.pid}-${randomUUID()}`;
  try {
    await writeFile(temporary, content, "utf8");
    await rename(temporary, target);
  } catch (error) {
    await rm(temporary, { force: true });
    throw error;
  }
  return true;
}

export async function buildProject(options = {}) {
  const bundle = await createBundle(options);
  const outputChanged = await writeIfChanged(bundle.project.outputPath, bundle.output);
  const mapChanged = await writeIfChanged(bundle.project.lineMapPath, bundle.lineMapOutput);
  return { ...bundle, outputChanged, mapChanged };
}

export async function checkProject(options = {}) {
  const bundle = await createBundle(options);
  const existingOutput = await readIfPresent(bundle.project.outputPath);
  const existingMap = await readIfPresent(bundle.project.lineMapPath);
  const problems = [];
  if (existingOutput === null) {
    problems.push(`Generated output is missing: ${bundle.project.outputDisplayPath}`);
  } else if (existingOutput !== bundle.output) {
    problems.push(`Generated output is stale: ${bundle.project.outputDisplayPath}`);
  }
  if (existingMap === null) {
    problems.push(`Line map is missing: ${bundle.project.lineMapDisplayPath}`);
  } else if (existingMap !== bundle.lineMapOutput) {
    problems.push(`Line map is stale: ${bundle.project.lineMapDisplayPath}`);
  }
  return { ...bundle, problems, valid: problems.length === 0 };
}

export function resolveGeneratedLine(lineMap, generatedLine) {
  if (!Number.isSafeInteger(generatedLine) || generatedLine < 1) {
    throw new BundlerError("Generated line must be a positive integer.");
  }
  if (!lineMap || !Array.isArray(lineMap.sources)) {
    throw new BundlerError("Invalid line-map file.");
  }
  for (const source of lineMap.sources) {
    if (
      source.generatedStartLine !== null &&
      generatedLine >= source.generatedStartLine &&
      generatedLine <= source.generatedEndLine
    ) {
      return {
        kind: "source",
        generatedLine,
        source: source.source,
        sourceLine: generatedLine - source.generatedStartLine + 1,
      };
    }
    if (
      source.markerStartLine !== null &&
      generatedLine >= source.markerStartLine &&
      generatedLine < (source.generatedStartLine ?? source.markerStartLine + 3)
    ) {
      return { kind: "marker", generatedLine, source: source.source };
    }
  }
  return { kind: "generated", generatedLine };
}

async function discoverServerRoot(startDirectory, manifestName) {
  let current = path.resolve(startDirectory);
  while (true) {
    if (await pathExists(path.join(current, manifestName))) {
      return current;
    }
    const parent = path.dirname(current);
    if (parent === current) {
      return path.resolve(startDirectory);
    }
    current = parent;
  }
}

function parseArguments(argv) {
  const options = {};
  const positional = [];
  for (let index = 0; index < argv.length; index += 1) {
    const value = argv[index];
    if (value === "--server" || value === "-s") {
      if (!argv[index + 1]) throw new BundlerError(`${value} requires a directory.`);
      options.serverRoot = argv[++index];
    } else if (value === "--manifest" || value === "-m") {
      if (!argv[index + 1]) throw new BundlerError(`${value} requires a relative path.`);
      options.manifest = argv[++index];
    } else if (value === "--line-map") {
      if (!argv[index + 1]) throw new BundlerError(`${value} requires a path.`);
      options.lineMap = argv[++index];
    } else if (value === "--quiet" || value === "-q") {
      options.quiet = true;
    } else if (value === "--help" || value === "-h") {
      options.help = true;
    } else if (value === "--version" || value === "-v") {
      options.version = true;
    } else if (value.startsWith("-")) {
      throw new BundlerError(`Unknown option: ${value}`);
    } else {
      positional.push(value);
    }
  }
  return { options, positional };
}

function printHelp() {
  console.log(`${APP_NAME} ${APP_VERSION}

Usage:
  cl-bundler build [--server <directory>] [--manifest <path>]
  cl-bundler watch [--server <directory>] [--manifest <path>]
  cl-bundler check [--server <directory>] [--manifest <path>]
  cl-bundler list  [--server <directory>] [--manifest <path>]
  cl-bundler map <generated-line> [--server <directory>] [--manifest <path>]

Commands:
  build   Validate and combine every source in manifest order.
  watch   Build once, then rebuild when source or manifest files change.
  check   Verify generated output and its line map are current; write nothing.
  list    Print the exact source order that will be bundled.
  map     Translate an AOTTG runtime line number back to its source file.

Defaults:
  The server root is discovered by walking upward from the current directory
  until build-order.json is found. --server overrides discovery.`);
}

function reportError(error) {
  if (error instanceof BundlerError) {
    console.error(`Error: ${error.message}`);
    for (const detail of error.details) {
      if (detail) console.error(`  ${detail}`);
    }
    return;
  }
  console.error(error?.stack ?? String(error));
}

function reportWarnings(warnings) {
  for (const warning of warnings) {
    console.warn(`Warning: ${warning}`);
  }
}

function reportBuild(result, quiet = false) {
  reportWarnings(result.warnings);
  if (quiet) return;
  const state = result.outputChanged || result.mapChanged ? "Built" : "Already current";
  console.log(`${state}: ${result.project.outputDisplayPath}`);
  console.log(`Sources: ${result.project.sources.length}`);
  console.log(`SHA-256: ${result.contentSha256}`);
  console.log(`Line map: ${result.project.lineMapDisplayPath}`);
}

async function watchProject(options) {
  let currentProject;
  try {
    const initial = await buildProject(options);
    currentProject = initial.project;
    reportBuild(initial, options.quiet);
  } catch (error) {
    reportError(error);
  }

  const serverRoot = path.resolve(options.serverRoot);
  let timer = null;
  let building = false;
  let queued = false;

  const rebuild = async () => {
    if (building) {
      queued = true;
      return;
    }
    building = true;
    try {
      const result = await buildProject(options);
      currentProject = result.project;
      if (result.outputChanged || result.mapChanged) {
        reportBuild(result, options.quiet);
      } else {
        reportWarnings(result.warnings);
      }
    } catch (error) {
      reportError(error);
    } finally {
      building = false;
      if (queued) {
        queued = false;
        await rebuild();
      }
    }
  };

  const watcher = watchFileSystem(serverRoot, { recursive: true });
  console.log(`Watching: ${serverRoot}`);
  console.log("Press Ctrl+C to stop.");

  for await (const event of watcher) {
    const eventPath = event.filename ? path.resolve(serverRoot, event.filename) : null;
    if (eventPath && currentProject) {
      const key = path.normalize(eventPath).toLowerCase();
      if (
        key === path.normalize(currentProject.outputPath).toLowerCase() ||
        key === path.normalize(currentProject.lineMapPath).toLowerCase()
      ) {
        continue;
      }
    }
    clearTimeout(timer);
    timer = setTimeout(rebuild, 300);
  }
}

async function runCli() {
  const { options, positional } = parseArguments(process.argv.slice(2));
  if (options.version) {
    console.log(APP_VERSION);
    return 0;
  }

  const command = positional.shift();
  if (options.help || !command) {
    printHelp();
    return options.help ? 0 : 2;
  }

  const manifest = options.manifest ?? DEFAULT_MANIFEST;
  const serverRoot = options.serverRoot
    ? path.resolve(options.serverRoot)
    : await discoverServerRoot(process.cwd(), manifest);
  const projectOptions = { serverRoot, manifest };

  if (command === "build") {
    if (positional.length > 0) throw new BundlerError(`Unexpected argument: ${positional[0]}`);
    reportBuild(await buildProject(projectOptions), options.quiet);
    return 0;
  }
  if (command === "check") {
    if (positional.length > 0) throw new BundlerError(`Unexpected argument: ${positional[0]}`);
    const result = await checkProject(projectOptions);
    reportWarnings(result.warnings);
    if (!result.valid) {
      for (const problem of result.problems) console.error(problem);
      return 1;
    }
    if (!options.quiet) console.log(`Current: ${result.project.outputDisplayPath}`);
    return 0;
  }
  if (command === "list") {
    if (positional.length > 0) throw new BundlerError(`Unexpected argument: ${positional[0]}`);
    const project = await loadProject(projectOptions);
    project.sources.forEach((source, index) => {
      console.log(`${String(index + 1).padStart(3, " ")}. ${slash(source.declaredPath)}`);
    });
    return 0;
  }
  if (command === "map") {
    if (positional.length !== 1) throw new BundlerError("map requires exactly one generated line number.");
    const generatedLine = Number(positional[0]);
    const project = await loadProject(projectOptions);
    const mapPath = options.lineMap
      ? resolveProjectPath(project.serverRoot, options.lineMap, "Line-map path")
      : project.lineMapPath;
    let lineMap;
    try {
      lineMap = JSON.parse(await readUtf8(mapPath, "line map"));
    } catch (error) {
      if (error instanceof BundlerError) throw error;
      throw new BundlerError(`Invalid line-map JSON: ${mapPath}`, error.message);
    }
    const resolved = resolveGeneratedLine(lineMap, generatedLine);
    if (resolved.kind === "source") {
      console.log(`${lineMap.generatedFile}:${generatedLine} -> ${resolved.source}:${resolved.sourceLine}`);
    } else if (resolved.kind === "marker") {
      console.log(`${lineMap.generatedFile}:${generatedLine} is the generated marker for ${resolved.source}.`);
    } else {
      console.log(`${lineMap.generatedFile}:${generatedLine} is generated wrapper or separator text.`);
    }
    return 0;
  }
  if (command === "watch") {
    if (positional.length > 0) throw new BundlerError(`Unexpected argument: ${positional[0]}`);
    await watchProject({ ...projectOptions, quiet: options.quiet });
    return 0;
  }
  throw new BundlerError(`Unknown command: ${command}`, "Run cl-bundler --help for usage.");
}

const invokedPath = process.argv[1] ? path.resolve(process.argv[1]) : "";
const modulePath = fileURLToPath(import.meta.url);
if (invokedPath === modulePath) {
  try {
    process.exitCode = await runCli();
  } catch (error) {
    reportError(error);
    process.exitCode = 2;
  }
}
