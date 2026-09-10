#!/usr/bin/env node

import { randomUUID } from "node:crypto";
import { mkdir, readFile, rename, rm, writeFile } from "node:fs/promises";
import path from "node:path";
import process from "node:process";
import { fileURLToPath } from "node:url";

function parseArguments(argv) {
  const options = {};
  for (let index = 0; index < argv.length; index += 1) {
    const value = argv[index];
    if (value === "--input" || value === "-i") options.input = argv[++index];
    else if (value === "--check") options.check = true;
    else throw new Error("Unknown argument: " + value);
  }
  return options;
}

function extractDeclaration(source, name) {
  const declarationPattern = /^(class|extension|component|addon)\s+([A-Za-z_][A-Za-z0-9_]*)\s*$/gm;
  const declarations = [];
  let match;
  while ((match = declarationPattern.exec(source)) !== null) {
    declarations.push({ name: match[2], index: match.index });
  }
  const targetIndex = declarations.findIndex((item) => item.name === name);
  if (targetIndex < 0) throw new Error("Unable to find declaration: " + name);
  const start = declarations[targetIndex].index;
  const end =
    targetIndex + 1 < declarations.length ? declarations[targetIndex + 1].index : source.length;
  return source.slice(start, end).replace(/\n+$/g, "") + "\n";
}

async function writeAtomic(target, content) {
  await mkdir(path.dirname(target), { recursive: true });
  const temporary = target + ".tmp-" + process.pid + "-" + randomUUID();
  try {
    await writeFile(temporary, content, "utf8");
    await rename(temporary, target);
  } catch (error) {
    await rm(temporary, { force: true }).catch(() => {});
    throw error;
  }
}

const options = parseArguments(process.argv.slice(2));
if (!options.input) {
  console.error(
    "Usage: node tools/generate-gacha-assets.mjs --input <combined-GachaAssets.cl> [--check]",
  );
  process.exit(2);
}

const serverRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const inputPath = path.resolve(process.cwd(), options.input);
const source = (await readFile(inputPath, "utf8")).replace(/\r\n?/g, "\n");
const outputs = [
  {
    path: path.join(serverRoot, "assets", "gacha", "Sprites.generated.cl"),
    content: extractDeclaration(source, "Sprites"),
  },
  {
    path: path.join(serverRoot, "assets", "gacha", "Descriptions.generated.cl"),
    content: extractDeclaration(source, "DescriptionsEnum"),
  },
];

if (options.check) {
  const stale = [];
  for (const output of outputs) {
    let existing = null;
    try {
      existing = (await readFile(output.path, "utf8")).replace(/\r\n?/g, "\n");
    } catch {}
    if (existing !== output.content) stale.push(output.path);
  }
  if (stale.length > 0) {
    console.error("Generated gacha assets are missing or stale:");
    for (const item of stale) console.error("  - " + item);
    process.exit(1);
  }
  console.log("Generated gacha assets are current.");
} else {
  for (const output of outputs) {
    await writeAtomic(output.path, output.content);
    console.log("Generated: " + output.path);
  }
}
