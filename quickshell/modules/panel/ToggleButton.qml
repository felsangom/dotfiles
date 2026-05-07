import QtQuick
import QtQuick.Layouts
import "../../theme"

Rectangle {
    id: root

    property string icon:     ""
    property string label:    ""
    property string sublabel: ""
    property bool   active:   false
    property bool   hasArrow: false

    signal clicked()
    signal arrowClicked()

    implicitHeight: 54
    radius: Theme.radiusSm
    color: active
        ? Qt.rgba(122, 162, 247, 0.18)
        : Qt.rgba(41, 46, 66, 0.6)
    border.color: active ? Qt.rgba(122, 162, 247, 0.35) : "transparent"
    border.width: 1

    RowLayout {
        anchors {
            left: parent.left; right: hasArrow ? divider.left : parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 10; rightMargin: 6
        }
        spacing: 8

        Text {
            text: root.icon
            color: root.active ? Theme.blue : Theme.fgDim
            font.family: Theme.font; font.pixelSize: 16
        }
        Column {
            spacing: 2
            Text {
                text: root.label
                color: root.active ? Theme.fg : Theme.fgDim
                font.family: Theme.fontUI; font.pixelSize: Theme.fontSm
                font.bold: root.active
            }
            Text {
                visible: root.sublabel !== ""
                text: root.sublabel
                color: Theme.comment
                font.family: Theme.fontUI; font.pixelSize: 9
                elide: Text.ElideRight
            }
        }
    }

    Rectangle {
        id: divider
        visible: root.hasArrow
        width: 1; height: parent.height * 0.5
        anchors { right: arrowZone.left; verticalCenter: parent.verticalCenter }
        color: Qt.rgba(255, 255, 255, 0.08)
    }

    Rectangle {
        id: arrowZone
        visible: root.hasArrow
        width: 30; height: parent.height
        anchors.right: parent.right
        color: arrowMa.containsMouse ? Qt.rgba(255, 255, 255, 0.07) : "transparent"
        radius: Theme.radiusSm

        Text {
            anchors.centerIn: parent
            text: "›"; color: Theme.comment; font.pixelSize: 16
        }
        MouseArea {
            id: arrowMa; anchors.fill: parent
            hoverEnabled: true; onClicked: root.arrowClicked()
        }
    }

    MouseArea {
        id: mainMa
        anchors { fill: parent; rightMargin: root.hasArrow ? 31 : 0 }
        hoverEnabled: true; onClicked: root.clicked()
    }

    // Hover tint
    Rectangle {
        anchors { fill: parent; rightMargin: root.hasArrow ? 31 : 0 }
        radius: Theme.radiusSm
        color: mainMa.containsMouse ? Qt.rgba(255, 255, 255, 0.04) : "transparent"
    }
}
