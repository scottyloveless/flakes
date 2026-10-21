import QtQuick
import qs
import qs.services
import qs.widgets

// Click to mute, scroll to change volume.
Chip {
    id: root

    readonly property color tint: Audio.muted ? Theme.muted : Theme.yellow

    interactive: true
    accent: Theme.yellow
    spacing: 8
    onClicked: Audio.toggleMute()
    onScrolled: w => Audio.setVolume(Audio.volume + (w.angleDelta.y > 0 ? 0.05 : -0.05))

    Label {
        text: Audio.muted ? "󰝟" : Audio.volume < 0.34 ? "󰕿" : Audio.volume < 0.67 ? "󰖀" : "󰕾"
        color: root.tint
        font.pixelSize: 16
    }

    // Level meter
    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: 40
        height: 4
        radius: 2
        color: Theme.alpha(root.tint, 0.2)

        Rectangle {
            width: parent.width * Math.min(1, Audio.volume)
            height: parent.height
            radius: parent.radius
            color: root.tint

            Behavior on width {
                NumberAnimation {
                    duration: Theme.animFast
                    easing.type: Easing.OutCubic
                }
            }
        }
    }

    Label {
        text: Math.round(Audio.volume * 100) + "%"
        width: 34
        color: Theme.subtext
    }
}
