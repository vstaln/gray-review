<div align="center">
  <img alt="gray-review" src="assets/icon.svg" width="120" height="120" />
  <h1>gray-review</h1>
  <p><strong>/review and /simplify turn the current git diff into a focused review prompt.</strong></p>
  <p>
    <a href="https://gray.alignment.id">Website</a> ·
    <a href="https://gray.alignment.id/plugins/gray-review">Store</a> ·
    <a href="https://github.com/vstaln/gray-review">Source</a> ·
    <a href="https://github.com/vstaln/gray">gray</a>
  </p>
  <p>
    <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-1c1c20?style=flat-square&labelColor=0a0a0b" /></a>
    <a href="https://www.rust-lang.org"><img alt="Built with Rust" src="https://img.shields.io/badge/built%20with-rust-1c1c20?style=flat-square&labelColor=0a0a0b&logo=rust&logoColor=d4a373" /></a>
    <a href="https://gray.alignment.id/plugins/gray-review"><img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-1c1c20?style=flat-square&labelColor=0a0a0b&color=7aa2f7" /></a>
  </p>
</div>

<br/>

```bash
gray plugin install gray-review
```

`/review` and `/simplify` turn the current git diff into a focused agent
prompt.

## What it does

- `/review [--staged|<rev>|files...]` — runs `git diff` (default
  `git diff HEAD`; `--staged` → `--cached`; a revision like `HEAD~3` or a
  SHA → `git diff <rev>`; bare path tokens scope the diff) and returns a
  `{prompt}` asking the agent to review the changes for clarity,
  consistency, and maintainability. The diff is embedded verbatim and
  head+tail-capped at ~30k characters with a truncation marker.
- `/simplify [--staged] [files...]` — enumerates changed files via
  `git diff --name-status`, computes each file's changed line ranges with
  `git diff --unified=0`, and returns a `{prompt}` telling the agent to
  simplify only those lines: no abstraction creep, no dead code, no
  over-engineering, and no behavior changes.

Outside a git repo, or when `git` fails, both commands answer `{text}` with
an error line — never a broken prompt.

## Wire

`command/run` only. Manifest claims `commands: ["/review", "/simplify"]`,
no tools, no hooks, protocol `1.1`.

## Install

```sh
gray plugin install review
```

## Develop

```sh
cargo test
gray account check      # entry point + manifest handshake
gray account publish    # check → build → release → publish to the gray registry
```

Bump `version` in `Cargo.toml` before each `publish`; the registry refuses to
republish a version.

## Tags

`gray` `plugin` `review` `rust`

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
