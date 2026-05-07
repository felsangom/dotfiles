import QtQuick
import "../../theme"

Column {
    id: root
    spacing: 1

    property date now: new Date()
    Timer {
        interval: 1000; repeat: true; running: true; triggeredOnStart: true
        onTriggered: root.now = new Date()
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatTime(root.now, "HH:mm")
        color: Theme.fg
        font.family: Theme.font
        font.pixelSize: Theme.fontMd
        font.bold: true
    }
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: Qt.formatDate(root.now, "ddd dd MMM")
        color: Theme.comment
        font.family: Theme.font
        font.pixelSize: Theme.fontSm
    }
}
