pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire
import "../components"

Column {
        id: root
        property PwNode audioSink: Pipewire.defaultAudioSink
        
        property bool muted: false
        property int volume: 0
        property var channels: []

        property var sinks: []
        property int sinkIndex: 0

        property bool init: false
        visible: false
        spacing: 5

        Row {
                spacing: 10
                McButton {
                        text: "Sink: " + root.audioSink.name
                        func: () => {
                                root.sinkIndex++
                                if (root.sinkIndex >= root.sinks.length) root.sinkIndex = 0

                                setDefaultSink.running = true
                        }
                }
        }

        Row {
                spacing: 10

                McSlider {
                        text: "Volume"
                        initialValue: root.volume

                        onPercentageChanged: {
                                if (!root.init) return
                                root.volume = percentage
                                setVolume.running = true
                        }
                }
                
                McButton {
                        text: "Mute: " + (root.muted ? "YES" : "NO")
                        func: () => {
                                toggleMute.running = true
                                root.muted = !root.muted
                        }
                }
        }

        Process {
                id: getMuted
                running: true
                command: ["pactl", "get-sink-mute", root.audioSink.name]

                stdout: StdioCollector {
                        onStreamFinished: {
                                if (this.text.includes('no')) root.muted = false;
                                else root.muted = true;
                        }
                }
        }

        Process {
                id: getVolume
                running: true
                command: ["pactl", "get-sink-volume", root.audioSink.name]

                stdout: StdioCollector {
                        onStreamFinished: {
                                const regex = /(\w+-?\w*): \d+ \/  (\d+)%/g;
                                const result = [];
                                let match;

                                let volume = 0;
                                
                                while ((match = regex.exec(this.text)) !== null) {
                                        result.push({ name: match[1], volume: parseInt(match[2], 10) });
                                        volume += parseInt(match[2], 10)
                                }

                                volume /= result.length
                                root.volume = volume

                                root.channels = result

                                root.init = true
                                console.log(root.volume)
                        }
                }
        }

        Process {
                id: setVolume
                running: false
                command: ["pactl", "set-sink-volume", root.audioSink.name, `${root.volume}%`]
        }

        Process {
                id: toggleMute
                running: false
                command: ["pactl", "set-sink-mute", root.audioSink.name, "toggle"]
        }

        Process {
                id: getSinks
                running: true
                command: ["pactl", "list", "sinks", "short"]

                stdout: StdioCollector {
                        onStreamFinished: {
                                this.text.split("\n").forEach(line => {
                                        root.sinks.push(line.split("\t")[1])
                                });
                                root.sinkIndex = root.sinks.indexOf(root.audioSink.name);
                        }
                }
        }

        Process {
                id: setDefaultSink
                running: false
                command: ["pactl", "set-default-sink", root.sinks[root.sinkIndex]]
        }

        Component.onCompleted: () => {
        }
}
