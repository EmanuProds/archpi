# Fase 12: customization (plymouth, temas, ícones, fontes).

# Plymouth
SPINNER_CONF="/usr/share/plymouth/themes/spinner/spinner.plymouth"
if [ -f "$SPINNER_CONF" ]; then
  try_warn sudo rm -f /usr/share/plymouth/themes/spinner/watermark.png
  try_warn sudo sed -i 's/VerticalAlignment=.7/VerticalAlignment=.5/' "$SPINNER_CONF"
  try_warn sudo plymouth-set-default-theme -R spinner
  ok "plymouth configurado"
fi

# Temas e ícones
run_spin "instalando temas e ícones" bash -c "echo '$SUDOPASSWORD' | paru -S --noconfirm --sudoflags '-S' adwaita-colors-icon-theme morewaita-icon-theme adw-gtk-theme"
ok "temas e ícones instalados"

# JetBrains Mono Nerd Font
if ! rpm_installed ttf-jetbrains-mono-nerd; then
  run_spin "instalando JetBrains Mono Nerd Font" sudo pacman -S --noconfirm ttf-jetbrains-mono ttf-jetbrains-mono-nerd
  as_user gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 11'
  ok "fonte monoespaçada configurada"
fi

# markdown-oxide LSP (Rust, binário do GitHub)
if [ ! -x "$SUH/.local/bin/markdown-oxide" ]; then
  _md_url=$(curl -s "https://api.github.com/repos/Feel-ix-343/markdown-oxide/releases/latest" | python3 -c "import json,sys; d=json.load(sys.stdin); print([a['browser_download_url'] for a in d.get('assets',[]) if a['name'].endswith('x86_64-unknown-linux-gnu') and not a['name'].endswith('.tar.gz')][0])" 2>/dev/null)
  try_warn run_spin "baixando markdown-oxide" curl -fsSL "$_md_url" -o "$SUH/.local/bin/markdown-oxide"
  chmod +x "$SUH/.local/bin/markdown-oxide" 2>/dev/null || true
  chown "$SUDO_USER:$(id -gn "$SUDO_USER")" "$SUH/.local/bin/markdown-oxide" 2>/dev/null || true
  [ -x "$SUH/.local/bin/markdown-oxide" ] && ok "markdown-oxide instalado" || warn "markdown-oxide não instalado"
else
  ok "markdown-oxide já instalado — pulando"
fi

ok "customization concluída"