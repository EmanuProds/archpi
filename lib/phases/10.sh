# Fase 10: dconf (GNOME).

if [ -f "$CLONES/dotfiles/dconf/gnome-settings.ini" ]; then
  try_warn as_user dconf load / < "$CLONES/dotfiles/dconf/gnome-settings.ini"
  ok "dconf restaurado"
else
  warn "gnome-settings.ini não encontrado — pulando"
fi