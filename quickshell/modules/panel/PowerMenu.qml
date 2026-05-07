import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../../theme"

Column {
    id: root
    spacing: 6

    signal back()

    property Process runner: Process { id: runner; running: false }
    function exec(cmd) { runner.command = ["bash", "-c", cmd]; runner.running = true }

    // Header
    Rectangle {
        width: parent.width; height: 60
        radius: Theme.radiusSm
        color: Qt.rgba(247, 118, 142, 0.12)
        border.color: Qt.rgba(247, 118, 142, 0.25); border.width: 1

        RowLayout {
            anchors.centerIn: parent; spacing: 12

            Rectangle {
                width: 38; height: 38; radius: 19; color: Theme.red
                Text { anchors.centerIn: parent; text: "⏻"; color: "white"; font.pixelSize: 18 }
            }
            Text {
                text: "Power Off"
                color: Theme.fg
                font.family: Theme.fontUI; font.pixelSize: Theme.fontLg; font.bold: true
            }
        }
    }

    // Actions
    property var actions: [
        { label: "Suspend",       cmd: "systemctl suspend",         hl: false },
        { label: "Restart…",      cmd: "systemctl reboot",          hl: false },
        { label: "Power Off…",    cmd: "systemctl poweroff",        hl: true  },
        { label: "Log Out…",      cmd: "hyprctl dispatch exit",     hl: false },
        { label: "Switch User…",  cmd: "dm-tool switch-to-greeter", hl: false }
    ]

    Repeater {
        model: root.actions
        delegate: Rectangle {
            required property var modelData
            width: parent.width; height: 38; radius: Theme.radiusSm
            color: ma.containsMouse
                ? (modelData.hl ? Qt.rgba(247,118,142,0.15) : Qt.rgba(255,255,255,0.05))
                : "transparent"

            Text {
                anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
                text: modelData.label
                color: modelData.hl ? Theme.red : Theme.fg
                font.family: Theme.fontUI; font.pixelSize: Theme.fontMd
            }
            MouseArea { id: ma; anchors.fill: parent; hoverEnabled: true; onClicked: root.exec(modelData.cmd) }
        }
    }

    Rectangle { width: parent.width; height: 1; color: Qt.rgba(255, 255, 255, 0.08) }

    Rectangle {
        width: parent.width; height: 36; radius: Theme.radiusSm
        color: backMa.containsMouse ? Qt.rgba(255, 255, 255, 0.05) : "transparent"

        RowLayout {
            anchors { left: parent.left; leftMargin: 12; verticalCenter: parent.verticalCenter }
            spacing: 6
            Text { text: "‹"; color: Theme.comment; font.pixelSize: 16 }
            Text { text: "Back"; color: Theme.comment; font.family: Theme.fontUI; font.pixelSize: Theme.fontMd }
        }
        MouseArea { id: backMa; anchors.fill: parent; hoverEnabled: true; onClicked: root.back() }
    }
}
