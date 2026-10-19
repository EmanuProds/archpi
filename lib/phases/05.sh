# Fase 5: codecs e aceleração de vídeo.

_f0=$FAIL_COUNT
for p in lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader ffmpeg ffmpegthumbnailer libva libva-utils; do
  rpm_installed "$p" || run_spin "instalando $p" sudo pacman -S --noconfirm "$p"
done
ok "codecs e VA-API instalados"
phase_end "$_f0" "codecs prontos"