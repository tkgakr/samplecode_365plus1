#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  echo "Usage: bash scripts/copy-date-folder.sh <MMDD>" >&2
  exit 1
fi

date_dir="$1"

case "$date_dir" in
  [0-1][0-9][0-3][0-9])
    ;;
  *)
    echo "Error: date folder must be a 4-digit MMDD value, for example 0423." >&2
    exit 1
    ;;
esac

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
source_dir="$repo_root/upstream/samplecode_365plus1/dates/$date_dir"
target_dir="$repo_root/$date_dir"

if [ ! -d "$repo_root/upstream/samplecode_365plus1" ]; then
  echo "Error: submodule 'upstream/samplecode_365plus1' is not available." >&2
  echo "Run: git submodule update --init --recursive" >&2
  exit 1
fi

if [ ! -d "$source_dir" ]; then
  echo "Error: source folder not found: $source_dir" >&2
  exit 1
fi

if [ -e "$target_dir" ]; then
  echo "Error: target already exists: $target_dir" >&2
  exit 1
fi

cp -R "$source_dir" "$target_dir"

echo "Copied '$source_dir' to '$target_dir'."
