<p align="center">
  <img src="assets/gray-logo.svg" alt="gray" width="96">
</p>
<h1 align="center">gray-review</h1>
<p align="center">Review or simplify the current git diff with focused prompts.</p>
<p align="center">
  <a href="https://github.com/vstaln/gray-review/blob/main/LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <img alt="gray plugin" src="https://img.shields.io/badge/gray-plugin-7aa2f7.svg">
  <img alt="rust" src="https://img.shields.io/badge/built%20with-rust-orange.svg">
</p>

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

---
Part of the [gray](https://github.com/vstaln/gray) plugin ecosystem —
the open-source AI agent harness. <https://gray.alignment.id>
