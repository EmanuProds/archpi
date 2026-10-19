# Fase 2: remoção de bloatware.

BLOATWARE="gnome-connections gnome-contacts gnome-maps gnome-music gnome-software epiphany htop vim"
to_remove=()
for p in $BLOATWARE; do
  pacman -Q "$p" >/dev/null 2>&1 && to_remove+=("$p")
done
if [ "${#to_remove[@]}" -eq 0 ]; then
  ok "bloatware já removido — pulando"
else
  run_spin "removendo bloatware" sudo pacman -Rsc --noconfirm "${to_remove[@]}"
  ok "bloatware removido"
fi