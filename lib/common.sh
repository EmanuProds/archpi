# Helpers compartilhados do archpi.

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
readonly LISTS="$SCRIPT_DIR/lists"
readonly DOTFILES_REPO="https://github.com/EmanuProds/dotfiles.git"
readonly CLONES="/tmp/archpi-clones"

readonly LOG="/tmp/archpi.log"

exec 3>&1
: > "$LOG"
exec >"$LOG" 2>&1

readonly C_RED=$'\e[1;31m' C_GRN=$'\e[1;32m' C_YEL=$'\e[1;33m' C_BLU=$'\e[1;34m' C_OFF=$'\e[0m'
step() { printf '\n%s== %s ==%s\n' "$C_BLU" "$*" "$C_OFF" >&3; printf '\n== %s ==\n' "$*"; }
ok()   { printf '%s[OK]%s %s\n'   "$C_GRN" "$C_OFF" "$*" >&3; printf '[OK] %s\n' "$*"; }
warn() { printf '%s[WARN]%s %s\n' "$C_YEL" "$C_OFF" "$*" >&3; printf '[WARN] %s\n' "$*"; }
die()  { printf '%s[FAIL]%s %s\n' "$C_RED" "$C_OFF" "$*" >&3; printf '[FAIL] %s\n' "$*" >&2; exit 1; }

FAIL_COUNT=0
mark_fail() { FAIL_COUNT=$((FAIL_COUNT + 1)); }
try_warn() { "$@" || { warn "não-crítico: $*"; mark_fail; }; }

set -o errtrace
trap 'rc=$?; printf "\n[FATAL] linha %s devolveu %s\n" "$LINENO" "$rc" >&3; printf "[FATAL] linha %s devolveu %s\n" "$LINENO" "$rc"; exit "$rc"' ERR

phase_end() {
  local antes="$1" texto="$2"
  if [ "$FAIL_COUNT" -eq "$antes" ]; then ok "$texto"; else warn "$((FAIL_COUNT - antes)) passo(s) falharam"; fi
}

[ "$(id -u)" -eq 0 ] || die "rode com sudo"
SUDO_USER="${SUDO_USER:-}"
[ -n "$SUDO_USER" ] || die "SUDO_USER indefinido"
readonly SUH="$(getent passwd "$SUDO_USER" | cut -d: -f6)"
readonly UID_R="$(id -u "$SUDO_USER")"

read_list() { grep -vE '^\s*(#|$)' "$1" | sed -e 's/[[:space:]]*#.*$//' -e 's/[[:space:]]*$//' | grep -vE '^$'; }

rpm_installed()      { pacman -Q "$1" >/dev/null 2>&1; }
flatpak_installed()  { flatpak list --system --columns=application 2>/dev/null | grep -qx "$1"; }
flatpak_appid() {
  local ref="$1"
  case "${ref%%/*}" in flathub|fedora|oci) ref="${ref#*/}" ;; esac
  printf '%s' "${ref%%/*}"
}
service_enabled() { systemctl is-enabled "$1" >/dev/null 2>&1; }
command_exists()  { command -v "$1" >/dev/null 2>&1; }

as_user() {
  runuser -u "$SUDO_USER" -- env \
    HOME="$SUH" XDG_RUNTIME_DIR="/run/user/$UID_R" \
    DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$UID_R/bus" \
    PATH="$SUH/.local/bin:$SUH/.local/share/mise/shims:/usr/local/bin:/usr/bin:/bin" \
    "$@"
}

clone_repo() {
  local url="$1" dest="$2" i
  rm -rf "$dest"
  for i in 1 2 3; do
    if timeout 120 git clone --depth 1 --quiet "$url" "$dest" 2>/dev/null; then
      ok "clone: $(basename "$dest")"
      return 0
    fi
    warn "git clone falhou (tentativa $i/3): $url"
    sleep 5
  done
  die "git clone falhou: $url"
}

ask_phase() {
  local num="$1" desc="$2" ans i
  if [ ! -t 0 ]; then return 0; fi
  printf '\n%s[Fase %s]%s %s — executar? [S/n] ' "$C_BLU" "$num" "$C_OFF" "$desc" >&3
  printf '\n[Fase %s] %s — executar? [S/n] ' "$num" "$desc"
  for ((i=10; i>=1; i--)); do
    printf '\r%s[Fase %s]%s %s — executar? [S/n] (%d) ' "$C_BLU" "$num" "$C_OFF" "$desc" "$i" >&3
    if read -r -t 1 ans; then
      case "$ans" in n|N|no|NO) printf '\n' >&3; return 1 ;; esac
      printf '\n' >&3; return 0
    fi
  done
  printf '\n' >&3
  return 0
}

run_spin() {
  local msg="$1"; shift
  local pid spinner='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏' i=0
  "$@" &
  pid=$!
  while kill -0 "$pid" 2>/dev/null; do
    printf '\r%s %s' "${spinner:i:1}" "$msg" >&3
    i=$(( (i+1) % ${#spinner} ))
    sleep 0.1
  done
  wait "$pid"
  local rc=$?
  printf '\r\033[K' >&3
  return $rc
}

sudoz() {
  echo "$SUDOPASSWORD" | sudo -S "$@"
}

npm_global_installed() { "$SUH/.local/bin/mise" exec -- npm ls -g --depth=0 2>/dev/null | grep -q " $1@"; }
omniroute_installed() { [ -x "$SUH/.local/share/mise/shims/omniroute" ] || command -v omniroute >/dev/null 2>&1; }
gopls_installed() { ls "$SUH/.local/share/mise/installs/go/"*/bin/gopls >/dev/null 2>&1; }