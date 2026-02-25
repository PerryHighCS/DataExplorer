#!/usr/bin/env bash
set -euo pipefail

DESTINATION_DIR="packages"

mkdir -p "$DESTINATION_DIR"

if ! command -v zip >/dev/null 2>&1; then
  echo "Error: 'zip' is required but not installed."
  exit 1
fi

for dir in */; do
  folder_name="${dir%/}"

  case "$folder_name" in
    "$DESTINATION_DIR"|"__pycache__"|".git"|".vscode")
      continue
      ;;
  esac

  zip_file="$DESTINATION_DIR/$folder_name.zip"
  rm -f "$zip_file"

  (
    cd "$folder_name"
    zip -rq "../$zip_file" .
  )

  if [[ -d ".vscode" ]]; then
    zip -rq "$zip_file" .vscode
  else
    echo "Warning: .vscode directory not found; creating archive without it for $folder_name"
  fi

  echo "Created: $zip_file"
done
