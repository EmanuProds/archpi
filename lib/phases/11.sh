# Fase 11: extensões GNOME.

_f0=$FAIL_COUNT
EXTENSIONS=(8084 6807 517 6325 7000 4222 8642 9707 3843 7065 1319 6670 6583)
if command_exists gnome-extensions-cli; then
  for ext in "${EXTENSIONS[@]}"; do
    try_warn as_user gnome-extensions-cli install "$ext"
    try_warn as_user gnome-extensions-cli enable "$ext"
  done
  ok "extensões instaladas"
else
  warn "gnome-extensions-cli não disponível — pulando"
fi
phase_end "$_f0" "extensões do GNOME instaladas"