# Documentation

This directory describes how the project is assembled, how it behaves at runtime, and which contracts contributors may rely on. It exists because the repository's modular source layout and AOTTG2's single-file runtime present two different views of the same program.

The documentation is part of the project contract. Source changes that alter a documented contract must update the corresponding page in the same contribution.

## Documentation map

| Area | Document | Use it to understand |
|---|---|---|
| Project overview | [Root README](../README.md) | The repository layout, build commands, and contributor entry point. |
| Contribution rules | [CONTRIBUTING.md](CONTRIBUTING.md) | Required design, implementation, verification, and review practices. |
| Architecture | [architecture.md](architecture.md) | Layers, dependency direction, source boundaries, the bundling pipeline, and system ownership. |
| Runtime | [runtime-model.md](runtime-model.md) | Execution contexts, authority, synchronization, state lifetimes, timing, and recovery. |
| Modules | [modules/README.md](modules/README.md) | The catalog of gameplay systems, commands, UI components, integrations, and core services. |
| Reference | [reference/README.md](reference/README.md) | Shared names and exact contracts such as commands, events, properties, schemas, and UI identifiers. |
| Templates | [templates/module.md](templates/module.md) and [templates/reference.md](templates/reference.md) | Starting structures for new documentation pages. |

## How the documentation is organized

The documentation has four levels. Each answers a different kind of question.

### 1. Repository guidance

The root `README.md` explains how to obtain, build, inspect, and deploy the project. `CONTRIBUTING.md` defines the rules a proposed change must follow.

These pages should remain concise enough to serve as entry points. Detailed subsystem behavior belongs below `docs/`.

### 2. Architectural guidance

`architecture.md` and `runtime-model.md` describe constraints that apply across the project. They answer questions such as:

- Which directory owns a particular responsibility?
- May UI code mutate this value?
- Which client is authoritative for this operation?
- How does a late joiner obtain the current state?
- When is a persistent mutation considered durable?
- How does a generated runtime line map back to source?

### 3. Module documentation

Each substantial unit of behavior receives a page under `modules/`. A module is a repository-level organization concept: one cohesive responsibility with a defined owner, public surface, state, lifecycle, and set of dependencies.

A module does not imply a Custom Logic namespace, package, separate compilation unit, or isolated runtime. Its declarations become part of the same `dist/Server.cl` program as every other included source file.

Module pages explain behavior and ownership. Use the [module template](templates/module.md) when creating one.

### 4. Reference documentation

Pages under `reference/` define exact, shared contracts. Examples include:

- chat command names and arguments;
- game and custom event meanings;
- custom property names and types;
- persistent field names and compatibility rules;
- configuration keys and defaults;
- UI identifiers;
- error or diagnostic codes.

Reference pages should be optimized for lookup. They complement module pages rather than repeating their design narrative. Use the [reference template](templates/reference.md) for a new registry.

## Source, output, and documentation

The same project is represented in three forms:

| Form | Purpose | Authority |
|---|---|---|
| `src/**/*.cl` | Human-maintained implementation. | Authoritative for code behavior. |
| `build-order.json` | Inclusion and concatenation order. | Authoritative for which source reaches the runtime and in what order. |
| `dist/Server.cl` | Generated file loaded by AOTTG2. | Authoritative only as a reproducible deployment artifact; never edit it directly. |
| `docs/**/*.md` | Intended contracts, boundaries, and contributor knowledge. | Authoritative for the documented design and maintenance expectations. |

If implementation and documentation disagree, treat the mismatch as a defect. Determine whether the implementation or documented contract is intended, then update both to agree. Do not silently preserve a contradiction.

## Normative language

The terms **MUST**, **MUST NOT**, **SHOULD**, **SHOULD NOT**, and **MAY** indicate requirement strength:

- **MUST** and **MUST NOT** describe requirements necessary for correctness, safety, compatibility, or repository consistency.
- **SHOULD** and **SHOULD NOT** describe the expected approach. A deviation needs a documented reason.
- **MAY** describes an optional technique or behavior.

Ordinary prose that does not use these terms is explanatory unless a page explicitly says otherwise.

## Document status

Module and reference pages should declare one of these statuses:

| Status | Meaning |
|---|---|
| `Proposed` | The design is under discussion and is not a stable contract. |
| `Experimental` | Implemented or being implemented, but compatibility is not promised. |
| `Stable` | Contributors may rely on the documented contract. Breaking changes require migration planning. |
| `Deprecated` | Still present for compatibility but scheduled for removal or replacement. |
| `Removed` | No longer available; the page remains only as migration history. |

## Adding documentation

1. Decide whether the information is architectural, module-specific, or an exact shared reference.
2. Copy the appropriate template from `docs/templates/`.
3. Rename the page using lowercase kebab-case, such as `player-progression.md`.
4. Replace every template instruction and placeholder.
5. Add the page to the appropriate index.
6. Link the related source header to the page.
7. Verify every relative link and render the Markdown before requesting review.

## Avoiding documentation drift

Documentation ownership follows code ownership. A contributor changing a public contract owns the associated documentation update, even when the page was originally written by someone else.

During review, verify claims against `src/` and `build-order.json`, not only against generated output. Generated output is valuable for deployment and line diagnosis, but it obscures logical file ownership and should not become the documentation source.
