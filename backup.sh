#!/bin/bash
rm -r dotfiles
mkdir -p dotfiles/.config
cp -r ~/.config/fastfetch dotfiles/.config/
cp -r ~/.config/nvim dotfiles/.config/
cp -r ~/.config/quickshell dotfiles/.config/
cp -r ~/.config/hypr dotfiles/.config/
cp -r ~/.config/kitty dotfiles/.config/
cp ~/.tmux.conf dotfiles/

mkdir -p dotfiles/.local/share/applications
cp ~/.local/share/applications/settings.desktop dotfiles/.local/share/applications/
