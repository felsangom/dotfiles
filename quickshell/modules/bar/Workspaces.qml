import QtQuick
import Quickshell.Hyprland
import "../../theme"

Row {
    spacing: 5

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            required property var modelData

            readonly property bool isActive: Hyprland.focusedMonitor?.activeWorkspace?.id === modelData.id

            height: 8
            width:  isActive ? 22 : 8
            radius: 4
            color:  isActive ? Theme.blue : Theme.overlay

            Behavior on width { NumberAnimation { duration: 180; easing.type: Easing.OutCubic } }
            Behavior on color { ColorAnimation  { duration: 150 } }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Hyprland.dispatch("workspace " + modelData.id)
            }
        }
    }
}
