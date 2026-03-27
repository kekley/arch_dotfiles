pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

Rectangle {
    id: root
    required property color emptyWorkspaceBackground
    required property color workspaceBackground
    required property color inactiveTextColor
    required property color activeTextColor
    required property color hoveredTextColor
    required property string textFont
    required property int textSize
    required property int barHeight
    required property int numWS

    property int workspaceGroup: 0
    property list<bool> occupied: []

    function updateWorkspaceOccupied() {
        occupied = Array.from({
            length: root.numWS
        }, (_, i) => {
            return Hyprland.workspaces.values.some(ws => ws.id === workspaceGroup * root.numWS + i + 1) || Hyprland.focusedWorkspace?.id === workspaceGroup * root.numWS + i + 1;
        });
    }
    // Occupied workspace updates
    Component.onCompleted: updateWorkspaceOccupied()

    Connections {
        target: Hyprland.workspaces
        function onValuesChanged() {
            root.updateWorkspaceOccupied();
        }
    }

    Connections {
        target: Hyprland
        function onFocusedWorkspaceChanged() {
            root.updateWorkspaceOccupied();
        }
    }

    onWorkspaceGroupChanged: {
        updateWorkspaceOccupied();
    }

    radius: barHeight / 3.0
    implicitWidth: barHeight * (numWS)
    anchors {
        top: parent.top
        bottom: parent.bottom
    }
    color: root.emptyWorkspaceBackground
    RowLayout {
        anchors {
            centerIn: parent
        }
        spacing: 0
        Repeater {
            model: root.numWS
            Rectangle {
                id: rect
                required property int index
                color: root.occupied[index] ? root.workspaceBackground : root.emptyWorkspaceBackground
                implicitHeight: root.barHeight
                implicitWidth: root.barHeight
                property bool previousOccupied: root.occupied[index - 1] === true
                property bool nextOccupied: root.occupied[index + 1] === true
                property bool isActive: Hyprland.focusedWorkspace?.id === (rect.index + 1)
                property var radiusPrev: previousOccupied ? 0 : (width / 2)
                property var radiusNext: nextOccupied ? 0 : (width / 2)

                topLeftRadius: radiusPrev
                bottomLeftRadius: radiusPrev
                topRightRadius: radiusNext
                bottomRightRadius: radiusNext
                MouseArea {
                    id:mouseArea
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (rect.index + 1))
                }

                Text {
                    anchors {
                        centerIn: parent
                    }
                    Layout.alignment: Qt.AlignVCenter
                    text: rect.index + 1
                    color: mouseArea.containsMouse ? root.hoveredTextColor : parent.isActive ? root.activeTextColor : root.inactiveTextColor
                    font {
                        family: root.textFont
                        pixelSize: root.textSize
                        bold: true
                    }
               }
            }
        }
    }
}
