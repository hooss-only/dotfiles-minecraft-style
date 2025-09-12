pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.SystemTray
import ".."
import "../components"

Row {
        property var config: Config.json

        visible: config.systemTray.visible

        function getX() {
                if (opener.menu == null) return parent.width - 24 * 2 * trays.model

                return parent.width - menuScroll.width
        }

        x: getX()
        y: parent.height - 24 * 2
        id: root

        QsMenuOpener {
                id: opener
        }

        McScrollHorizontal {
                id: menuScroll
                width: 500
                height: item.height + scrollerHeight
                visible: false

                Row {
                        id: item
                        spacing: 6

                        Repeater {
                                id: buttons
                                model: opener.children.values.filter(child => !child.isSeparator)
                                McButton {
                                        required property var modelData
                                        text: modelData.text
                                        func: () => {
                                                modelData.triggered()
                                        }
                                }
                        }
                        McHalfButton {
                                id: closeMenu
                                text: "Close Menu"
                                func: () => {
                                        menuScroll.visible = false
                                        opener.menu = null
                                }
                        }
                }

                target: item
        }

        Repeater {
                id: trays
                model: SystemTray.items.values.length
                MouseArea {
                        required property int index
                        id: mouseArea
                        width: background.width
                        height: background.height

                        function getTitle() {
                                if (SystemTray.items.values[index].title != "") return SystemTray.items.values[index].title
                                else return SystemTray.items.values[index].tooltipTitle
                        }

                        ToolTip.visible: containsMouse
                        ToolTip.text: getTitle()

                        hoverEnabled: true
                        onEntered: () => {
                                background.source = "assets/effect_background_ambient.png"
                        }

                        onExited: () => {
                                background.source = "assets/effect_background.png"
                        }

                        acceptedButtons: Qt.RightButton | Qt.LeftButton | Qt.MiddleButton
                        onClicked: e => {
                                let item = SystemTray.items.values[index]
                                if (e.button == Qt.LeftButton) {
                                        item.activate()
                                }
                                else if (e.button == Qt.MiddleButton) {
                                        item.secondaryActivate()
                                } else if (item.hasMenu) {
                                        menuScroll.visible = true
                                        opener.menu = item.menu;
                                }
                        }


                        Image {
                                id: background
                                source: "assets/effect_background.png"
                                smooth: false
                                width: 24*2
                                height: 24*2

                                Image {
                                        anchors.centerIn: parent
                                        source: SystemTray.items.values[mouseArea.index].icon
                                        sourceSize.width: 20
                                        sourceSize.height: 20
                                        width: 20
                                        height: 20
                                        smooth: false
                                }
                        }
                }
        }
}
