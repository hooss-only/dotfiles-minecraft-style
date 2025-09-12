pragma ComponentBehavior: Bound

import QtQuick

Item {
        id: root
        clip: true

        readonly property int scrollerHeight: 6
        required property Row target

        height: target.height + scrollerHeight

        Image {
                z: 99
                y: root.height-height
                source: "assets/scroller_background.png"
                width: root.width * 2
                height: root.scrollerHeight * 2
                smooth: false
        }

        BorderImage {
                z: 99
                x: root.target.x * (root.width - root.target.width / root.width) / root.target.width * -1
                y: root.height-height
                width: root.target.width / root.width
                height: root.scrollerHeight * 2
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
                        root.target.x += e.angleDelta.y

                        if (root.target.x > 0) root.target.x = 0
                        if (root.target.x <= root.width - root.target.width) root.target.x = root.width - root.target.width
                        e.accepted = true
                }
        }
}
