pragma ComponentBehavior: Bound

import QtQuick

Item {
        id: root
        clip: true

        readonly property int scrollerWidth: 6
        required property Column target

        width: target.width + scrollerWidth

        Image {
                z: 99
                x: root.width-width
                source: "assets/scroller_background.png"
                width: root.scrollerWidth * 2
                height: root.height * 2
                smooth: false
        }

        BorderImage {
                z: 99
                x: root.width-width
                y: root.target.y * (root.height - root.target.height / root.height) / root.target.height * -1
                width: root.scrollerWidth * 2
                height: root.target.height / root.height
                source: "assets/scroller.png"
                smooth: false

                border {
                        left: 1
                        right: 1
                        top: 1
                        bottom: 1
                }
        }

        WheelHandler {
                acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
                onWheel: e => {
                        root.target.y += e.angleDelta.y

                        if (root.target.y > 0) root.target.y = 0
                        if (root.target.y <= - root.target.height + root.height) root.target.y = -root.target.height + root.height
                        e.accepted = true
                }
        }
}
