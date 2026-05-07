pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property string ssid:      ""
    property bool   connected: ssid !== ""

    property Timer poll: Timer {
        interval: 5000; repeat: true; triggeredOnStart: true
        onTriggered: wifiProc.running = true
    }

    property Process wifiProc: Process {
        command: ["nmcli", "-t", "-f", "active,ssid", "dev", "wifi"]
        onStarted: root.ssid = ""
        stdout: SplitParser {
            onRead: line => {
                if (line.startsWith("yes:")) root.ssid = line.slice(4).trim()
            }
        }
    }
}
