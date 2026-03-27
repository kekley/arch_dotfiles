pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    function toGB(bytes) {
        return (bytes / (1024 * 1024 * 1024)).toFixed(1) + " GB";
    }

    required property int barHeight
    required property color textColor
    required property color bgColor
    required property string textFont
    required property real textSize
    implicitWidth: pill.width
    implicitHeight: pill.height
    PillContainer {
        id: pill
        itemHeight: root.barHeight
        bgColor: root.bgColor

        MouseArea {
            id: cpuHover
            hoverEnabled: true
            implicitWidth: cpuBlock.width
            implicitHeight: cpuBlock.height
            RowLayout {
                id: cpuBlock
                SvgIcon {
                    id: cpuIcon
                    source: "./Assets/cpu.svg"
                    colorization: 1
                    tintColor: root.textColor
                    brightness: 1
                    scaleFactor: 0.7
                }
                Text {
                    text: ResourceService.cpus?.global.toFixed(1) + "%"
                    color: root.textColor
                    font {
                        family: root.textFont
                        pixelSize: root.textSize
                        bold: true
                    }
                }
            }
        }
        Text {
            text: "|"
            color: root.textColor
            font {
                family: root.textFont
                pixelSize: root.textSize
                bold: true
            }
        }
        MouseArea {
            id: ramHover
            hoverEnabled: true
            implicitWidth: ramBlock.width
            implicitHeight: ramBlock.height

            RowLayout {
                id: ramBlock
                SvgIcon {
                    id: ramIcon
                    source: "./Assets/memory.svg"
                    colorization: 1
                    tintColor: root.textColor
                    brightness: 1
                    scaleFactor: 0.8
                }
                Text {
                    property real usage: {
                        const total = ResourceService.memory?.total_mem;
                        const used = ResourceService.memory?.used_mem;
                        return (used / total) * 100;
                    }
                    text: usage.toFixed(0) + "%"
                    color: root.textColor
                    font {
                        family: root.textFont
                        pixelSize: root.textSize
                        bold: true
                    }
                }
            }
        }
        Text {
            text: "|"
            color: root.textColor
            font {
                family: root.textFont
                pixelSize: root.textSize
                bold: true
            }
        }
        MouseArea {
            id: driveHover
            hoverEnabled: true
            implicitWidth: driveBlock.width
            implicitHeight: driveBlock.height
            RowLayout {
                id: driveBlock
                SvgIcon {
                    id: storageIcon
                    source: "./Assets/drive.svg"
                    colorization: 1
                    tintColor: root.textColor
                    brightness: 1
                    scaleFactor: 1.2
                }
                Text {
                    property var rootDrive: {
                        const root = ResourceService.disks?.find(disk => disk.mount_point === "/");
                        return root;
                    }
                    text: (((rootDrive?.capacity - rootDrive?.available) / rootDrive?.capacity) * 100).toFixed(1) + "%"
                    color: root.textColor
                    font {
                        family: root.textFont
                        pixelSize: root.textSize
                        bold: true
                    }
                }
            }
        }
    }
    Popup {
        hoverTarget: cpuHover
        bgColor: root.bgColor
        borderColor: root.textColor

        Column {
            spacing: 12

            Text {
                text: ResourceService.cpus?.cpu_info.brand ?? ""
                color: root.textColor
                font {
                    family: root.textFont
                    pixelSize: root.textSize + 2
                    bold: true
                }
            }

            Grid {
                spacing: 6
                columns: 2

                Repeater {
                    model: ResourceService.cpus?.cpu_info.core_info ?? []

                    delegate: Row {
                        id: del
                        required property var modelData
                        spacing: 6

                        Text {
                            width: 45
                            text: del.modelData.name
                            color: root.textColor
                            font {
                                family: root.textFont
                                pixelSize: root.textSize
                                bold: true
                            }
                        }

                        Text {
                            width: 55
                            text: (del.modelData.frequency / 1000.0).toFixed(2) + "GHz"
                            color: root.textColor
                            font {
                                family: root.textFont
                                pixelSize: root.textSize
                            }
                        }

                        Text {
                            text: "|"
                            color: root.textColor
                            font.pixelSize: root.textSize
                        }

                        Text {
                            width: 50
                            text: del.modelData.usage.toFixed(1) + "%"
                            color: root.textColor
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
    }
    Popup {
        bgColor: root.bgColor
        borderColor: root.textColor
        hoverTarget: ramHover
        Row {
            spacing: 6
            Column {
                spacing: 6
                Text {
                    text: "Memory"
                    color: root.textColor
                    font {
                        family: root.textFont
                        pixelSize: root.textSize
                        bold: true
                    }
                }
                Row {
                    spacing: 6
                    Text {
                        text: "Total:"
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                            bold: true
                        }
                    }
                    Text {
                        text: root.toGB(ResourceService.memory?.total_mem)
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                        }
                    }
                }
                Row {

                    spacing: 6
                    Text {
                        text: "Free:"
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                            bold: true
                        }
                    }
                    Text {
                        text: root.toGB(ResourceService.memory?.total_mem - ResourceService.memory?.used_mem)
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                        }
                    }
                }
                Row {

                    spacing: 6
                    Text {
                        text: "Used:"
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                            bold: true
                        }
                    }
                    Text {
                        text: root.toGB(ResourceService.memory?.used_mem)
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                        }
                    }
                }
            }
            Column {
                spacing: 6
                Text {
                    text: "Swap"
                    color: root.textColor
                    font {
                        family: root.textFont
                        pixelSize: root.textSize
                        bold: true
                    }
                }
                Row {

                    spacing: 6
                    Text {
                        text: "Total:"
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                            bold: true
                        }
                    }
                    Text {
                        text: root.toGB(ResourceService.memory?.total_swap)
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                        }
                    }
                }
                Row {

                    spacing: 6
                    Text {
                        text: "Free:"
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                            bold: true
                        }
                    }
                    Text {
                        text: root.toGB(ResourceService.memory?.total_swap - ResourceService.memory?.used_swap)
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                        }
                    }
                }
                Row {

                    spacing: 6
                    Text {
                        text: "Used:"
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                            bold: true
                        }
                    }
                    Text {
                        text: root.toGB(ResourceService.memory?.used_swap)
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                        }
                    }
                }
            }
        }
    }
    Popup {
        hoverTarget: driveHover
        bgColor: root.bgColor
        borderColor: root.textColor

        Column {
            spacing: 6
            Row {

                Text {
                    width: 158
                    text: "Mount Point"
                    color: root.textColor
                    font {
                        family: root.textFont
                        pixelSize: root.textSize
                        bold: true
                    }
                }
                Text {
                    text: "Free"
                    width: 130
                    color: root.textColor
                    font {
                        family: root.textFont
                        pixelSize: root.textSize
                        bold: true
                    }
                }
            }
            Repeater {
                model: ResourceService.disks
                delegate: Row {
                    id: driveDel
                    required property var modelData
                    spacing: 6
                    SvgIcon {
                        source: IconPaths.getDriveIcon(driveDel.modelData.kind)
                        colorization: 1
                        tintColor: root.textColor
                        brightness: 1
                        scaleFactor: 0.8
                    }
                    Text {
                        width: 120
                        text: driveDel.modelData.mount_point
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                        }
                    }
                    Text {
                        width: 130
                        text: root.toGB(driveDel.modelData.available) + " / " + root.toGB(driveDel.modelData.capacity)
                        color: root.textColor
                        font {
                            family: root.textFont
                            pixelSize: root.textSize
                        }
                    }
                }
            }
        }
    }
}
