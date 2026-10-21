pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// CPU and memory usage from /proc, sampled every 2s.
Singleton {
    id: root

    property real cpu: 0 // 0..1
    property real memory: 0 // 0..1
    property real memUsedGiB: 0
    property real memTotalGiB: 0

    property var lastCpu: null

    FileView {
        id: stat
        path: "/proc/stat"
        onLoaded: root.parseStat(text())
    }

    FileView {
        id: meminfo
        path: "/proc/meminfo"
        onLoaded: root.parseMem(text())
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            stat.reload();
            meminfo.reload();
        }
    }

    function parseStat(text) {
        // First line: "cpu  user nice system idle iowait irq softirq steal ..."
        const fields = text.slice(0, text.indexOf("\n")).trim().split(/\s+/).slice(1).map(Number);
        const idle = fields[3] + (fields[4] || 0);
        const total = fields.reduce((a, b) => a + b, 0);
        if (lastCpu && total > lastCpu.total)
            cpu = 1 - (idle - lastCpu.idle) / (total - lastCpu.total);
        lastCpu = {
            idle,
            total
        };
    }

    function parseMem(text) {
        const kib = key => Number((text.match(new RegExp(`^${key}:\\s+(\\d+)`, "m")) || [0, 0])[1]);
        const total = kib("MemTotal");
        const used = total - kib("MemAvailable");
        if (total > 0) {
            memory = used / total;
            memUsedGiB = used / 1048576;
            memTotalGiB = total / 1048576;
        }
    }
}
