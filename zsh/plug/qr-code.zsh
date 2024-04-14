# QRCode plugin

# Generate a QR Code from the command line. Uses [QRcode.show](https://qrcode.show) via curl.

# ------------------------------------------------------------------------
# alias           | command
# --------------- | ------------------------------------------------------
# `qrcode [text]` | `curl -d "text" qrcode.show`
# `qrsvg  [text]` | `curl -d "text" qrcode.show -H "Accept: image/svg+xml"`
# -------------------------------------------------------------------------

# Imported and improved from https://qrcode.show/, section SHELL FUNCTIONS

_qrcode_show_message() {
  echo "Type or paste your text, add a new blank line, and press ^d"
}

qrcode () {
  local input="$*"
  [ -z "$input" ] && _qrcode_show_message && local input="@/dev/stdin"
  curl -d "$input" https://qrcode.show
}

qrsvg () {
  local input="$*"
  [ -z "$input" ] && _qrcode_show_message && local input="@/dev/stdin"
  curl -d "$input" https://qrcode.show -H "Accept: image/svg+xml"
}

