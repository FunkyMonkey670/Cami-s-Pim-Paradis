#!/usr/bin/env node

import { mkdir, readFile, rename, rm, writeFile } from "node:fs/promises";
import { randomUUID } from "node:crypto";
import path from "node:path";
import process from "node:process";
import { fileURLToPath } from "node:url";

function parseArguments(argv) {
  const options = {};
  for (let index = 0; index < argv.length; index += 1) {
    const key = argv[index];
    if (key === "--input" || key === "-i") options.input = argv[++index];
    else if (key === "--output" || key === "-o") options.output = argv[++index];
    else throw new Error("Unknown argument: " + key);
  }
  return options;
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
    "Usage: node tools/prepare-map-source.mjs --input <working-full-map.txt> [--output map/PimParadis.source.txt]",
  );
  process.exit(2);
}

const serverRoot = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const inputPath = path.resolve(process.cwd(), options.input);
const outputPath = options.output
  ? path.resolve(process.cwd(), options.output)
  : path.join(serverRoot, "map", "PimParadis.source.txt");

if (inputPath.toLowerCase() === outputPath.toLowerCase()) {
  throw new Error("Input and output must be different files.");
}

const input = (await readFile(inputPath, "utf8")).replace(/\r\n?/g, "\n");
const lines = input.replace(/\n+$/g, "").split("\n");
const logicIndexes = lines
  .map((line, index) => (line.trim() === "/// Logic" ? index : -1))
  .filter((index) => index >= 0);
const weatherIndexes = lines
  .map((line, index) => (line.trim() === "/// Weather" ? index : -1))
  .filter((index) => index >= 0);

if (logicIndexes.length !== 1 || weatherIndexes.length !== 1) {
  throw new Error("Input must contain exactly one /// Logic and one /// Weather marker.");
}
const logicIndex = logicIndexes[0];
const weatherIndex = weatherIndexes[0];
if (weatherIndex <= logicIndex) {
  throw new Error("/// Weather must occur after /// Logic.");
}

const output = [...lines.slice(0, logicIndex + 1), ...lines.slice(weatherIndex)].join("\n") + "\n";
await writeAtomic(outputPath, output);
console.log("Prepared map source: " + outputPath);
console.log("Removed embedded logic lines: " + (weatherIndex - logicIndex - 1));
