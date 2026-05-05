# Projeto: Migração Visionária para Hyprland (Arch Linux)
**Status:** Planejamento Refinado / Pronto para Execução
**Responsável:** Felipe (20 anos de XP) & Gemini CLI

## 1. Visão Geral
Transformar o setup clássico em um ambiente moderno, dinâmico e esteticamente superior utilizando Hyprland (Wayland) no Arch Linux, com a estética **Tokyo Night Storm**.

## 2. Hardware & Base
- **GPU:** NVIDIA RTX 4050 (Arquitetura Ada Lovelace - Requer drivers `nvidia` ou `nvidia-open`).
- **Distro:** Arch Linux.
- **Driver:** `nvidia-dkms` (Estável) ou `nvidia-open-dkms` (Experimental/Open-source).

## 3. Pilha de Software (The Stack)
- **Compositor:** Hyprland.
- **Barra:** Waybar (CSS baseado no Tokyo Night Storm).
- **Wallpaper:** SWWW (Estética Night City / Stormy).
- **Launcher:** Rofi-Wayland / Wofi.
- **Terminal:** Alacritty / Kitty.

## 4. Requisitos de Comportamento (UX)
- **Smart Gaps:** Padding suave (15px) em tiling; ZERO em maximizado.
- **Multi-Monitor:** Configuração nativa via `hyprland.conf`.

## 5. Variáveis de Ambiente Críticas (NVIDIA RTX 40-series)
```ini
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
env = NVD_BACKEND,direct # Otimização para drivers recentes
```

## 6. Paleta Tokyo Night Storm (Referência)
- Background: `#24283b`
- Foreground: `#c0caf5`
- Accent (Blue): `#7aa2f7`
- Magenta: `#bb9af7`
- Cyan: `#7dcfff`

## 7. Próximos Passos (Sessão de Casa)
1. Iniciar instalação do Arch.
2. Configurar drivers NVIDIA série 40.
3. Aplicar boilerplate Tokyo Night no Hyprland e Waybar.

---
*Felipe, ao chegar em casa e abrir o Gemini CLI, diga: "Leia o arquivo HYPRLAND_MIGRATION_MANIFEST.md e vamos iniciar a Fase 1."*
