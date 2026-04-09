#!/usr/bin/env bash
set -euo pipefail

ROOT=""
WOLFRAM="/Applications/Wolfram.app/Contents/MacOS/wolframscript"

tests=(
  "tests/diag.wls"
  "tests/diag_degenerate.wls"
  "tests/diag_cross_species.wls"
  "tests/coupled_dot.wls"
  "tests/coupled_dot_down.wls"
  "tests/coupled_cross_updown.wls"
  "tests/coupled_spinless.wls"
  "tests/coupled_leftonly.wls"
  "tests/coupled_extra_lead.wls"
  "tests/coupled_two_dots.wls"
)

for script in "${tests[@]}"; do
  printf 'Running %s...\n' "$script"
  bash -lc "\"$WOLFRAM\" -file \"$script\"" -- <<'EOF'
EOF
done
