import QtQuick
import Quickshell.Services.UPower
import qs
import qs.widgets

// Only shown on machines with a laptop battery.
Chip {
    id: root

    readonly property var device: UPower.displayDevice
    readonly property real level: device?.percentage ?? 0 // 0..1
    readonly property bool charging: device?.state === UPowerDeviceState.Charging
    readonly property color tint: charging ? Theme.green
        : level <= 0.15 ? Theme.red
        : level <= 0.3 ? Theme.orange
        : Theme.cyan

    visible: device?.isLaptopBattery ?? false
    spacing: 6

    Label {
        readonly property var icons: ["󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹"]
        text: root.charging ? "󰂄" : icons[Math.min(9, Math.floor(root.level * 10))]
        color: root.tint
        font.pixelSize: 16
    }

    Label {
        text: Math.round(root.level * 100) + "%"
        color: Theme.subtext
    }
}
