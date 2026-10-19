# Fase 4: pacotes (pacman + paru).

mapfile -t PKGS < <(read_list "$LISTS/packages.txt")
[ "${#PKGS[@]}" -gt 0 ] || die "packages.txt vazio"

PKGS_FALTANDO=()
for p in "${PKGS[@]:-}"; do [ -z "$p" ] && continue; rpm_installed "$p" || PKGS_FALTANDO+=("$p"); done

if [ "${#PKGS_FALTANDO[@]}" -eq 0 ]; then
  ok "pacotes já instalados — pulando"
else
  run_spin "instalando ${#PKGS_FALTANDO[@]} pacote(s)" sudo pacman -S --noconfirm "${PKGS_FALTANDO[@]}"
  ok "${#PKGS_FALTANDO[@]} pacote(s) instalados"
fi

mapfile -t AUR_PKGS < <(read_list "$LISTS/aur.txt")
AUR_FALTANDO=()
for p in "${AUR_PKGS[@]:-}"; do [ -z "$p" ] && continue; rpm_installed "$p" || AUR_FALTANDO+=("$p"); done
if [ "${#AUR_FALTANDO[@]}" -gt 0 ]; then
  run_spin "instalando AUR packages" bash -c "echo '$SUDOPASSWORD' | paru -S --noconfirm --sudoflags '-S' ${AUR_FALTANDO[*]}"
  ok "AUR packages instalados"
else
  ok "AUR packages já instalados — pulando"
fi