# Fase 6: virtualização.

for p in winboat gnome-boxes; do
  rpm_installed "$p" || run_spin "instalando $p" sudo pacman -S --noconfirm "$p"
done
sudo gpasswd -a "$SUDO_USER" libvirt 2>/dev/null || true
ok "virtualização instalada"