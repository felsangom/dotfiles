# My dotfiles

My personal linux dotfiles and configs. I've modified the multicolor theme from [awesome-copycats](https://github.com/lcpz/awesome-copycats) and added a Gruvbox material style and colors, among other improvements.
Bellow are a set of instructions on how to use it.

## AwesomeWM

Copy the ```awesome``` folder into ~/.config and reload AwesomeWM.
You'll need [awesome-wm-widgets](https://github.com/streetturtle/awesome-wm-widgets) for some awesome widgets to work. Just follow the link install instructions.
You will also need a patched font for the icons. I'm using CaskaydiaCove Nerd Font. If you chose a different font, remember to change config files accordingly (theme.lua, alacritty.yml, etc).

## Alacritty

Need a Nerd Font. Download the ones you like, and customize in config files. I'm using the CaskaydiaCove Nerd Font.

## Picom

I'm using picom as composer. The config file ajust vsync, opacity, shadow, etc.

## Bash

Install [oh-my-posh](https://ohmyposh.dev/), and choose the theme you like.

## Neovim

I've migrated all neovim configs to lua. The old init.vim was moved to old.init.vim just to save it for anyone that wants, but it will not be updated anymore.
The new neovim config uses [packer](https://github.com/wbthomason/packer.nvim) as plugin management. To use my config files, just copy nvim folder to your config directory, usually ```~/.config```.
Use ```:checkhealth``` to install missing stuff.

## Rofi themes

Get gruvbox-dark-soft that ships with rofi.

## Screenshots

![](https://github.com/felsangom/dotfiles/blob/main/screenshots/1.png)

![](https://github.com/felsangom/dotfiles/blob/main/screenshots/2.png)

## Wallpaper

https://wallpaperaccess.com/digital-art-1920x1080
