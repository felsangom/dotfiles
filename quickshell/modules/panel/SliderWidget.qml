import QtQuick
import "../../theme"

Item {
    id: root

    property string icon:         "󰕾"
    property real   displayValue: 0.5
    property color  fillColor:    Theme.blue

    signal dragged(real value)

    implicitHeight: 28

    Text {
        id: iconText
        anchors { left: parent.left; verticalCenter: parent.verticalCenter }
        text: root.icon
        color: Theme.fgDim
        font.family: Theme.font
        font.pixelSize: 16
    }

    Rectangle {
        id: track
        anchors {
            left: iconText.right; right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }
        height: 4; radius: 2
        color: Qt.rgba(86, 95, 137, 0.5)

        Rectangle {
            width: Math.max(8, track.width * root.displayValue)
            height: parent.height; radius: parent.radius
            color: root.fillColor
        }

        Rectangle {
            width: 14; height: 14; radius: 7
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            x: Math.max(0, Math.min(track.width - width, track.width * root.displayValue - width / 2))
        }

        MouseArea {
            anchors { fill: parent; margins: -10 }
            function snap(mx) { return Math.max(0, Math.min(1, mx / track.width)) }
            onPositionChanged: if (pressed) root.dragged(snap(mouseX))
            onClicked:         root.dragged(snap(mouseX))
        }
    }
}
