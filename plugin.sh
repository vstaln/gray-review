#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-review.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-review" ;;
    *) rel="x86_64-apple-darwin/gray-review" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-review" ;;
    *) rel="x86_64-unknown-linux-musl/gray-review" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-review.exe" "$here/target/release/gray-review" "$here/target/debug/gray-review.exe" "$here/target/debug/gray-review"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-review binary not found in $here" >&2
exit 1
