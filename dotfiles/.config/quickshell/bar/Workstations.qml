pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland

MouseArea {
        id: root

        Image {
		source: "assets/hotbar.png"
                fillMode: Image.PreserveAspectFit
                smooth: false
        }

        Repeater {
                model: 9
                MouseArea {
                        id: click
                        required property int index
                        x: 20 * index
                        width: 20
                        height: 20
                        onClicked: {
                                Hyprland.dispatch(`workspace ${index+1}`)
                        }

                        Image {

                                function getImage() {
                                        for (let i=0; i<9; i++) {
                                                if (Hyprland.workspaces.values[i] == null) {
                                                        continue;
                                                }

                                                if (Hyprland.workspaces.values[i].id == click.index+1) {
                                                        let workspace = Hyprland.workspaces.values[i]
                                                        let asset =  "assets/items/diamond_pickaxe.png"

                                                        workspace.toplevels.values.forEach(toplevel => {
                                                                if (['vi', 'vim', 'nvim'].includes(toplevel.title)) {
                                                                        asset = "assets/items/writable_book.png"
                                                                        return
                                                                }

                                                                if (toplevel.title.includes('Zen Browser')) {
                                                                        asset = "assets/items/compass_13.png"
                                                                        return
                                                                }

                                                                if (toplevel.title.includes('Discord')) {
                                                                        asset = "assets/items/oak_sign.png"
                                                                        return
                                                                }

                                                                if (toplevel.title.includes('tmux')) {
                                                                        asset = "assets/items/command_block_minecart.png"
                                                                        return
                                                                }

                                                                if (toplevel.title.includes('Yazi')) {
                                                                        asset = "assets/items/recovery_compass_13.png"
                                                                        return
                                                                }
                                                        });

                                                        return asset
                                                }
                                        }
                                        return ""
                                }

                                source: getImage() 
                                x: 3
                                y: 3
                                smooth: false
                        }
                }
        }
        
        Image {
                x: 20 * (Hyprland.focusedWorkspace.id - 1)

		source: "assets/hotbar_selection.png"
                fillMode: Image.PreserveAspectFit
                smooth: false
        }

        
}
