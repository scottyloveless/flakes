import QtQuick
import Quickshell
import qs
import qs.widgets

Chip {
    id: root

    interactive: true
    implicitWidth: Theme.chipHeight + 4
    onClicked: Quickshell.execDetached(["uwsm", "app", "--", "rofi", "-show", "drun"])

    Label {
        text: "" // nf-linux-nixos
        color: root.hovered ? Theme.cyan : Theme.blue
        font.pixelSize: 18
    }
}
