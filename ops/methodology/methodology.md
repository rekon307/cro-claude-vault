---
description: The vault's self-knowledge - derivation rationale, configuration state, and operational evolution history
type: moc
---

# methodology

This folder records what the system knows about its own operation: why it was configured this way, what the current state is, and how it has evolved. Meta-skills (`/reassess`, `/architect`) read from and write to this folder. `/flag` captures operational corrections here.

## Derivation Rationale

- [[derivation-rationale]] - Why each configuration dimension was set the way it was

## Configuration State

(Populated by `/reassess`, `/architect` as the system runs.)

## Evolution History

(Populated by `/reassess`, `/architect`, `/reseed` over time.)

## How to Use This Folder

```
ls ops/methodology/                      # browse all methodology notes
rg '^category:' ops/methodology/         # query by category
rg '^status: active' ops/methodology/    # find active directives
```

The seven content categories are: `derivation-rationale`, `kernel-state`, `pipeline-config`, `maintenance-conditions`, `vocabulary-map`, `configuration-state`, `drift-detection`. Only `derivation-rationale` is created at init; the others are populated by meta-skills during operation.
