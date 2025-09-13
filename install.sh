#!/bin/sh

username=$(whoami)
echo "WARNING. THIS PROCESS WILL DELETE YOUR DOTFILES. PLEASE MAKE BACKUP BEFORE DOING THIS"
echo ""

while true; do
        echo "username: $username?"
        read -p "(y / n) : " answer
        
        case "$answer" in
                [Yy]* )
                        break
                        ;;
                [Nn]* )
                        read -p "username: " username
                        ;;
        
                * )
                        ;;
        esac
        echo ""
done

if [ ! -d "/home/$username/" ]; then
        echo "/home/$username/ not exists"
        exit 1
fi

echo "Changing file paths in dotfiles..."
find "./dotfiles/" -type f -exec sed -i "s/fuck/$username/g" {} +
echo "done!"
echo ""

while true; do
        read -p "Install packages (y/n)? " answer
        
        case "$answer" in
                [Yy]* )
                        sudo pacman -S hyprland kitty neovim fastfetch pipewire pulseaudio birghtnessctl upower qiuckshell tmux hypridle
                        hyprpm update
                        hyprpm add https://codeberg.org/zacoons/imgborders 
                        break
                        ;;
                [Nn]* )
                        break
                        ;;
        
                * )
                        ;;
        esac
        echo ""
done

while true; do
        read -p "Backup ~/.config (y/n)? " answer
        
        case "$answer" in
                [Yy]* )
                        cp -r /home/$username/.config /home/$username/.config.bak
                        break
                        ;;
                [Nn]* )
                        break
                        ;;
        
                * )
                        ;;
        esac
        echo ""
done

while true; do
        read -p "Install dotfiles? (y/n)? " answer
        
        case "$answer" in
                [Yy]* )
                        mkdir -p /home/$username/.local/share/applications
                        cp ./dotfiles/.local/share/applications/settings.desktop /home/$username/.local/share/applications

                        mkdir -p /home/$username/.config/
                        rm -r /home/$username/.config/fastfetch
                        rm -r /home/$username/.config/hypr
                        rm -r /home/$username/.config/nvim
                        rm -r /home/$username/.config/quickshell
                        cp -r dotfiles/.config/* /home/$username/.config/

                        cp dotfiles/.tmux.conf /home/$username/.tmux.donf

                        git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim 
                        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

                        nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
                        tmux source ~/.tmux.conf
                        break
                        ;;
                [Nn]* )
                        break
                        ;;
        
                * )
                        ;;
        esac
        echo ""
done

echo "done! reboot please"
sudo reboot
