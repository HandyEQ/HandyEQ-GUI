import QtQuick 2.0

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

            ListView {
                id: menuList
                x: 0
                y: 0
                width: menuContainer.width
                height: menuContainer.height
                delegate: Item {
                    id: item1
                    width: menuList.width
                    height: menuList.height
                    Rectangle {
                        id: rectangle1
                        x: 0
                        y:0
                        width: parent.width
                        height: 40
                        Text {
                            text: name
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.family: "Trebuchet MS"
                            font.bold: true
                            font.pointSize: 16
                            styleColor: "#b1b1b1"
                            style: Text.Outline
                        }
                    }
                }
                model: ListModel {
                    ListElement {
                        name: "Owerview"
                    }

                    ListElement {
                        name: "Delay"
                    }

                    ListElement {
                        name: "Echo"
                    }

                    ListElement {
                        name: "Chourus"
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
