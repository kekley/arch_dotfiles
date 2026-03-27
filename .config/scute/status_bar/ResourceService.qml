pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var memory
    property var disks
    property var cpus

    Process {
        id: resourceProc
        command: ["./Assets/binaries/bar_sysinfo"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                const obj = JSON.parse(data);
                for (var key in obj) {
                    root[key] = obj[key];
                }
            }
        }
        Component.onCompleted: running = true
    }
}
