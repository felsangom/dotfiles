import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../../theme"
import "../../globals"
import "../../services"
import "."

Rectangle {
    id: root

    color: Theme.panelBg
    radius: Theme.radius
    border.color: Qt.rgba(255, 255, 255, 0.06); border.width: 1

    property Process runner: Process { id: runner; running: false }
    function exec(cmd) { runner.command = ["bash", "-c", cmd]; runner.running = true }

    // Power menu overlaid on top of main content
    PowerMenu {
        anchors { fill: parent; margins: Theme.padding }
        visible: State.powerMenuOpen
        z: 10
        onBack: State.powerMenuOpen = false
    }

    ColumnLayout {
        anchors { fill: parent; margins: Theme.padding }
        spacing: Theme.spacing
        visible: !State.powerMenuOpen

        // ── Header row ───────────────────────────────────────────────
        RowLayout {
            Layout.fillWidth: true; spacing: 6

            // Battery info
            Text {
                text: {
                    if (Battery.charging)      return "󰂄"
                    if (Battery.percent > 90)  return "󰁹"
                    if (Battery.percent > 50)  return "󰁾"
                    if (Battery.percent > 20)  return "󰁼"
                    return "󰂃"
                }
                color: Theme.fgDim; font.family: Theme.font; font.pixelSize: Theme.fontMd
            }
            Text {
                text: Battery.percent + " %"
                color: Theme.fg; font.family: Theme.font; font.pixelSize: Theme.fontMd
            }

            Item { Layout.fillWidth: true }

            // Quick-action buttons
            Repeater {
                model: [
                    { icon: "󰍹", cmd: "hyprshot -m screen" },
                    { icon: "󰒓", cmd: "XDG_CURRENT_DESKTOP=GNOME gnome-control-center" },
                    { icon: "󰌾", cmd: "hyprlock" },
                ]
                delegate: Rectangle {
                    required property var modelData
                    width: 30; height: 30; radius: 6
                    color: btnMa.containsMouse ? Qt.rgba(255,255,255,0.08) : "transparent"
                    Text {
                        anchors.centerIn: parent
                        text: modelData.icon; color: Theme.fgDim
                        font.family: Theme.font; font.pixelSize: 15
                    }
                    MouseArea { id: btnMa; anchors.fill: parent; hoverEnabled: true; onClicked: root.exec(modelData.cmd) }
                }
            }

            // Power button
            Rectangle {
                width: 30; height: 30; radius: 6
                color: powerMa.containsMouse ? Qt.rgba(247,118,142,0.18) : "transparent"
                Text { anchors.centerIn: parent; text: "⏻"; color: Theme.red; font.pixelSize: 15 }
                MouseArea { id: powerMa; anchors.fill: parent; hoverEnabled: true; onClicked: State.powerMenuOpen = true }
            }
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: Qt.rgba(255,255,255,0.07) }

        // ── Sliders ──────────────────────────────────────────────────
        SliderWidget {
            Layout.fillWidth: true
            icon: {
                if (Audio.muted || Audio.volume === 0) return "󰖁"
                if (Audio.volume < 0.34)               return "󰕿"
                if (Audio.volume < 0.67)               return "󰖀"
                return "󰕾"
            }
            displayValue: Audio.volume
            onDragged: v => Audio.setVolume(v)
        }

        SliderWidget {
            Layout.fillWidth: true
            icon: {
                if (Brightness.value < 0.34) return "󰃞"
                if (Brightness.value < 0.67) return "󰃟"
                return "󰃠"
            }
            displayValue: Brightness.value
            fillColor: Theme.yellow
            onDragged: v => Brightness.set(v)
        }

        Rectangle { Layout.fillWidth: true; height: 1; color: Qt.rgba(255,255,255,0.07) }

        // ── Toggle grid ──────────────────────────────────────────────
        GridLayout {
            Layout.fillWidth: true
            columns: 2; columnSpacing: Theme.spacing; rowSpacing: Theme.spacing

            ToggleButton {
                Layout.fillWidth: true
                icon: "󰤨"; label: "Wi-Fi"; sublabel: Network.ssid
                active: Network.connected; hasArrow: true
                onClicked:      root.exec("nmcli radio wifi " + (Network.connected ? "off" : "on"))
                onArrowClicked: root.exec("nm-connection-editor")
            }
            ToggleButton {
                Layout.fillWidth: true
                icon: "󰂯"; label: "Bluetooth"
                active: false; hasArrow: true
                onClicked:      root.exec("bluetoothctl power toggle")
                onArrowClicked: root.exec("blueman-manager")
            }
            ToggleButton {
                Layout.fillWidth: true
                icon: "󰌪"; label: "Power Mode"; sublabel: "Balanced"
                active: false
            }
            ToggleButton {
                Layout.fillWidth: true
                icon: "󰖔"; label: "Night Light"
                active: false
                onClicked: root.exec("wlsunset -l -23.5 -L -46.6")
            }
            ToggleButton {
                Layout.fillWidth: true
                icon: "󰫙"; label: "Dark Style"
                active: true
            }
            ToggleButton {
                Layout.fillWidth: true
                icon: "✈"; label: "Airplane Mode"
                active: false
                onClicked: root.exec("rfkill toggle all")
            }
        }

        Item { Layout.fillHeight: true }
    }
}
