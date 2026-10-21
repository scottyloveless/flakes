import QtQuick
import qs

// Rounded container every bar module sits in. Set `interactive` to get hover tint,
// pointer cursor, and the clicked/scrolled signals.
Rectangle {
    id: chip

    default property alias content: row.data
    property alias spacing: row.spacing
    property int padding: Theme.chipPadding
    property color accent: Theme.blue
    property bool interactive: false
    readonly property bool hovered: mouse.containsMouse

    signal clicked(var mouse)
    signal scrolled(var wheel)

    implicitHeight: Theme.chipHeight
    implicitWidth: row.implicitWidth + padding * 2
    radius: Theme.chipRadius
    color: interactive && hovered ? Theme.alpha(accent, 0.16) : Theme.alpha(Theme.surface, 0.9)

    Behavior on color {
        ColorAnimation {
            duration: Theme.animFast
        }
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: Theme.animMed
            easing.type: Easing.OutCubic
        }
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 6
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        enabled: chip.interactive
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        cursorShape: Qt.PointingHandCursor
        onClicked: m => chip.clicked(m)
        onWheel: w => chip.scrolled(w)
    }
}
