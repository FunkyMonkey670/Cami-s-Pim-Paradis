# AOTTG2 Pim's Paradis Project

This repository contains a modular CL project. Development is divided across `.cl` files for maintainability, efficiency, and collaboration. The result is still a singular compiled Custom-Logic file: `dist/Server.cl`.

The source files in this repository are not independent programs or language-level modules. They are ordered fragments of one final program. The build tool validates them and combines them according to `build-order.json`.

## Project Status

The repository structure and contributor workflow are established. Feature-specific documentation will be completed as the original Custom-Logic script is separated into modules.

Until a feature is documented as stable, contributors/collaborators should treat its public functions, state keys, and runtime behavior as subject to change.

### Source directories

| Directory | Responsibility |
|---|---|
| `src/core/` | Configuration, shared utilities, foundational types, and application composition. |
| `src/systems/` | Authoritative gameplay and service logic. |
| `src/ui/` | Client-facing presentation and UI interaction. |
| `src/commands/` | Chat-command parsing, permission checks, and delegation to systems. |
| `src/misc/` | Small cross-cutting adapters that do not belong to another established module. (This directory must not become an undocumented bin) |
| `tools/` | Build and repository-development tooling. Tool code does not become part of `Server.cl`. |
| `dist/` | Compiled output |

Directory boundaries organize the repository; they do not create namespaces or runtime isolation in CL.

### Requirements

- Node.js 20+
- AOTTG2

The bundler has no third-party runtime dependencies.

### Build the server

From the repository root:

```powershell
.\tools\cl-bundler.cmd build
```

Or invoke the portable script directly:

```powershell
node .\tools\cl-bundler.mjs build
```

The build produces:

```text
dist/Server.cl
dist/Server.cl.map.json
```

### Rebuild Automatically

```powershell
.\tools\cl-bundler.cmd watch
```

Watch-mode performs an initial build and rebuilds after source or manifest changes.

### Verify compiled output

```powershell
.\tools\cl-bundler.cmd check
```

`check` writes nothing. It exits unsuccessfully when the compiled output or line-map is missing or older than the current sources. This is the preferred CI validation command.

### Inspect build order

```powershell
.\tools\cl-bundler.cmd list
```

The displayed order is the exact order used in `dist/Server.cl`.

## Working with modular Custom Logic

Cross-file references are expected. For example, a command in `src/commands/` may call a class declared in `src/systems/`, and a UI component may read state exposed by a core service. These symbols resolve after concatenation.

Every source file must nevertheless remain a structurally complete fragment:

- Keep a complete class or related set of complete declarations in one file.
- Do not open a class in one file and close it in another
- Do not depend on filesystem enumeration or alphabetical ordering.
- Add every new source file to `build-order.json` exactly once.
- Document dependencies and consumers in the source header and corresponding module page.
- Keep initialization in an intentional order and explain order-sensitive behavior.

The standard source header is:

```c
// Module: Example
// Documentation: docs/modules/example.md
// Responsibility: One-sentence description of the module's purpose.
// Runtime: Master authority; all clients read synchronized state.
// Depends on: Config, Utilities
// Used by: Main, ExampleCommand, ExampleUI
// Persistent state: None
```

Use the full [module documentation template](docs/templates/module.md) for substantial features.

## Documentation

Start with the [documentation index](docs/README.md).

| Document | Purpose |
|---|---|
| [Architecture](docs/architecture.md) | Repository layers, dependency direction, build pipeline, and system boundaries. |
| [Runtime model](docs/runtime-model.md) | Execution context, authority, state lifetime, synchronization, timing, and failure behavior. |
| [Module index](docs/modules/README.md) | Feature and subsystem documentation. |
| [Reference index](docs/reference/README.md) | Shared identifiers, commands, events, schemas, and other cross-module contracts. |
| [Contributing](CONTRIBUTING.md) | Required development, validation, review, and documentation workflow. |

Documentation is part of the implementation. A change is incomplete when it changes a public function, command, event, state key, persistence field, UI identifier, dependency, or runtime responsibility without updating its documentation.

## Generated files

The generated files may be committed when convenient for deployment and review, but they are never independently authoritative. A valid generated artifact must be reproducible from the committed manifest, tooling, and source files.

Generated section markers identify each original file inside `Server.cl`. The accompanying line map provides exact line translation without depending on those comments manually.

## Contributing

Read [CONTRIBUTING.md](CONTRIBUTING.md) before modifying source or documentation. In particular:

1. Determine the correct runtime authority and state owner before writing behavior.
2. Place code in the narrowest appropriate module.
3. Update `build-order.json` when adding or moving source files.
4. Update the relevant module and reference documentation.
5. Run `build` and `check`.
6. verify affected behavior in both single-player and multiplayer when applicable.

## Security

Never commit service tokens, database credentials, private endpoints, user data, or values copied from local AOTTG secret storage. Generated files and debug output must be checked for accidental secrets before publication.

Report a suspected credential exposure privately to the project maintainers rather than opening a public issue containing the value.

## License

No license has been declared in this documentation starter. Contributions remain subject to the license selected by the repository owner.
