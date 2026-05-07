pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property real value: 0.5
    property real _max:  255

    // Read max and current brightness on startup
    property Process _init: Process {
        command: ["bash", "-c", "printf '%s\n%s' \"$(brightnessctl max)\" \"$(brightnessctl get)\""]
        running: true
        stdout: SplitParser {
            property bool gotMax: false
            onRead: data => {
                if (!gotMax) { root._max = parseFloat(data) || 255; gotMax = true }
                else           root.value = parseFloat(data) / root._max
            }
        }
    }

    property Process _setter: Process { id: _setter; running: false }

    function set(v) {
        value = Math.max(0.02, Math.min(1.0, v))
        _setter.command = ["brightnessctl", "set", Math.round(value * _max) + ""]
        _setter.running = true
    }
}
