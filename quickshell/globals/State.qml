pragma Singleton
import QtQuick

QtObject {
    property bool panelOpen:     false
    property bool powerMenuOpen: false

    function togglePanel() {
        panelOpen = !panelOpen
        if (!panelOpen) powerMenuOpen = false
    }
}
