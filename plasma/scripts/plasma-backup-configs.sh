#!/usr/bin/bash

DRY_RUN=0
for arg in "$@"; do
  if [[ "$arg" == "--dry-run" ]]; then
    DRY_RUN=1
  fi
done

TIMESTAMP=$(date +%F_%H-%M-%S)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# CONFIGS_DIR="$HOME/.backup/plasma/configs"
CONFIGS_DIR="$(dirname "$SCRIPT_DIR")/src/configs"
BACKUP_DIR="${CONFIGS_DIR:-$HOME/.backup/plasma/configs}"
mkdir -p "$BACKUP_DIR"

USER_BACKUP="$BACKUP_DIR/plasma-config-backup-$TIMESTAMP.tar.gz"
SDDM_BACKUP="$BACKUP_DIR/sddm-config-backup-$TIMESTAMP.tar.gz"

USER_PATHS=(
  "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc"
  "$HOME/.config/plasmarc"
  "$HOME/.config/kdeglobals"
  "$HOME/.config/ksplashrc"
  "$HOME/.config/kscreenlockerrc"
  "$HOME/.config/powermanagementprofilesrc"
  "$HOME/.config/kwinrc"
  "$HOME/.config/kcminputrc"
  "$HOME/.config/plasma-localerc"
  "$HOME/.local/share/kscreen/"
)

echo ""
echo "📦 Backing up user Plasma config to: $USER_BACKUP"
echo ""

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[DRY-RUN] Would create archive:"
  for path in "${USER_PATHS[@]}"; do
    echo "  - $path"
  done
else
  tar -czvf "$USER_BACKUP" "${USER_PATHS[@]}"
  echo "✅ User backup created: $USER_BACKUP"
fi

echo "🛡️ Checking for sudo access to back up SDDM config..."

if ! sudo -v; then
  echo "⚠️ Skipping SDDM backup — sudo access not granted."
  exit 0
fi

TMP_DIR=$(mktemp -d)
SDDM_PATHS=(
  "/etc/sddm.conf"
  "/etc/sddm.conf.d"
  "/usr/share/sddm/themes"
)

echo ""
echo "📦 Backing up SDDM files to $TMP_DIR..."
echo ""

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[DRY-RUN] Would copy and package:"
  for path in "${SDDM_PATHS[@]}"; do
    echo "  - $path"
  done
  echo "[DRY-RUN] Would create archive at: $SDDM_BACKUP"
  echo "[DRY-RUN] Would remove temp dir: $TMP_DIR"

  # safe to cleanup in dry-run
  sudo rm -rf "$TMP_DIR"
  exit 0
fi

for path in "${SDDM_PATHS[@]}"; do
  if [[ -e "$path" ]]; then
    sudo cp -r --parents "$path" "$TMP_DIR" 2>/dev/null
    echo "✅ Copied path: $path"
  else
    echo "⚠️ Skipped (not found): $path"
  fi
done

sudo tar -czvf "$SDDM_BACKUP" -C "$TMP_DIR" .
sudo chown "$USER:$USER" "$SDDM_BACKUP"

if sudo rm -rf "$TMP_DIR"; then
  echo "🧹 Temp files cleaned up."
else
  echo "⚠️ Warning: Could not remove temp dir $TMP_DIR. Try deleting it manually."
fi

echo "✅ SDDM backup complete: $SDDM_BACKUP"
