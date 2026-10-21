import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.widgets

// Workspaces 1-5 always shown (more if one above 5 is active). A pill slides to the
// active one; occupied workspaces are bright, empty ones dim, urgent ones red.
Chip {
    id: root

    required property ShellScreen screen
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    readonly property int activeId: monitor?.activeWorkspace?.id ?? 1
    readonly property int shown: Math.max(5, activeId)
    readonly property int cell: 26

    padding: 4

    // Hyprland runs a Lua config, so raw dispatches are Lua expressions
    function focus(target) {
        Hyprland.dispatch(`hl.dsp.focus({ workspace = ${JSON.stringify(target)} })`);
    }

    Item {
        anchors.verticalCenter: parent.verticalCenter
        implicitWidth: root.shown * root.cell
        implicitHeight: Theme.chipHeight - 8

        WheelHandler {
            onWheel: e => root.focus(e.angleDelta.y < 0 ? "e+1" : "e-1")
        }

        Rectangle {
            id: indicator
            x: (root.activeId - 1) * root.cell + 1
            width: root.cell - 2
            height: parent.height
            radius: height / 2
            color: Theme.blue
            visible: root.activeId > 0 // hide on special workspaces (negative ids)

            Behavior on x {
                NumberAnimation {
                    duration: Theme.animMed
                    easing.type: Easing.OutBack
                    easing.overshoot: 1.1
                }
            }
        }

        Row {
            Repeater {
                model: root.shown

                MouseArea {
                    id: button

                    required property int index
                    readonly property int wsId: index + 1
                    readonly property HyprlandWorkspace ws: Hyprland.workspaces.values.find(w => w.id === wsId) ?? null
                    readonly property bool active: wsId === root.activeId
                    readonly property bool occupied: (ws?.toplevels?.values?.length ?? 0) > 0

                    width: root.cell
                    height: Theme.chipHeight - 8
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.focus(wsId)

                    Label {
                        anchors.centerIn: parent
                        text: button.wsId
                        font.weight: Font.Bold
                        color: button.active ? Theme.bgDark
                             : button.ws?.urgent ? Theme.red
                             : button.containsMouse ? Theme.cyan
                             : button.occupied ? Theme.fg
                             : Theme.muted
                    }

                    // Small dot under occupied, inactive workspaces
                    Rectangle {
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: 1
                        }
                        width: 3
                        height: 3
                        radius: 1.5
                        color: Theme.fg
                        opacity: button.occupied && !button.active ? 0.6 : 0

                        Behavior on opacity {
                            NumberAnimation {
                                duration: Theme.animFast
                            }
                        }
                    }
                }
            }
        }
    }
}
