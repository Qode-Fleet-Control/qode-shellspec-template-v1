#!/bin/sh
# Local (non-docker) install: ShellSpec at a pinned release, unpacked from its GitHub
# release tarball into ./.tools/shellspec (ShellSpec runs from its own directory — no
# build step). The docker image uses the official shellspec/shellspec-debian image.
set -eu
SHELLSPEC_VERSION="${SHELLSPEC_VERSION:-0.28.1}"
cd "$(dirname "$0")/.."
if [ ! -x .tools/shellspec/shellspec ]; then
  mkdir -p .tools/shellspec
  curl -fsSL "https://github.com/shellspec/shellspec/archive/refs/tags/$SHELLSPEC_VERSION.tar.gz" \
    | tar -xz --strip-components=1 -C .tools/shellspec
fi
.tools/shellspec/shellspec --version
