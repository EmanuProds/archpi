# Fase 3: mise (node/bun/go/usage/pipx/gh).

_f0=$FAIL_COUNT
if [ ! -x "$SUH/.local/bin/mise" ]; then
  run_spin "instalando mise" bash -c 'curl -fsSL https://mise.run | sh'
fi
if [ -x "$SUH/.local/bin/mise" ]; then
  mapfile -t TOOLS < <(read_list "$LISTS/mise.txt")
  [ "${#TOOLS[@]}" -gt 0 ] && try_warn as_user "$SUH/.local/bin/mise" use -g "${TOOLS[@]}"
  if [ -d "$SUH/.local/share/mise/shims" ]; then
    for shim in npm node bun bunx gh go pipx omniroute; do
      [ -e "$SUH/.local/share/mise/shims/$shim" ] || continue
      ln -sfn "$SUH/.local/share/mise/shims/$shim" "/usr/local/bin/$shim"
    done
    ok "shims do mise expostos em /usr/local/bin"
  fi
fi
phase_end "$_f0" "toolchains prontos"