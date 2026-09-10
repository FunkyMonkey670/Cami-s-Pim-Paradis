#!/usr/bin/env node

import { spawnSync } from "node:child_process";
import path from "node:path";
import process from "node:process";
import { fileURLToPath } from "node:url";

const toolsDirectory = path.dirname(fileURLToPath(import.meta.url));
const serverRoot = path.resolve(toolsDirectory, "..");
const bundler = path.join(toolsDirectory, "cl-bundler.mjs");
const result = spawnSync(
  process.execPath,
  [bundler, "doctor", "--server", serverRoot, ...process.argv.slice(2)],
  { stdio: "inherit" },
);

if (result.error) throw result.error;
process.exitCode = result.status ?? 1;
