pragma Singleton
import QtQuick
import Quickshell.Services.Pipewire

QtObject {
    id: root

    readonly property real   volume: sink?.audio?.volume ?? 0.5
    readonly property bool   muted:  sink?.audio?.muted  ?? false
    readonly property PwNode sink:   Pipewire.defaultAudioSink

    function setVolume(v) {
        if (sink?.audio) sink.audio.volume = Math.max(0, Math.min(1, v))
    }
    function toggleMute() {
        if (sink?.audio) sink.audio.muted = !sink.audio.muted
    }
}
