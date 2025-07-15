#!/usr/bin/bash

# === parse args ===
DRY_RUN=0
USER_BACKUP=""
SDDM_BACKUP=""

for arg in "$@"; do
  case "$arg" in
  --dry-run) DRY_RUN=1 ;;
  *.tar.gz)
    if [[ -z "$USER_BACKUP" ]]; then
      USER_BACKUP="$arg"
    elif [[ -z "$SDDM_BACKUP" ]]; then
      SDDM_BACKUP="$arg"
    fi
    ;;
  *)
    echo "❌ Unknown argument: $arg"
    exit 1
    ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIGS_DIR="$(dirname "$SCRIPT_DIR")/src/configs"
BACKUP_DIR="${CONFIGS_DIR:-$HOME/.backup/plasma/configs}"

[[ -z "$USER_BACKUP" ]] && USER_BACKUP=$(find "$BACKUP_DIR" -name 'plasma-config-backup-*.tar.gz' | sort | tail -n 1)
[[ -z "$SDDM_BACKUP" ]] && SDDM_BACKUP=$(find "$BACKUP_DIR" -name 'sddm-config-backup-*.tar.gz' | sort | tail -n 1)

# === optional backup before restore ===
if [[ $DRY_RUN -eq 0 ]]; then
  read -rp "📦 Do you want to back up your current config before restoring? [Y/n]: " BACKUP_CONFIRM
  if [[ "$BACKUP_CONFIRM" != [nN] ]]; then
    bash "$(dirname "$0")/plasma-backup-configs.sh"
    echo "✅ Backup complete."
  else
    echo "⚠️ Skipping backup."
  fi
else
  echo "🔎 [DRY-RUN] Would prompt to back up and run plasma-backup-with-sddm.sh"
fi

# === check user config backup ===
if [[ ! -f "$USER_BACKUP" ]]; then
  echo "❌ No user config backup found in $BACKUP_DIR"
  exit 1
fi

echo "📂 Found user backup: $USER_BACKUP"

if [[ $DRY_RUN -eq 0 ]]; then
  read -rp "⚠️ This will overwrite your current Plasma config. Continue? [y/N]: " CONFIRM
  [[ "$CONFIRM" != [yY] ]] && echo "❌ Aborted." && exit 1
else
  echo "🔎 [DRY-RUN] Would ask to confirm Plasma restore"
fi

# === restore user config ===
if [[ $DRY_RUN -eq 1 ]]; then
  echo "🔎 [DRY-RUN] Would stop Plasma shell: kquitapp6 plasmashell"
  echo "🔎 [DRY-RUN] Would extract: $USER_BACKUP → $HOME"
  echo "🔎 [DRY-RUN] Would start Plasma shell: kstart6 plasmashell"
else
  echo "🛑 Stopping Plasma shell..."
  kquitapp6 plasmashell

  echo "♻️ Restoring user config files..."
  tar -xzvf "$USER_BACKUP" -C "$HOME"

  echo "🚀 Restarting Plasma shell..."
  kstart6 plasmashell

  echo "✅ User config restored!"
fi

# === handle sddm config ===
if [[ ! -f "$SDDM_BACKUP" ]]; then
  echo "⚠️ No SDDM backup found to restore."
  exit 0
fi

echo "📂 Found SDDM backup: $SDDM_BACKUP"

if [[ $DRY_RUN -eq 1 ]]; then
  echo "[DRY-RUN] Would prompt for sudo to restore SDDM config"
  echo "[DRY-RUN] Would extract $SDDM_BACKUP to temp dir and apply to /etc and /usr/share/sddm/themes"
else
  read -rp "🛡️ Restore SDDM system config from $SDDM_BACKUP? (requires sudo) [y/N]: " SDDM_CONFIRM
  if [[ "$SDDM_CONFIRM" != [yY] ]]; then
    echo "⚠️ Skipping SDDM restore."
    exit 0
  fi

  TMP_DIR=$(mktemp -d)
  echo "📦 Extracting SDDM config to temp dir..."
  tar -xzvf "$SDDM_BACKUP" -C "$TMP_DIR"

  echo "🛠️ Applying SDDM config (with sudo)..."
  sudo cp -r "$TMP_DIR/etc/sddm.conf" /etc/ 2>/dev/null
  sudo cp -r "$TMP_DIR/etc/sddm.conf.d/" /etc/ 2>/dev/null
  sudo cp -r "$TMP_DIR/usr/share/sddm/themes/" /usr/share/sddm/ 2>/dev/null

  echo "🧹 Cleaning up temp dir..."
  sudo rm -rf "$TMP_DIR"

  echo "✅ SDDM config restored!"
fi
