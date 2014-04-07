import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

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
        id: containerLeft
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
                        onClicked:{baseWindow.state = "baseState"}
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
                        onClicked : {
                            baseWindow.state = "Delay"
                            presetModel.clear()
                            var data = fileH.read()
                            presetModel.append(data)
                            console.log("QML data content\n"+data)
                        }
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
        id: containerRight
        x: parent.width-containerLeft.width
        y: containerTop.height
        width: 140
        height: parent.height-containerTop.height
        Column {
            anchors.fill: parent
            ListView {
                id: presetList
                x: parent.x
                y: parent.y
                width: 140
                height: containerLeft.height-50
                opacity: 0
                highlightFollowsCurrentItem: true
                model: ListModel {
                    id: presetModel          
                }
                delegate: Rectangle {
                    height: 40
                    width: 140
                    Text {
                        anchors.fill: parent
                        text: name +" "+delay
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var delay = presetModel.get(index).delay
                            var name = presetModel.get(index).name
                            console.log("Index: "+index)
                            console.log("Preset: "+name+" ,Val:"+delay)
                            console.log("List Size: "+presetList.count+"\n")
                            delayLabel.text = qsTr("Delay:" + delay + " MSEC")
                            delaySlider.value = delay
                        }
                    }
                }
            }
            Item {
                id: saveContainer
                x: parent.height-50
                y: parent.y               
                TextField {
                    id: saveField
                    x:saveContainer.x
                    y:saveContainer.y
                    width: saveContainer.width
                    height: 25
                    text: ""
                }
                Button {
                    id: saveButton
                    x:parent.x
                    y:parent.y+25
                    width: parent.width
                    height: 25
                    text: "Save"
                    onClicked: {
                        var newPreset = {"name": saveField.text,"delay": delaySlider.value.toFixed(0)}
                        presetModel.append(newPreset)
                        fileH.write(saveField.text,delaySlider.value.toFixed(0))
                        saveField.text = ""
                    }
                    FileHandeler {
                        id: fileH
                        onError: console.log("Debug"+msg)
                        source: "presets.txt"
                    }
                }
            }
        }
    }

    Item {
        id: contentContainer
        x: containerRight.width
        y: containerTop.height
        width: parent.width-containerLeft.width-containerLeft.width
        height: parent.height-containerTop.height

        Slider {
            id: delaySlider
            x: 42
            y: 249
            opacity: 0
            onValueChanged: {
                delayLabel.text = qsTr("Delay:" + delaySlider.value.toFixed(0) + " MSEC")
            }
        }

        Label {
            id: delayLabel
            x: 259
            y: 91
            text: qsTr("Delay:" + delaySlider.value.toFixed(0) + " MSEC")
            opacity: 0

        }

        ListView {
            id: listView1
            x: 70
            y: 43
            width: 110
            height: 160
            delegate: Rectangle {
                width: 40
                height: 40
                MouseArea{
                    width: parent.width
                    height: parent.height
                    x: 0
                    y: 0
                    onClicked: {
                        serial.setPortS(serialModel.get(index).name)
                    }
                }

                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
            }
            model: ListModel {
                id:serialModel
            }
        }
        SerialCom{
            id:serial
            onError: console.log("Debug"+msg)

        }

        Button {
            id: button1
            x: 223
            y: 51
            text: qsTr("Button")
            onClicked: {
                serialModel.clear()
                var array = serial.getPortList();
                serialModel.append(array)

            }
        }

        Button {
            id: send
            x: 399
            y: 112
            text: qsTr("Send")
            onClicked: {
                serial.sendData(textSend.text)
            }
        }

        Button {
            id: read
            x: 399
            y: 180
            text: qsTr("Read")
            onClicked: {
                textRead.text = serial.readData()
            }
        }

        TextInput {
            id: textSend
            x: 305
            y: 113
            width: 80
            height: 20
            text: qsTr("Send Input")
            font.pixelSize: 12
        }

        Text {
            id: textRead
            x: 248
            y: 242
            text: qsTr("Output")
            font.pixelSize: 12
        }

        Button {
            id: open
            x: 399
            y: 342
            text: qsTr("Open")
            onClicked: {
                //Exits Qt.
                //Qt.quit()
                serial.openPort()
            }
        }

        Button {
            id: close
            x: 318
            y: 342
            text: qsTr("Close")
            onClicked: {
                serial.closePort()
            }
        }
    }

    states: [
        State {
            name: "Delay"

            PropertyChanges {
                target: delaySlider
                x: 42
                y: 209
                width: 436
                height: 22
                maximumValue: 99
                opacity: 1
            }

            PropertyChanges {
                target: saveField
                x: 0
                y: 0
                opacity: 1
            }

            PropertyChanges {
                target: saveButton
                x: 0
                y: 25
                anchors.bottomMargin: -446
                opacity: 1
            }

            PropertyChanges {
                target: presetList
                opacity: 1
            }

            PropertyChanges {
                target: saveContainer
                x: 0
                width: 140
                height: 50
                anchors.bottomMargin: 0
            }

            PropertyChanges {
                target: containerTop
                x: 0
                y: 0
            }

            PropertyChanges {
                target: delayLabel
                x: 233
                y: 143
                opacity: 1
            }
        },
        State {
            name: "Echo"
        },
        State {
            name: "Churus"
        }
    ]

}
