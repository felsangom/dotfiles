import QtQuick
import QtQuick.Layouts
import "../../theme"

Rectangle {
    id: root
    property var screen

    color: Theme.glass
    border.color: Qt.rgba(255, 255, 255, 0.05)
    border.width: 1

    RowLayout {
        anchors { fill: parent; leftMargin: 12; rightMargin: 12 }
        spacing: 0

        Workspaces {}

        Item { Layout.fillWidth: true }

        Clock { Layout.alignment: Qt.AlignVCenter }

        Item { Layout.fillWidth: true }

        StatusIndicators {}
    }
}
