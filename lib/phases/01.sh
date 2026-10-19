# Fase 1: repos (CachyOS, AUR helper).

if [ ! -f /etc/pacman.d/cachyos-mirrorlist ]; then
  run_spin "configurando repos CachyOS" bash -c '
    curl -fsSL https://mirror.cachyos.org/cachyos-repo.tar.xz -o /tmp/cachyos-repo.tar.xz
    tar xf /tmp/cachyos-repo.tar.xz -C /tmp
    cd /tmp/cachyos-repo && yes | sudo ./cachyos-repo.sh
    rm -rf /tmp/cachyos-repo /tmp/cachyos-repo.tar.xz
  '
  ok "repos CachyOS configurados"
else
  ok "repos CachyOS já configurados — pulando"
fi

if ! command_exists paru; then
  run_spin "instalando paru" bash -c '
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru && makepkg -si --noconfirm
    rm -rf /tmp/paru
  '
  ok "paru instalado"
else
  ok "paru já instalado — pulando"
fi

run_spin "atualizando sistema" sudo pacman -Syu --noconfirm
ok "sistema atualizado"