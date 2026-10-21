import QtQuick
import Quickshell.Networking
import qs
import qs.widgets

// Wi-Fi strength + SSID, an ethernet icon when wired, or a dim "offline" icon.
Chip {
    id: root

    readonly property var devices: Networking.devices.values
    readonly property var wifi: devices.find(d => d.type === DeviceType.Wifi && d.connected) ?? null
    readonly property var wired: devices.find(d => d.type === DeviceType.Wired && d.connected) ?? null
    readonly property var network: wifi?.networks.values.find(n => n.connected) ?? null
    readonly property real strength: network?.signalStrength ?? 0

    spacing: 8

    Label {
        text: root.wired ? "󰈀"
            : !root.wifi ? "󰖪"
            : root.strength > 0.75 ? "󰤨"
            : root.strength > 0.5 ? "󰤥"
            : root.strength > 0.25 ? "󰤢"
            : "󰤟"
        color: root.wired || root.wifi ? Theme.green : Theme.muted
        font.pixelSize: 16
    }

    Label {
        visible: text !== ""
        text: root.wired ? "" : root.network?.name ?? "Offline"
        color: Theme.subtext
        width: Math.min(implicitWidth, 120)
        elide: Text.ElideRight
    }
}
