import QtQuick

Item {
    id: root
    required property color bgColor
    required property color iconColor
    required property int itemHeight
    property string font
    property int fontSize
    implicitWidth: pill.width
    implicitHeight: pill.height

    PillContainer {
        id: pill
        bgColor: root.bgColor
        itemHeight: root.itemHeight
        SvgIcon {
            source: IconPaths.getBluetoothIcon()
            tintColor: root.iconColor
            colorization: 1.0
            brightness: 1.0
            scaleFactor: 0.7
        }
        SvgIcon {
            source: IconPaths.getNetworkIcon()
            tintColor: root.iconColor
            colorization: 1.0
            brightness: 1.0
            scaleFactor: 0.7
        }
    }
}
