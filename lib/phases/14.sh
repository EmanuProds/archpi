# Fase 14: tuning (kernel, snapper, grub-btrfs).

if ! rpm_installed snapper; then
  run_spin "instalando snapper" sudo pacman -S --noconfirm snapper
fi
try_warn sudo snapper create-config /
ok "snapper configurado"

if ! rpm_installed grub-btrfs; then
  try_warn bash -c "echo '$SUDOPASSWORD' | paru -S --noconfirm --sudoflags '-S' grub-btrfs"
fi
if rpm_installed grub-btrfs; then
  try_warn sudo systemctl enable --now grub-btrfs.path
  ok "grub-btrfs configurado"
fi

if [ -f /etc/mkinitcpio.conf ]; then
  grep -q 'plymouth' /etc/mkinitcpio.conf || sudo sed -i '/^HOOKS=/s/\(udev \)/\1plymouth /' /etc/mkinitcpio.conf
  ok "mkinitcpio configurado com plymouth"
fi

ok "tuning concluído"