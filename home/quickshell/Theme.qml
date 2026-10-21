pragma Singleton

import QtQuick
import Quickshell

// Tokyo Night, shared with rofi/waybar/hyprland. Every colour, size and timing lives here.
Singleton {
    readonly property color bg: "#1a1b26"
    readonly property color bgDark: "#16161e"
    readonly property color surface: "#24283b"
    readonly property color overlay: "#292e42"
    readonly property color border: "#414868"
    readonly property color muted: "#565f89"
    readonly property color subtext: "#a9b1d6"
    readonly property color fg: "#c0caf5"

    readonly property color blue: "#7aa2f7"
    readonly property color cyan: "#7dcfff"
    readonly property color purple: "#bb9af7"
    readonly property color green: "#9ece6a"
    readonly property color yellow: "#e0af68"
    readonly property color orange: "#ff9e64"
    readonly property color red: "#f7768e"

    readonly property string font: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 13

    // Bar sits gapsOut from the screen edge, matching Hyprland's general.gaps_out
    readonly property int gapsOut: 10
    readonly property int barHeight: 44
    readonly property int chipHeight: 32
    readonly property int chipRadius: 12
    readonly property int chipPadding: 10
    // Concentric corners: outer radius = chip radius + inset
    readonly property int barRadius: chipRadius + (barHeight - chipHeight) / 2

    readonly property int animFast: 140
    readonly property int animMed: 260

    function alpha(c, a) {
        return Qt.rgba(c.r, c.g, c.b, a);
    }
}
