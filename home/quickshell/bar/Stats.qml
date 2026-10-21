import QtQuick
import qs
import qs.services
import qs.widgets

Chip {
    padding: 8
    spacing: 6

    StatRing {
        value: SystemStats.cpu
        color: SystemStats.cpu > 0.85 ? Theme.red : Theme.green
        icon: "󰍛"
    }

    Label {
        text: Math.round(SystemStats.cpu * 100) + "%"
        width: 34
        color: Theme.subtext
    }

    StatRing {
        value: SystemStats.memory
        color: SystemStats.memory > 0.85 ? Theme.red : Theme.cyan
        icon: "󰾆"
    }

    Label {
        text: SystemStats.memUsedGiB.toFixed(1) + "G"
        color: Theme.subtext
    }
}
