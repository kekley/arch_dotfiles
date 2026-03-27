pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Wayland

Loader {
    id: root
    required property color bgColor
    required property color borderColor
    property Item hoverTarget
    default property Item contentItem
    property real popupBackgroundMargin: 0
    active: hoverTarget && hoverTarget.containsMouse
    sourceComponent: PanelWindow {
        id: popupWindow
        anchors.top: true
        anchors.bottom: false
        anchors.left: true
        anchors.right: false
        implicitHeight: popupBackground.implicitHeight + 20
        implicitWidth: popupBackground.implicitWidth + 20
        exclusionMode: ExclusionMode.Ignore
        exclusiveZone: 0
        color: "transparent"
        WlrLayershell.namespace: "quickshell:popup"
        WlrLayershell.layer: WlrLayer.Overlay

        mask: Region {
            item: popupBackground
        }
        margins {
            left: {
                return root.QsWindow?.mapFromItem(root.hoverTarget, (root.hoverTarget.width - popupBackground.implicitWidth) / 2, 0).x;
            }
            top: 30
            right: 30
            bottom: 30
        }
        Rectangle {
            id: popupBackground
            readonly property real margin: 10
            anchors {
                fill: parent
                leftMargin: 10 + root.popupBackgroundMargin * (!popupWindow.anchors.left)
                rightMargin: 10 + root.popupBackgroundMargin * (!popupWindow.anchors.right)
                topMargin: 10 + root.popupBackgroundMargin * (!popupWindow.anchors.top)
                bottomMargin: 10 + root.popupBackgroundMargin * (!popupWindow.anchors.bottom)
            }
            color: bgColor
            //            implicitWidth: root.contentItem.implicitWidth + margin * 2
            //           implicitHeight: root.contentItem.implicitHeight + margin * 2

            implicitWidth: childContainer.implicitWidth + margin * 2
            implicitHeight: childContainer.implicitHeight + margin * 2
            radius: 10
            border.width: 2
            border.color: root.borderColor
            Item {
                id: childContainer
                implicitWidth: root.contentItem ? root.contentItem.implicitWidth : 0
                implicitHeight: root.contentItem ? root.contentItem.implicitHeight : 0
                anchors.centerIn: parent
                children: [root.contentItem]
            }
        }
    }
}
