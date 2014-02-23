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

        Rectangle {
            id: rectangle2
            color: "#ffffff"
            radius: 1
            opacity: 1
            z: 10
            border.width: 1
            anchors.fill: parent

            Text {
                id: text1
                x: 270
                y: 20
                width: 260
                height: 61
                text: "HandyEQ"
                wrapMode: Text.NoWrap
                verticalAlignment: Text.AlignTop
                font.strikeout: false
                font.bold: false
                font.family: "Arial"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 44
            }
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
            height: 260
            anchors.bottomMargin: 140
            transformOrigin: Item.Center
            anchors.fill: parent

            ListView {
                id: menuList
                width: 140
                height: 260
                interactive: true
                keyNavigationWraps: false
                highlightRangeMode: ItemView.StrictlyEnforceRange
                snapMode: ListView.SnapToRow
                visible: true
                opacity: 1
                clip: true
                spacing: 0
                cacheBuffer: 20
                flickDeceleration: 1000
                maximumFlickVelocity: 1000
                boundsBehavior: Flickable.StopAtBounds
                orientation: ListView.Vertical
                flickableDirection: Flickable.AutoFlickDirection
                contentHeight: 65
                delegate: Item {
                    id: item1
                    width: menuList.width
                    height: 65
                    Rectangle {
                        id: meny1
                        x: 0
                        y: 0
                        width: 140
                        height: 65
                        radius: 1
                        Text {
                            width: 87
                            height: 30
                            text: name
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
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
            y: 260
            height: 140
            anchors.topMargin: 258
            anchors.fill: parent

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
