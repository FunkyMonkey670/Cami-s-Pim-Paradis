# Module Catalog

This directory documents the project's logical modules. A module is a cohesive unit of responsibility with an explicit owner, public contract, state model, lifecycle, dependencies, and consumers.

Modules are a repository and design convention. They are not Custom Logic namespaces or separately compiled programs. Their source is combined with the rest of the files listed in `build-order.json` before AOTTG2 loads it.

## Catalog

| Module | Status | Primary source | Responsibility | Runtime authority |
|---|---|---|---|---|
| _--_ | -- | -- | -- | -- |

## What requires a module page

Create a module page when a unit has one or more of the following:

- mutable state of its own;
- a public function used by another source file;
- engine event handling;
- initialization, reset, or shutdown behavior;
- authority or synchronization responsibilities;
- persistence or an external-service boundary;
- a command family or substantial UI surface;
- non-obvious performance, ordering, or failure constraints.

Tiny stateless helpers may remain documented in their source header and owning module page. Do not create a page for every function merely to increase document count.

## Naming and placement

- Use one lowercase kebab-case filename per module, such as `round-flow.md`.
- Use the same human-readable module name in the source header and documentation title.
- Link all primary source files and important supporting files.
- If a module spans several files, explain why and identify which file owns each responsibility.
- If one file contains several small helpers owned by a larger module, document them under that module rather than inventing false independence.

## Module boundaries

A module page must make these boundaries explicit:

| Boundary | Required question |
|---|---|
| Responsibility | What behavior does this module own, and what does it intentionally not own? |
| API | Which functions or values may other modules rely on? |
| State | Which mutable values does it own and who may request changes? |
| Authority | Which runtime context validates and commits shared behavior? |
| Lifecycle | When is it initialized, ready, reset, degraded, and disposed? |
| Dependencies | What must exist before this module can operate? |
| Consumers | Which modules call it or read its published state? |
| Recovery | How does it handle retries, late joins, invalid objects, and authority changes? |

Directory location alone does not answer these questions.

## Source relationship

Each substantial source file should include a header that points back to its module page:

```c
// Module: Round Flow
// Documentation: docs/modules/round-flow.md
// Responsibility: Owns authoritative wave and intermission transitions.
// Runtime: Master authority; all clients consume synchronized phase state.
// Depends on: Config, Utilities
// Used by: Main, RoundCommands, RoundHUD
// Persistent state: None
```

Cross-file references that appear unresolved in a source file may be valid after bundling. The module page must identify the declaring module and contract so contributors do not need to reverse-engineer the final generated file.

## Creating a module page

1. Copy [the module template](../templates/module.md).
2. Rename it to the module's lowercase kebab-case name.
3. Replace all `{PLACEHOLDER}` values and remove template instructions.
4. List the module in the catalog above.
5. Add its source file to `build-order.json` exactly once.
6. Add shared identifiers to the appropriate [reference registry](../reference/README.md).
7. Link the page from each primary source header.
8. Verify that authority, state lifetime, initialization, failure, and performance sections are complete.

## Review expectations

A reviewer should be able to answer the following without reading the entire generated script:

- Why does the module exist?
- Which source files implement it?
- Where does it appear in the build and why?
- What may another module call or read?
- Which state can it mutate?
- On which client does each mutation occur?
- What happens during join, leave, reset, and failure?
- Which exact names are registered under `docs/reference/`?
- How can the behavior be tested?

If those answers require undocumented repository archaeology, the module page is incomplete.

## Keeping the catalog current

Update the module page and this catalog in the same contribution when a module is added, renamed, split, merged, deprecated, or removed. Preserve migration notes for stable contracts rather than deleting their history immediately.
