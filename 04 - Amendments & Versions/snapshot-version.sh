#!/bin/bash
# snapshot-version.sh — freeze the current constitution into a new immutable version folder.
# Run from anywhere; it locates the project by its own path.
#
#   ./snapshot-version.sh v0.3            # dates it today
#   ./snapshot-version.sh v0.3 2026-07-01 # explicit date
#
# Result: "04 - Amendments & Versions/<version> - <date>/" containing read-only copies of the current
# master + annex + police docs, plus a stub AMENDMENTS.md. The working folders (01/02) are untouched.
set -euo pipefail

VERSION="${1:-}"
[ -z "$VERSION" ] && { echo "usage: $0 <version> [YYYY-MM-DD]   e.g. $0 v0.3"; exit 1; }
DATE="${2:-$(date +%Y-%m-%d)}"

# project root = parent of this script's folder (the "04 - …" folder)
ARCHIVE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(dirname "$ARCHIVE_DIR")"

MASTER="$ROOT/01 - Old Constitution (The Real Thing)/00 - Srijan's Constitution for AI Systems.md"
LAW="$ROOT/02 - New Constitution (Security & Policing)/00 - THE CONSTITUTION OF AI CONDUCT.md"
POLICE="$ROOT/02 - New Constitution (Security & Policing)/01 - THE POLICE AGENTS.md"

DEST="$ARCHIVE_DIR/$VERSION - $DATE"
if [ -e "$DEST" ]; then echo "ERROR: '$DEST' already exists — pick a new version label."; exit 1; fi
mkdir -p "$DEST"

copied=0
for f in "$MASTER" "$LAW" "$POLICE"; do
  if [ -f "$f" ]; then cp "$f" "$DEST/"; copied=$((copied+1)); else echo "WARN: missing $f"; fi
done

cat > "$DEST/AMENDMENTS.md" <<EOF
# Version $VERSION — $DATE

Frozen snapshot of the constitution as released at $VERSION. **Do not edit these files** — this is history.
The living copy continues in \`01 - Old Constitution/\` and \`02 - New Constitution/\`.

## What changed since the previous version
- (fill in: what amendments were made, and why)

See \`../CHANGELOG.md\` for the full history.
EOF

# freeze: snapshot files are immutable history
chmod -w "$DEST"/*.md 2>/dev/null || true

echo "Snapshot created: $DEST"
echo "  $copied document(s) frozen (read-only) + AMENDMENTS.md stub."
echo
echo "Next:"
echo "  1. Edit  $DEST/AMENDMENTS.md   (what changed, why)"
echo "  2. Add a top entry to  $ARCHIVE_DIR/CHANGELOG.md"
echo "  3. Bump the version header inside the working master in '01 - Old Constitution/'."
