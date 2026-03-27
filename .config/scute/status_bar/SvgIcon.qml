import QtQuick
import QtQuick.Effects

Item {
    id: root
    required property string source
    property real scaleFactor: 1.0
    property color tintColor: "white"
    property real colorization: 0.0
    property real brightness: 0.0

    implicitWidth: icon.width
    implicitHeight: icon.height

    Image {
        id: icon
        source: root.source
        sourceSize: Qt.size(img.sourceSize.width * root.scaleFactor, img.sourceSize.height * root.scaleFactor)
        Image {
            id: img
            source: icon.source
            width: 0
            height: 0
        }
        mipmap: true
        visible: false
    }
    MultiEffect {
        source: icon
        anchors.fill: parent
        colorization: root.colorization
        colorizationColor: root.tintColor
        brightness: root.brightness
    }
}
