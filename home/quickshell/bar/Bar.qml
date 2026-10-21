import QtQuick
import Quickshell
import Quickshell.Wayland
import qs

PanelWindow {
    id: bar

    required property ShellScreen modelData

    screen: modelData
    anchors {
        top: true
        left: true
        right: true
    }
    margins {
        top: Theme.gapsOut
        left: Theme.gapsOut
        right: Theme.gapsOut
    }
    implicitHeight: Theme.barHeight
    color: "transparent"

    // Hyprland blurs behind this namespace (layer_rule in home/hyprland.nix)
    WlrLayershell.namespace: "quickshell:bar"

    Rectangle {
        id: body
        anchors.fill: parent
        radius: Theme.barRadius
        color: Theme.alpha(Theme.bg, 0.78)
        border.width: 1
        border.color: Theme.alpha(Theme.border, 0.6)

        readonly property int inset: (Theme.barHeight - Theme.chipHeight) / 2

        Row {
            id: left
            anchors {
                left: parent.left
                leftMargin: body.inset
                verticalCenter: parent.verticalCenter
            }
            spacing: 6

            LauncherButton {}

            Workspaces {
                screen: bar.screen
            }

            WindowTitle {
                screen: bar.screen
                // Never run into the centred clock
                maxWidth: clock.x - left.x - x - 16
            }
        }

        Clock {
            id: clock
            anchors.centerIn: parent
        }

        Row {
            anchors {
                right: parent.right
                rightMargin: body.inset
                verticalCenter: parent.verticalCenter
            }
            spacing: 6

            Tray {
                barWindow: bar
            }
            Stats {}
            Volume {}
            Network {}
            Battery {}
        }
    }
}
