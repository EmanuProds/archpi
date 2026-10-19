# Fase 9: dotfiles (clone do repo).

clone_repo "$DOTFILES_REPO" "$CLONES/dotfiles"
install -d -m 755 -o "$SUDO_USER" -g "$(id -gn "$SUDO_USER")" "$SUH/.config"
for f in .bashrc .shell_aliases; do
  [ -f "$CLONES/dotfiles/home/$f" ] && install -m 644 -o "$SUDO_USER" -g "$(id -gn "$SUDO_USER")" "$CLONES/dotfiles/home/$f" "$SUH/$f"
done
[ -d "$CLONES/dotfiles/home/.config" ] && cp -a "$CLONES/dotfiles/home/.config/." "$SUH/.config/"
chown -R "$SUDO_USER:$(id -gn "$SUDO_USER")" "$SUH/.config" "$SUH/.bashrc" "$SUH/.shell_aliases" 2>/dev/null || true
ok "dotfiles no lugar"