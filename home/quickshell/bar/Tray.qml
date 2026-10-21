import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.widgets

// Left click activates, middle click secondary-activates, right click (or a
// menu-only item) opens the app's menu.
Chip {
    id: root

    required property QsWindow barWindow

    spacing: 10
    visible: SystemTray.items.values.length > 0

    Repeater {
        model: SystemTray.items

        MouseArea {
            id: entry

            required property SystemTrayItem modelData

            anchors.verticalCenter: parent.verticalCenter
            width: 18
            height: 18
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

            onClicked: m => {
                if (m.button === Qt.LeftButton && !modelData.onlyMenu) {
                    modelData.activate();
                } else if (m.button === Qt.MiddleButton) {
                    modelData.secondaryActivate();
                } else if (modelData.hasMenu) {
                    const p = mapToItem(null, 0, height);
                    modelData.display(root.barWindow, p.x, p.y + 10);
                }
            }
            onWheel: w => modelData.scroll(w.angleDelta.y, false)

            IconImage {
                anchors.fill: parent
                source: entry.modelData.icon
                opacity: entry.containsMouse ? 1 : 0.8

                Behavior on opacity {
                    NumberAnimation {
                        duration: 140
                    }
                }
            }
        }
    }
}
