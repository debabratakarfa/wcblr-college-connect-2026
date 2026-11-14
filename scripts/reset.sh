#!/usr/bin/env bash
# Deletes the demo site, its database and the site/ folder.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SITE_DIR="${REPO_ROOT}/site"

if [ ! -d "${SITE_DIR}/.ddev" ]; then
  echo "No demo site found in ${SITE_DIR}. Nothing to reset."
  exit 0
fi

read -r -p "Delete the demo site and its database? [y/N] " answer
case "${answer}" in
  [yY]*) ;;
  *) echo "Cancelled."; exit 0 ;;
esac

(cd "${SITE_DIR}" && ddev delete --omit-snapshot --yes)
rm -rf "${SITE_DIR}"
echo "Demo site removed. Run bash scripts/setup.sh to build it again."
