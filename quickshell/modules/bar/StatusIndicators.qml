import QtQuick
import QtQuick.Layouts
import "../../theme"
import "../../globals"
import "../../services"

Rectangle {
    id: root

    implicitWidth:  row.implicitWidth + 20
    implicitHeight: Theme.barHeight
    radius: Theme.radiusSm
    color: hoverArea.containsMouse ? Qt.rgba(255, 255, 255, 0.06) : "transparent"

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: 6

        // Battery
        Text {
            text: {
                if (Battery.charging)      return "󰂄"
                if (Battery.percent > 90)  return "󰁹"
                if (Battery.percent > 70)  return "󰂀"
                if (Battery.percent > 50)  return "󰁾"
                if (Battery.percent > 30)  return "󰁼"
                if (Battery.percent > 10)  return "󰁺"
                return "󰂃"
            }
            color:  Battery.percent < 20 ? Theme.red : Theme.fgDim
            font.family: Theme.font; font.pixelSize: Theme.fontMd
        }
        Text {
            text: Battery.percent + "%"
            color: Battery.percent < 20 ? Theme.red : Theme.fgDim
            font.family: Theme.font; font.pixelSize: Theme.fontSm
        }

        Rectangle { width: 1; height: 14; color: Qt.rgba(255, 255, 255, 0.1) }

        // Network
        Text {
            text: Network.connected ? "󰤨" : "󰤭"
            color: Network.connected ? Theme.fg : Theme.comment
            font.family: Theme.font; font.pixelSize: Theme.fontMd
        }

        Rectangle { width: 1; height: 14; color: Qt.rgba(255, 255, 255, 0.1) }

        // Volume
        Text {
            text: {
                if (Audio.muted || Audio.volume === 0) return "󰖁"
                if (Audio.volume < 0.34)               return "󰕿"
                if (Audio.volume < 0.67)               return "󰖀"
                return "󰕾"
            }
            color: Audio.muted ? Theme.comment : Theme.fg
            font.family: Theme.font; font.pixelSize: Theme.fontMd
        }
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: State.togglePanel()
    }
}
