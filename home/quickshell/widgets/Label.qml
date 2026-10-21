import QtQuick
import qs

// Text in the shell font, vertically centred when placed in a Row.
Text {
    anchors.verticalCenter: parent?.verticalCenter
    color: Theme.fg
    font.family: Theme.font
    font.pixelSize: Theme.fontSize
    font.weight: Font.DemiBold
    renderType: Text.NativeRendering

    Behavior on color {
        ColorAnimation {
            duration: Theme.animFast
        }
    }
}
