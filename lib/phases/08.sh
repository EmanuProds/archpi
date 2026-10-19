# Fase 8: Flathub + flatpaks.

_f0=$FAIL_COUNT
if ! command_exists flatpak; then run_spin "instalando flatpak" sudo pacman -S --noconfirm flatpak; fi
try_warn flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

FLATPAK_APPS="io.github.flattool.Warehouse com.github.tchx84.Flatseal it.mijorus.gearlever io.github.flattool.Ignition com.mattjakeman.ExtensionManager be.alexandervanhee.gradia io.github.diegoivan.pdf_metadata_editor com.obsproject.Studio org.pitivi.Pitivi io.gitlab.adhami3310.Impression io.anytype.anytype org.nickvision.tubeconverter com.microsoft.Edge io.github.giantpinkrobots.varia io.github.shonebinu.Brief me.iepure.devtoolbox rest.insomnia.Insomnia io.podman_desktop.PodmanDesktop io.dbeaver.DBeaverCommunity org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark"

for app in $FLATPAK_APPS; do
  appid="$(flatpak_appid "$app")"
  if flatpak_installed "$appid"; then ok "$appid já instalado — pulando"; continue; fi
  try_warn run_spin "instalando $appid" flatpak install -y --system --noninteractive "flathub/$app"
done
phase_end "$_f0" "flatpaks instalados"