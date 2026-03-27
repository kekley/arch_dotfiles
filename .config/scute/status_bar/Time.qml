import QtQuick

Item {
    id: root
    required property int barHeight
    required property color textColor
    required property color bgColor
    required property string textFont
    required property real textSize

    implicitWidth: pill.width
    implicitHeight: pill.height

    PillContainer {
        id: pill
        bgColor: root.bgColor
        itemHeight: root.barHeight
        Text {
            text: TimeService.shortTime
            color: root.textColor
            font {
                family: root.textFont
                pixelSize: root.textSize
                bold: true
            }
        }
    }
}
