# Contributing

Thank you for contributing to this project. This document defines the minimum engineering and documentation standards for changes to the repository.

The project is maintained as modular source but deployed as one generated Custom Logic file. Contributors are responsible for understanding both views.

## Core principles

Every contribution should preserve the following properties:

- **Correctness:** Behavior is valid in the execution contexts where it can run.
- **Authority:** Only the intended client owns authoritative mutations.
- **Traceability:** Generated behavior can be traced to a source file and documented contract.
- **Determinism:** Identical sources and manifests produce identical deployment output.
- **Recoverability:** Late joins, retries, host changes, and partial failures do not silently corrupt state.
- **Efficiency:** Network properties, persistence, and UI updates are performed only when necessary.
- **Maintainability:** Public behavior and non-obvious dependencies are documented alongside the change.

## Before starting work

1. Read [the architecture](docs/architecture.md) and [runtime model](docs/runtime-model.md).
2. Find the existing module page under `docs/modules/`.
3. Find any affected registries under `docs/reference/`.
4. Determine whether the change affects build order, initialization, authority, persistence, networking, UI, or compatibility.
5. Discuss the design before implementation when it introduces a new subsystem, persistent schema, externally visible command, or incompatible contract.

## Development setup

The build tool requires Node.js 20 or newer and has no third-party runtime dependencies.

From the repository root:

```powershell
.\tools\cl-bundler.cmd build
.\tools\cl-bundler.cmd check
```

For continuous development:

```powershell
.\tools\cl-bundler.cmd watch
```

Use the direct Node command on platforms that do not run the Windows launcher:

```text
node tools/cl-bundler.mjs <command>
```

## Source-of-truth policy

The authoritative inputs are:

- files under `src/`;
- `build-order.json`;
- project tooling under `tools/`;
- human-maintained documentation.

`dist/Server.cl` and its line map are generated artifacts. Do not edit them manually, even for a one-line correction. Make the change in `src/` and rebuild.

A source file is included at runtime only when it appears in `build-order.json`. Creating a file under `src/` without adding it to the manifest has no effect on the final server.

## Choosing a source location

| Location | Appropriate content |
|---|---|
| `src/core/` | Shared configuration, generic helpers, foundational state abstractions, and root composition. |
| `src/systems/` | Gameplay rules, authoritative state transitions, integrations, and substantial services. |
| `src/ui/` | Local presentation state, screens, HUD components, and UI input. |
| `src/commands/` | Command parsing, validation, permission checks, and calls into system APIs. |
| `src/misc/` | Small adapters that genuinely cross established categories. A new substantial feature does not belong here. |

When no existing location fits, propose a new focused directory or module instead of expanding `misc` indefinitely.

## Source-file boundaries

Files are concatenated, but they must be independently understandable.

- Keep complete declarations in one file.
- Do not split a class body across files.
- Prefer one primary class or one cohesive group of declarations per file.
- Keep initialization and event forwarding separate from business rules when practical.
- Expose a narrow public contract rather than allowing unrelated modules to modify internal state directly.
- Document cross-file dependencies; never rely on a contributor inferring them from a call name.
- Avoid circular dependencies. When two modules require each other, move their shared contract into a lower-level module.

Every substantial source file should begin with:

```c
// Module: <module name>
// Documentation: docs/modules/<module-name>.md
// Responsibility: <single sentence>
// Runtime: <master, all clients, local client, or mixed>
// Depends on: <symbols or modules, or None>
// Used by: <symbols or modules>
// Persistent state: <keys or None>
```

These comments remain useful in both the modular source and generated output.

## Build-order changes

`build-order.json` is executable configuration and must receive the same review as source code.

When adding or moving a source file:

1. Add it to `files` exactly once.
2. Place it deliberately relative to its dependencies and consumers.
3. Run `cl-bundler list` and inspect the effective order.
4. Build the project.
5. Confirm that generated section markers appear in the expected position.
6. Update architecture or module documentation when the dependency structure changed.

Do not reorder unrelated files merely for aesthetics. Large ordering changes make generated diffs difficult to review and may alter runtime behavior.

## Runtime authority

An event handler executing on a client does not automatically give that client authority to mutate shared state.

Before implementing a state change, document:

- where the initiating event is observed;
- which client validates it;
- which client commits it;
- how other clients receive the result;
- whether retries can apply it more than once;
- how a late joiner reconstructs the result;
- what happens if the master client changes.

As a baseline:

- The master client owns shared gameplay state and world mutations unless a module explicitly establishes another authority model.
- Local clients own their input and presentation state.
- UI code reads authoritative state and requests actions; it does not silently become the authoritative writer.
- Persistent-data changes must be validated and idempotent or deduplicated.
- Network writes occur on meaningful changes, not every frame.

See [runtime-model.md](docs/runtime-model.md) for the complete contract.

## State and data changes

Every newly introduced state value must identify:

- name and type;
- default value;
- authoritative writer;
- permitted readers;
- lifetime;
- synchronization mechanism;
- persistence behavior;
- validation rules;
- migration or compatibility behavior, when persisted.

Add shared values to the appropriate registry under `docs/reference/`. Do not create multiple keys for the same concept or reuse a key with a different type.

Persistent data must not be saved on every display update or frame. Mark it dirty, batch compatible changes, and flush at documented durability boundaries. Delta-based mutations require unique request identity or another deduplication strategy.

## Commands

Command handlers should be thin adapters:

1. Parse arguments.
2. Validate syntax and permissions.
3. Resolve target players or entities.
4. Call the owning system's public function.
5. Present the result to the appropriate audience.

Do not duplicate gameplay rules inside command files. Document new or modified commands in the command reference, including syntax, permissions, authority, side effects, error messages, and examples.

## UI changes

UI should display state without owning shared gameplay rules.

- Keep local visibility and layout preferences local.
- Separate the state calculation from label formatting.
- Avoid network or database writes from per-frame UI refreshes.
- Update text or layout only when the displayed value changes or at a documented refresh interval.
- Assign stable and documented UI identifiers.
- Account for different resolutions, UI scaling, and fast-paced gameplay visibility.
- Ensure a missing character, unloaded player, or unavailable dataset does not produce a runtime exception.

## Error handling and diagnostics

Expected failures should produce actionable messages without flooding the game console or chat.

- Include the subsystem and operation in diagnostic messages
- Retain enough context to reproduce the failure without exposing sensitive values.
- Rate-limit repeated warnings.

Use the generated line mapper for AOTTG runtime errors:

```powershell
.\tools\cl-bundler.cmd map <generated-line>
```

## Documentation requirements

Update documentation in the same change whenever behavior affects:

- a module responsibility or dependency;
- a public function or shared contract;
- initialization or shutdown order;
- a command, permission, or syntax;
- an event or callback;
- a custom property or persistent field;
- compatibility with previously stored or synchronized state

Private implementation details only need documentation when they are non-obvious, order-sensitive, or dangerous to change.

New substantial modules must use [the module template](docs/templates/module.md). New shared registries should use [the reference template](docs/templates/reference.md).
