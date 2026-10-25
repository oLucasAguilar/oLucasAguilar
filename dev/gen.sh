#!/usr/bin/env bash
# gen.sh <scene.html> <theme> <out.gif> <w> <h> [fps]: length comes from the scene's window.END
set -euo pipefail
scene=$1; theme=$2; out=$3; w=$4; h=$5; fps=${6:-15}
PW=$(ls -d ~/.npm/_npx/*/node_modules/playwright-core | head -1)
NODE=$(ls -d ~/.nvm/versions/node/v2*/bin | head -1)/node
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
"$NODE" "$(dirname "$0")/render.cjs" "$PW" "file://$(realpath "$scene")?theme=$theme&${QS:-}" "$tmp" "$fps" 0 "$w" "$h"
ffmpeg -v error -y -framerate "$fps" -i "$tmp/%04d.png" -vf palettegen=stats_mode=full "$tmp/pal.png"
ffmpeg -v error -y -framerate "$fps" -i "$tmp/%04d.png" -i "$tmp/pal.png" -lavfi paletteuse=dither=none -loop 0 "$out"
echo "$out | $(( $(stat -c%s "$out") / 1024 )) KB | $(ls "$tmp" | grep -c png) frames"
