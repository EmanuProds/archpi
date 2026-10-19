# Fase 7: serviços.

for svc in cups docker snapper-timeline.timer snapper-cleanup.timer fstrim.timer; do
  if service_enabled "$svc"; then ok "$svc já habilitado — pulando"; else try_warn sudo systemctl enable --now "$svc"; fi
done
sudo usermod -aG docker "$SUDO_USER" 2>/dev/null || true
sudo usermod -aG lp "$SUDO_USER" 2>/dev/null || true
ok "serviços habilitados"