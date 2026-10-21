import QtQuick
import Quickshell
import qs
import qs.widgets

Chip {
    padding: 14
    spacing: 10

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    Label {
        text: Qt.formatDateTime(clock.date, "HH:mm")
        color: Theme.fg
        font.pixelSize: 15
        font.weight: Font.Bold
    }

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: 4
        height: 4
        radius: 2
        color: Theme.purple
    }

    Label {
        text: Qt.formatDateTime(clock.date, "ddd d MMM")
        color: Theme.subtext
    }
}
