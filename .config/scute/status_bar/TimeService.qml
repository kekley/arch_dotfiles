pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    property string shortTime

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            root.shortTime = Qt.formatDateTime(new Date(), "h:mmap | ddd, MM/dd");
        }
    }
}
