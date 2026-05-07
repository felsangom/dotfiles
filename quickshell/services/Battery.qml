pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    readonly property int    percent:  parseInt(capFile.text)    || 0
    readonly property string status:   statusFile.text.trim()    || "Unknown"
    readonly property bool   charging: status === "Charging" || status === "Full"

    property FileView capFile: FileView {
        path: "/sys/class/power_supply/BAT0/capacity"
        watchChanges: true
    }
    property FileView statusFile: FileView {
        path: "/sys/class/power_supply/BAT0/status"
        watchChanges: true
    }
}
