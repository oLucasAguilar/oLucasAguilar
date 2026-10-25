#!/usr/bin/env bash
# Regenerates assets/*.gif from the scenes in this folder.
# Needs ffmpeg, Google Chrome, Node 20+ and playwright-core in the npx cache (run `npx @playwright/mcp` once).
set -euo pipefail
cd "$(dirname "$0")"
LINES=$(python3 -c "import json,urllib.parse;print('lines='+urllib.parse.quote(json.dumps(['I build for the web, mostly in Rails.','I ship with AI agents.','I take ideas to production.'])))")
for theme in dark light; do
  QS=$LINES ./gen.sh hero.html $theme ../assets/hero-$theme.gif 560 150
  ./gen.sh flow.html $theme ../assets/flow-$theme.gif 600 342
done
