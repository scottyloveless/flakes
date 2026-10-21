import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs
import qs.widgets

// App id + title of the focused window, hidden on an empty workspace.
Row {
    id: root

    required property ShellScreen screen
    property real maxWidth: 400

    readonly property HyprlandToplevel window: Hyprland.activeToplevel
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    readonly property string appId: window?.wayland?.appId ?? ""

    anchors.verticalCenter: parent.verticalCenter
    leftPadding: 6
    spacing: 8
    visible: window !== null && window.workspace === monitor?.activeWorkspace && window.title !== ""

    Label {
        id: app
        text: root.appId.split(".").pop().toLowerCase()
        color: Theme.purple
        font.weight: Font.Bold
        visible: text !== ""
    }

    Label {
        width: Math.min(implicitWidth, root.maxWidth - app.width - root.spacing - root.leftPadding)
        text: root.window?.title ?? ""
        color: Theme.subtext
        font.weight: Font.Medium
        elide: Text.ElideRight
    }
}
