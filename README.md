# gray-review

`/review` and `/simplify` commands that turn the current git diff into an
agent prompt. Port of [pi-simplify](https://www.npmjs.com/package/pi-simplify)
(MIT) plus a behavior-only reimplementation of mitsupi's `/review`.

A sidecar plugin for [gray](https://github.com/vstaln/gray), scaffolded by
[gray-account](https://github.com/vstaln/gray-account).

## What it does

- `/review [--staged|<rev>|files...]` — runs `git diff` (default
  `git diff HEAD`; `--staged` → `--cached`; a revision like `HEAD~3` or a sha
  → `git diff <rev>`; bare path tokens scope the diff) and returns a
  `{prompt}` asking the agent to review the changes for clarity,
  consistency, and maintainability. The diff is embedded verbatim,
  head+tail-capped at ~30k characters with a truncation marker.
- `/simplify [--staged] [files...]` — enumerates changed files via
  `git diff --name-status`, computes each file's changed line ranges with
  `git diff --unified=0`, and returns a `{prompt}` telling the agent to
  simplify only those lines (no abstraction creep, no dead code, no
  over-engineering; preserve behavior).

Outside a git repo, or when `git` fails, both commands answer `{text}` with
an error line — they never emit a broken prompt.

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
