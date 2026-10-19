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

# GDM: fase 15 deve existir e aplicar a escala de interface no login screen
[ -f "$R/lib/phases/15.sh" ] && ok "fase 15 (GDM)" || bad "fase 15 (GDM) ausente"
grep -q 'text-scaling-factor' "$R/lib/phases/15.sh" && ok "GDM aplica text-scaling-factor" || bad "GDM sem text-scaling-factor"
grep -q '99-gdm-scale' "$R/lib/phases/15.sh" && ok "GDM keyfile 99- (vence o 95- da extensão)" || bad "GDM keyfile 99- ausente"
grep -q 'monitors.xml' "$R/lib/phases/15.sh" && ok "GDM copia monitors.xml" || bad "GDM sem cópia de monitors.xml"
grep -q 'system-db:gdm' "$R/lib/phases/15.sh" && ok "GDM cria profile dconf" || bad "GDM sem profile dconf"
grep -q '"15:GDM' "$R/install.sh" && ok "install.sh registra fase 15" || bad "install.sh sem fase 15"

exit "$fail"