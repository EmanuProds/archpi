# Fase 15: GDM (login screen) — escala de interface 125% + layout de monitor.

_f0=$FAIL_COUNT
GDM_DBNAME="gdm"
GDM_DBDIR="/etc/dconf/db/${GDM_DBNAME}.d"
GDM_PROFILE="/etc/dconf/profile/${GDM_DBNAME}"
GDM_SCALING="1.25"

# --- profile dconf do GDM -------------------------------------------------
# O greeter roda com DCONF_PROFILE=gdm. Sem esse profile ele não lê o db
# system-db:gdm e a lista de usuários some (bug conhecido do GDM 50).
if [ ! -f "$GDM_PROFILE" ]; then
  install -d -m 755 /etc/dconf/profile
  cat > "$GDM_PROFILE" <<EOF
user-db:user
system-db:${GDM_DBNAME}
file-db:/usr/share/gdm/greeter-dconf-defaults
EOF
  ok "GDM: profile dconf criado ($GDM_PROFILE)"
else
  ok "GDM: profile dconf já existe"
fi

# --- escala de interface do greeter ----------------------------------------
# O 'scaling-factor' do schema org.gnome.desktop.interface é uint32 (só
# 1/2/3/4), então 125% só é possível via text-scaling-factor (double 0.5-3.0).
#
# O keyfile é numerado com 99- de propósito: dentro do mesmo diretório .d o
# dconf aplica os keyfiles em ordem lexicográfica e o ÚLTIMO vence. Assim
# este arquivo sobrescreve o 95-gdm-settings (gerado pela extensão GdmSettings)
# sem depender da ordem de instalação.
install -d -m 755 "$GDM_DBDIR"
cat > "$GDM_DBDIR/99-gdm-scale" <<EOF
# Escala de interface do GDM (login screen).
# Gerado pelo archpi — sobrescreve o 95-gdm-settings da extensão GdmSettings.
[org/gnome/desktop/interface]
text-scaling-factor=${GDM_SCALING}
EOF
chmod 644 "$GDM_DBDIR/99-gdm-scale"
try_warn sudoz dconf update
ok "GDM: text-scaling-factor=${GDM_SCALING} aplicado"

# --- layout de monitor do greeter -----------------------------------------
# O greeter não lê o ~/.config/monitors.xml do usuário: usa o do home do gdm.
# Sem copiar, a tela de login fica em escala diferente da sessão.
GDM_HOME="/var/lib/gdm"
if [ -f "$SUH/.config/monitors.xml" ]; then
  install -d -m 755 -o gdm -g gdm "$GDM_HOME/.config"
  install -m 644 -o gdm -g gdm "$SUH/.config/monitors.xml" "$GDM_HOME/.config/monitors.xml"
  ok "GDM: monitors.xml copiado (escala de display do greeter = desktop)"
else
  warn "GDM: \$SUH/.config/monitors.xml inexistente — greeter fica na escala padrão"
fi

# --- sincroniza a escala de texto do GDM com a extensão -------------------
# A extensão GdmSettings reescreve o 95-gdm-settings a partir do seu dconf
# (io.github.realmazharhussain.GdmSettings/fonts/scaling-factor). Mantém o
# valor alinhado para o "apply" da extensão não desfazer o 99-gdm-scale.
GSCHEMA="io.github.realmazharhussain/GdmSettings"
_dconf_dump=$(as_user dconf dump / 2>/dev/null || true)
if printf '%s' "$_dconf_dump" | grep -q "GdmSettings/fonts"; then
  _cur=$(printf '%s' "$_dconf_dump" | grep -A6 "GdmSettings/fonts" | grep -oE "scaling-factor=[0-9.]+" | cut -d= -f2)
  if [ "$_cur" = "$GDM_SCALING" ]; then
    ok "GDM: extensão GdmSettings já está com scaling-factor=$GDM_SCALING"
  else
    if as_user dconf write "/$GSCHEMA/fonts/scaling-factor" "$GDM_SCALING" 2>/dev/null; then
      ok "GDM: extensão GdmSettings sincronizada ($GDM_SCALING)"
    else
      warn "GDM: não foi possível sincronizar a extensão GdmSettings (scaling-factor=$_cur)"
    fi
  fi
else
  warn "GDM: extensão GdmSettings não configurada — pulando sync"
fi

phase_end "$_f0" "GDM configurado (interface ${GDM_SCALING})"
