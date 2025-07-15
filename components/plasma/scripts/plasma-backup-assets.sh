#!/usr/bin/env bash

set -euo pipefail

echo ""

DRY_RUN=0
for arg in "$@"; do
  if [[ "$arg" == "--dry-run" ]]; then
    DRY_RUN=1
  fi
done

# === Configuration ===
TIMESTAMP=$(date +%F_%H-%M-%S)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# ASSETS_DIR="$HOME/.backup/plasma/assets"
ASSETS_DIR="$(dirname "$SCRIPT_DIR")/src/assets"
BACKUP_DIR="${ASSETS_DIR:-$HOME/.backup/plasma/assets}"
ARCHIVE_NAME="plasma-assets-backup-$TIMESTAMP.tar.gz"
ARCHIVE_PATH="$BACKUP_DIR/$ARCHIVE_NAME"

# === Asset Paths ===
ASSETS=(
  "$HOME/.local/share/plasma/desktoptheme"
  "$HOME/.local/share/color-schemes"
  "$HOME/.local/share/aurorae/themes"
  "$HOME/.local/share/plasma/look-and-feel"
  "$HOME/.local/share/wallpapers"
  "$HOME/.local/share/plasma/plasmoids"
  "$HOME/.icons"
)

# === Log Helpers ===
log_info() { echo -e "\033[1;34m[INFO]\033[0m $1"; }
log_success() { echo -e "\033[1;32m[SUCCESS]\033[0m $1"; }
log_warn() { echo -e "\033[1;33m[WARN]\033[0m $1"; }
log_error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }

# === Dry-run Mode ===
if [[ $DRY_RUN -eq 1 ]]; then
  log_info "[DRY-RUN] Would create backup archive at:"
  echo "→ $ARCHIVE_PATH"
  echo ""
  log_info "[DRY-RUN] Would include these asset directories:"
  for path in "${ASSETS[@]}"; do
    echo "- $path"
  done
  echo ""
  exit 0
fi

# === Actual Backup ===
mkdir -p "$BACKUP_DIR"

log_info "Creating Plasma assets backup..."
tar -czvf "$ARCHIVE_PATH" "${ASSETS[@]}" 2>/dev/null || {
  log_error "Failed to create archive."
  exit 1
}

log_success "Backup saved to: $ARCHIVE_PATH"
