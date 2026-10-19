#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

source "$(dirname -- "${BASH_SOURCE[0]}")/lib/common.sh"

PHASES=(
  "01:Repos (CachyOS, AUR helper)"
  "02:Bloatware (remover pacotes desnecessários)"
  "03:Mise (node/bun/go/usage/pipx/gh)"
  "04:Packages (pacman + paru)"
  "05:Codecs e aceleração de vídeo"
  "06:Virtualização (winboat, gnome-boxes)"
  "07:Serviços systemd (cups, docker, snapper, etc.)"
  "08:Flatpaks"
  "09:Dotfiles (clone)"
  "10:GNOME (dconf)"
  "11:Extensões GNOME"
  "12:Customization (plymouth, temas, ícones, fontes)"
  "13:LSPs (npm) + gopls"
  "14:Tuning (kernel, snapper, grub-btrfs)"
  "15:GDM (login screen: escala de interface 125%)"
)

step "Iniciando archpi (Arch Linux, log: $LOG)"

for entry in "${PHASES[@]}"; do
  num="${entry%%:*}"
  desc="${entry#*:}"
  if ask_phase "$num" "$desc"; then
    source "$SCRIPT_DIR/lib/phases/$num.sh"
  else
    ok "Fase $num pulada pelo usuário"
  fi
done

step "Cleanup"
rm -rf "$CLONES"
try_warn flatpak uninstall -y --unused --system || true
ok "concluído — log completo em $LOG"