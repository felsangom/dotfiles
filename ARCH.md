Felipe, essa é uma dúvida clássica. Como um arquiteto de sistemas, minha recomendação é: não instale o Hyprland pelo archinstall. 

  O archinstall é excelente para o "alicerce" (particionamento, usuários, kernel), mas para um ambiente especializado com NVIDIA e Wayland, é muito mais seguro e transparente fazer a "alvenaria" (Hyprland e
  periféricos) manualmente após o primeiro reboot. Isso evita que o instalador coloque drivers genéricos ou configurações de portal que podem conflitar com a sua RTX 4050.

  Aqui está a sua Checklist de Compras Tecnológicas para o archinstall e logo depois:

  1. No archinstall (O Alicerce)
  Selecione apenas o básico para garantir que o sistema respire:
   * Profile: Minimal (não escolha desktop environment).
   * Kernel: linux (ou linux-zen se quiser um scheduler mais otimizado para desktop/jogos).
   * Drivers: Selecione Nvidia (proprietary) — isso vai instalar o pacote base, mas nós vamos conferir depois.
   * Network: NetworkManager.
   * Optional Repositories: Ative o multilib (CRÍTICO para rodar o Steam e jogos 32-bit).

  2. Pacotes Essenciais (A lista curada para o seu setup)
  Após o primeiro boot, você estará no terminal (TTY). Rode este comando para preparar o terreno para o Tokyo Night Storm:

    1 # Drivers e Base (DKMS reconstrói o driver em cada update de kernel automaticamente)
    2 sudo pacman -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings \
    3              linux-headers git base-devel
    4
    5 # Hyprland e Core Wayland
    6 sudo pacman -S hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland
    7
    8 # A Estética (Tokyo Night & Widgets)
    9 sudo pacman -S waybar \
   10              rofi-wayland \
   11              swww \
   12              kitty \
   13              dunst \
   14              pavucontrol \
   15              brightnessctl \
   16              ttf-cascadia-code-nerd \
   17              nautilus # ou seu file manager preferido

  3. O "Segredo do Chef" para NVIDIA RTX 40-series
  Para evitar o temido "flickering" ou tela preta no boot do Hyprland, você precisa editar o arquivo do GRUB (ou seu bootloader) para ativar o DRM:

   1. Edite o /etc/default/grub.
   2. Na linha GRUB_CMDLINE_LINUX_DEFAULT, adicione: nvidia-drm.modeset=1.
   3. Rode sudo grub-mkconfig -o /boot/grub/grub.cfg.

  Por que essa abordagem?
  Com 20 anos de experiência, você sabe que se algo der errado no Wayland, 90% das vezes é o XDG-Desktop-Portal ou o Driver Modesetting. Fazendo manual, se o Hyprland não subir, você sabe exatamente em qual log
  olhar, sem "mágica" de instalador automático atrapalhando.

  Felipe, salve essa lista. Quando você estiver no Arch, com o terminal aberto e essa RTX 4050 roncando, o próximo passo será criar o hyprland.conf que vai dar vida a esse setup. 

  Alguma dúvida sobre a parte de áudio (Pipewire) ou rede, ou podemos fechar o manifesto assim?
