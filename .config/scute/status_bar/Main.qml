pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell

Scope {
    id: root
    property color inactiveBg: "#767522"
    property color activeBg: "#9b992d"
    property color inactiveText: "#5a5a55"
    property color activeText: "#423100"
    property color highlightedText: "#5d9aff"
    property color textColor: "#37393A"
    property string textFont: "Google Sans Flex"
    property int textSize: 14
    property int barHeight: 30
    property real rounding: 5.0
    property int numWorkspaces: 10

    Variants {
        id: variants
        model: Quickshell.screens
        PanelWindow {
            id: window
            required property var modelData
            screen: modelData
            readonly property HyprlandMonitor monitor: Hyprland.monitorFor(window.screen)
            anchors.top: true
            anchors.left: true
            anchors.right: true
            implicitHeight: root.barHeight
            color: "transparent"
            Workspaces {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                emptyWorkspaceBackground: root.inactiveBg
                activeTextColor: root.activeText
                inactiveTextColor: root.inactiveText
                hoveredTextColor: root.highlightedText
                workspaceBackground: root.activeBg
                barHeight: root.barHeight
                textSize: root.textSize
                textFont: root.textFont
                numWS: root.numWorkspaces
            }
            RowLayout {
                spacing: 3
                anchors.right: parent.right
                SystemResources {
                    textColor: root.activeText
                    bgColor: root.activeBg
                    textFont: root.textFont
                    textSize: root.textSize
                    barHeight: root.barHeight
                }
                Networks {
                    itemHeight: root.barHeight
                    bgColor: root.activeBg
                    iconColor: root.activeText
                    font: root.textFont
                    fontSize: root.textSize
                }
                Time {
                    textColor: root.activeText
                    bgColor: root.activeBg
                    textFont: root.textFont
                    textSize: root.textSize
                    barHeight: root.barHeight
                }
            }
        }
    }
}
