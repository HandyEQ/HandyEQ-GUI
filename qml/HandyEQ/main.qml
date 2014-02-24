import QtQuick 2.1
import QtQuick.Controls 1.0

Rectangle {
    id: baseWindow
    width: 800
    height: 500

    Item {
        id: containerTop
        x: 0
        y: 0
        width: parent.width
        height: 100

        Text {
            id: applicationName
            x: 8
            y: 8
            text: qsTr("HandyEQ")
            font.bold: true
            font.pointSize: 30
            font.family: "Courier"
        }
    }

    Item {
        id: containerRight
        x: 0
        y: containerTop.height
        width: 140
        height: 400

        Item {
            id: menuContainer
            x: 0
            y: 0
            width: parent.width
            height: parent.height-logoContainer.height

            Column{
                width: parent.width
                Rectangle {
                    id: mainButtonContainer
                    height: 40
                    width: parent.width
                    radius: 10
                    Text {
                        id: mainButtonText
                        anchors.centerIn: parent
                        text: "Main"
                    }
                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: mainButtonContainer
                    }
                }
                Rectangle {
                    id: delayButtonContainer
                    height: 40
                    width: parent.width
                    radius: 20
                    Text {
                        anchors.centerIn: parent
                        text: "Delay"
                    }
                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                    }
                }
                Rectangle {
                    id: echoButtonContainer
                    height: 40
                    width: parent.width
                    radius: 20
                    Text {
                        anchors.centerIn: parent
                        text: "Echo"
                    }
                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                    }
                }
                Rectangle {
                    id: chourusButtonContainer
                    height: 40;
                    width: parent.width
                    radius: 20
                    Text {
                        anchors.centerIn: parent
                        text: "Chourus"
                    }

                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                    }
                }
            }
        }

        Item {
            id: logoContainer
            x: 0
            y: menuContainer.height
            width: parent.width
            height: 140

            Image {
                id: image1
                x: 0
                y: 0
                width: 140
                height: 140
                source: "qrc:/qtquickplugin/images/template_image.png"
            }
        }
    }

    Item {
        id: containerLeft
        x: parent.width-containerLeft.width
        y: containerTop.height
        width: 140
        height: parent.height-containerTop.height
    }

    Item {
        id: contentContainer
        x: containerRight.width
        y: containerTop.height
        width: parent.width-containerLeft.width-containerLeft.width
        height: parent.height-containerTop.height
    }

}
