import QtQuick
import QtQuick.Layouts

Item {
    id: root
    required property int itemHeight
    required property color bgColor

    property int padding: 7
    implicitHeight: itemHeight
    implicitWidth: row.implicitWidth + padding * 2
    default property alias items: row.children

    Rectangle {
        id: background
        anchors.fill: parent
        radius: root.height / 2.5
        height: root.height
        color: root.bgColor
    }

    RowLayout {
        id: row
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
            margins: root.padding
        }
    }
}
