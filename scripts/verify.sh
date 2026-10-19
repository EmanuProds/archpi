#!/bin/bash
set -u
R="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
fail=0
ok()  { echo "OK   : $1"; }
bad() { echo "FAIL : $1"; fail=1; }

bash -n "$R/install.sh" && ok "install.sh sintaxe" || bad "install.sh sintaxe"
grep -q 'set -euo pipefail' "$R/install.sh" && ok "set -euo pipefail" || bad "sem set -euo pipefail"

for f in "$R"/lib/phases/*.sh; do
  bash -n "$f" && ok "sintaxe $(basename "$f")" || bad "sintaxe $(basename "$f")"
done

[ -s "$R/lists/mise.txt" ] && ok "mise.txt" || bad "mise.txt vazio"
[ -s "$R/lists/npm.txt" ] && ok "npm.txt" || bad "npm.txt vazio"
[ -s "$R/lists/packages.txt" ] && ok "packages.txt" || bad "packages.txt vazio"
[ -s "$R/lists/aur.txt" ] && ok "aur.txt" || bad "aur.txt vazio"

[ ! -e "$R/src" ] && ok "src/ removido" || bad "src/ ainda existe"

exit "$fail"