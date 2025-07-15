#!/usr/bin/env bash

set -euo pipefail

# === Parse args ===
DRY_RUN=0

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/src/assets"
BACKUP_DIR="${ASSETS_DIR:-$HOME/.backup/plasma/assets}"
BACKUP_FILE=""

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    *.tar.gz) BACKUP_FILE="$arg" ;;
    *)
      echo "❌ Unknown argument: $arg"
      exit 1
      ;;
  esac
done

# === Default to latest if not provided ===
if [[ -z "$BACKUP_FILE" ]]; then
  BACKUP_FILE=$(find "$BACKUP_DIR" -name "plasma-assets-backup-*.tar.gz" | sort | tail -n 1)
fi

# === Log Helpers ===
log_info()    { echo -e "\033[1;34m[INFO]\033[0m $1"; }
log_success() { echo -e "\033[1;32m[SUCCESS]\033[0m $1"; }
log_warn()    { echo -e "\033[1;33m[WARN]\033[0m $1"; }
log_error()   { echo -e "\033[1;31m[ERROR]\033[0m $1"; }

# === Check backup file ===
if [[ ! -f "$BACKUP_FILE" ]]; then
  log_error "Backup file not found: $BACKUP_FILE"
  exit 1
fi

# === Start restore ===
log_info "Restoring Plasma assets from:"
echo "  → $BACKUP_FILE"

if [[ $DRY_RUN -eq 1 ]]; then
  echo
  log_info "[DRY-RUN] Would extract to:"
  echo "  → $HOME"
  echo
  log_info "[DRY-RUN] Contents of archive:"
  tar -tzf "$BACKUP_FILE"
  exit 0
fi

# === Actual Restore ===
log_info "Extracting archive..."
tar -xzvf "$BACKUP_FILE" -C "$HOME"

log_success "Restore complete!"

