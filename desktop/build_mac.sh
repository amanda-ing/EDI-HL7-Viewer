#!/bin/bash
# Builds "EDI and HL7 Message Reader.app" for macOS.
# Run from Terminal:  bash build_mac.sh
# Needs Python 3 (python.org or Homebrew). Everything else is installed into a
# private .venv folder here, so nothing is added to your system Python.
set -euo pipefail
cd "$(dirname "$0")"
HERE="$(pwd)"

VENV="${VENV:-.venv}"
if [ ! -x "$VENV/bin/python" ]; then
  echo "Setting up a private Python environment (first time only)..."
  python3 -m venv "$VENV"
fi
"$VENV/bin/pip" install --quiet --upgrade -r requirements.txt

WORK="$(mktemp -d)"
"$VENV/bin/pyinstaller" --noconfirm --clean --windowed \
  --name "EDI and HL7 Message Reader" \
  --icon "$HERE/icon.icns" \
  --osx-bundle-identifier local.edi-hl7-message-reader \
  --add-data "$HERE/../EDI-and-HL7-Message-Reader.html:." \
  --workpath "$WORK" --specpath "$WORK" \
  --distpath "$HERE/dist" \
  "$HERE/message_reader_app.py"
rm -rf "$WORK"

# Put the finished app next to the HTML version
rm -rf "../EDI and HL7 Message Reader.app"
cp -R "dist/EDI and HL7 Message Reader.app" ..
rm -rf dist
echo
echo "Done: EDI and HL7 Message Reader.app is in $(cd .. && pwd)"
echo "Drag it into your Applications folder if you like."
