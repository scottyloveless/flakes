pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

// Default output device. Shared by the bar now, and an OSD / volume popout later.
Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property real volume: sink?.audio?.volume ?? 0
    readonly property bool muted: sink?.audio?.muted ?? false

    // Node properties (volume, mute) are only live while the node is tracked
    PwObjectTracker {
        objects: [root.sink]
    }

    function setVolume(v) {
        if (!sink?.audio)
            return;
        sink.audio.muted = false;
        sink.audio.volume = Math.max(0, Math.min(1, v));
    }

    function toggleMute() {
        if (sink?.audio)
            sink.audio.muted = !sink.audio.muted;
    }
}
