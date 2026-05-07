pragma Singleton
import QtQuick

QtObject {
    // Tokyo Night Storm palette
    readonly property color bg:      "#24283b"
    readonly property color bgDark:  "#1f2335"
    readonly property color bgDeep:  "#1a1b26"
    readonly property color surface: "#292e42"
    readonly property color overlay: "#3b4261"
    readonly property color fg:      "#c0caf5"
    readonly property color fgDim:   "#a9b1d6"
    readonly property color comment: "#565f89"
    readonly property color blue:    "#7aa2f7"
    readonly property color cyan:    "#7dcfff"
    readonly property color green:   "#9ece6a"
    readonly property color red:     "#f7768e"
    readonly property color orange:  "#ff9e64"
    readonly property color purple:  "#bb9af7"
    readonly property color yellow:  "#e0af68"

    readonly property color glass:   Qt.rgba(26, 27, 38, 0.88)
    readonly property color panelBg: Qt.rgba(31, 35, 53, 0.97)

    readonly property int barHeight:  36
    readonly property int panelWidth: 320
    readonly property int radius:     12
    readonly property int radiusSm:   8
    readonly property int spacing:    8
    readonly property int padding:    14

    readonly property string font:   "JetBrainsMono Nerd Font"
    readonly property string fontUI: "Inter"
    readonly property int fontSm: 11
    readonly property int fontMd: 13
    readonly property int fontLg: 15
}
