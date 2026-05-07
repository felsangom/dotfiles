# Architecture:

  shell.qml                   ← entry point, creates bar + panel per screen
  theme/Theme.qml             ← Tokyo Night Storm singleton (colors, metrics, fonts)
  globals/State.qml           ← shared state (panelOpen, powerMenuOpen)
  services/
    Audio.qml                 ← PipeWire via Quickshell.Services.Pipewire
    Battery.qml               ← reads /sys/class/power_supply/BAT0/*
    Brightness.qml            ← brightnessctl via Process
    Network.qml               ← nmcli polling every 5s
  modules/bar/
    TopBar.qml                ← glass bar with 3 zones
    Workspaces.qml            ← animated pill indicators, Hyprland IPC dispatch
    Clock.qml                 ← HH:mm + ddd dd MMM
    StatusIndicators.qml      ← battery/wifi/volume icons, click → toggle panel
  modules/panel/
    ControlPanel.qml          ← main panel (header, sliders, 6 toggle buttons)
    PowerMenu.qml             ← suspend/reboot/poweroff/logout/switch user
    SliderWidget.qml          ← reusable draggable slider
    ToggleButton.qml          ← reusable toggle with optional arrow

  Things to tweak before or right after first launch:

  1. hyprland.conf — add the blur rules:
  layerrule = blur, qs-bar
  layerrule = ignorezero, qs-bar
  layerrule = blur, qs-panel
  layerrule = ignorezero, qs-panel
  2. services/Battery.qml — change BAT0 to BAT1 if your laptop uses that path (ls /sys/class/power_supply/).
  3. modules/panel/ControlPanel.qml — the Night Light command uses São Paulo coordinates (-23.5 / -46.6), adjust if needed.
  4. Workspaces.qml — if Hyprland.focusedMonitor?.activeWorkspace?.id throws a type error, the fallback is Hyprland.activeWorkspace?.id.

  Launch with:
  qs --config ~/.config/quickshell/shell.qml


# Quais softwares devo instalar para ter o ambiente funcional, além do quickshell?

● Analisando o código gerado, aqui está tudo que é necessário, organizado por categoria:

  Core obrigatório:
  sudo pacman -S qt6-base qt6-declarative qt6-svg qt6-wayland
  sudo pacman -S pipewire wireplumber pipewire-pulse  # áudio nativo no Quickshell
  sudo pacman -S networkmanager                        # nmcli para Wi-Fi
  sudo pacman -S brightnessctl                         # controle de brilho

  Hyprland ecosystem:
  sudo pacman -S hyprland hyprlock
  yay -S hyprshot   # screenshots (usa grim+slurp por baixo)

  Painel — toggles e ações:
  sudo pacman -S bluez blueman          # Bluetooth + blueman-manager
  sudo pacman -S nm-connection-editor   # botão de seta do Wi-Fi
  sudo pacman -S wlsunset               # Night Light
  sudo pacman -S rfkill                 # Airplane Mode (geralmente já vem)

  Fontes:
  yay -S ttf-jetbrains-mono-nerd  # obrigatória — usada em tudo no bar
  sudo pacman -S inter-font        # usada nos toggles/UI

  ---
  O que você pode trocar ou pular:

  ┌─────────────────────────────────┬─────────────────────────────────────────────────┐
  │      Referência no código       │                   Alternativa                   │
  ├─────────────────────────────────┼─────────────────────────────────────────────────┤
  │ gnome-control-center (Settings) │ pavucontrol, ou remova o botão                  │
  ├─────────────────────────────────┼─────────────────────────────────────────────────┤
  │ dm-tool switch-to-greeter       │ só funciona com LightDM; remove se usar SDDM    │
  ├─────────────────────────────────┼─────────────────────────────────────────────────┤
  │ wlsunset                        │ gammastep (troca o comando no ControlPanel.qml) │
  ├─────────────────────────────────┼─────────────────────────────────────────────────┤
  │ hyprshot                        │ grim -g "$(slurp)" inline                       │
  └─────────────────────────────────┴─────────────────────────────────────────────────┘

  Antes de testar, habilite os serviços:
  systemctl --user enable --now pipewire pipewire-pulse wireplumber
  systemctl enable --now NetworkManager
  systemctl enable --now bluetooth

  O único risco real de runtime é o Quickshell.Services.Pipewire — ele exige que o Quickshell tenha sido compilado com suporte a PipeWire. O pacote quickshell-git do AUR geralmente já vem com isso, mas se der erro
   de módulo, a alternativa é substituir Audio.qml para usar pamixer via Process (sudo pacman -S pamixer).
