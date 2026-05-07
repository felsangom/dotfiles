import QtQuick
import Quickshell
import Quickshell.Wayland
import "./theme"
import "./globals"
import "./modules/bar"
import "./modules/panel"

ShellRoot {
    Variants {
        model: Quickshell.screens

        delegate: Item {
            id: screenScope
            required property var modelData

            // ── Top bar ───────────────────────────────────────────────
            WlrLayershell {
                screen: screenScope.modelData
                layer: WlrLayer.Top
                exclusiveZone: Theme.barHeight
                namespace: "qs-bar"
                height: Theme.barHeight
                anchors { top: true; left: true; right: true }

                TopBar {
                    anchors.fill: parent
                    screen: screenScope.modelData
                }
            }

            // ── Control panel ─────────────────────────────────────────
            WlrLayershell {
                screen: screenScope.modelData
                layer: WlrLayer.Overlay
                namespace: "qs-panel"
                visible: State.panelOpen
                width: Theme.panelWidth
                height: 560
                anchors { top: true; right: true }
                margins { top: Theme.barHeight + 6; right: 8 }
                keyboardFocus: WlrKeyboardFocus.OnDemand

                Keys.onEscapePressed: State.panelOpen = false

                ControlPanel {
                    anchors.fill: parent
                }
            }
        }
    }
}
