#!/usr/bin/env bash

set -euo pipefail

# === logging helpers ===
log_info() { echo -e "\033[1;34m[INFO]\033[0m $1"; }
log_success() { echo -e "\033[1;32m[SUCCESS]\033[0m $1"; }
log_warn() { echo -e "\033[1;33m[WARN]\033[0m $1"; }
log_error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }

# === script paths ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ASSETS="$SCRIPT_DIR/plasma-backup-assets.sh"
RESTORE_ASSETS="$SCRIPT_DIR/plasma-restore-assets.sh"
BACKUP_CONFIGS="$SCRIPT_DIR/plasma-backup-configs.sh"
RESTORE_CONFIGS="$SCRIPT_DIR/plasma-restore-configs.sh"

# === usage help ===
print_help() {
  echo "Usage: plasma-tool.sh [option]"
  echo ""
  echo "Options:"
  echo "  --backup-assets     [--dry-run]   Backup Plasma themes, widgets, colors, etc"
  echo "  --backup-configs    [--dry-run]   Backup Plasma user config + SDDM"
  echo "  --backup-all        [--dry-run]   Backup Plasma Configs & UI assets"
  echo "  --restore-assets    [--dry-run]   Restore Plasma themes, widgets, colors, etc"
  echo "  --restore-configs   [--dry-run]   Restore Plasma + SDDM config"
  echo "  --restore-all       [--dry-run]   Restore Plasma Configs & UI assets"
  echo "  --help                            Show this help message"
}

# === parse commands ===
case "${1:-}" in
--backup-configs)
  shift
  bash "$BACKUP_CONFIGS" "$@"
  ;;
--restore-configs)
  shift
  bash "$RESTORE_CONFIGS" "$@"
  ;;
--backup-assets)
  shift
  bash "$BACKUP_ASSETS" "$@"
  ;;
--restore-assets)
  shift
  bash "$RESTORE_ASSETS" "$@"
  ;;
--backup-all)
  shift
  bash "$BACKUP_CONFIGS" "$@"
  bash "$BACKUP_ASSETS" "$@"
  ;;
--restore-all)
  shift
  bash "$RESTORE_CONFIGS" "$@"
  bash "$RESTORE_ASSETS" "$@"
  ;;
--help | *)
  print_help
  ;;
esac
