import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

Rectangle {
    id: baseWindow
    width: 1400
    height: 800

    property int bassVal:   bass.curValue-12
    property int midVal:    midrange.curValue-12
    property int trebleVal: treble.curValue-12
    property int gainVal: volume.curValue-99

    Item {
        id: containerTop
        x: 0
        y: 0
        width: parent.width
        height: 100

        Text {
            id: applicationName
            x: 6
            y: 6
            text: qsTr("HandyEQ")
            font.bold: true
            font.pointSize: 61
            font.family: "Courier"
        }

        Item {
            id: systemoverview
            x: 400
            y: 0
            width: 1000
            height: 100

            Rectangle {
                id: menuequalizer
                x: 50
                y: 10
                width: 150
                height: 80
                color: "#ffffff"
                radius: 1
                border.width: 2
                border.color: "#000000"

                Text {
                    id: equalizertext
                    x: 0
                    y: 0
                    width: 150
                    height: 80
                    text: qsTr("Equalizer")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 28
                }
            }


            Rectangle {
                id: menuvolume
                x: 300
                y: 10
                width: 150
                height: 80
                color: "#ffffff"
                radius: 1
                border.width: 2

                Text {
                    id: volumetext
                    x: 0
                    y: 0
                    width: 150
                    height: 80
                    text: qsTr("Volume ")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 28
                }
            }


            Rectangle {
                id: menueffect1
                x: 550
                y: 10
                width: 150
                height: 80
                color: "#ffffff"
                radius: 1
                border.width: 2

                ExclusiveGroup{
                    id: menu1
                }


                RadioButton {
                    id: menuDelay1
                    exclusiveGroup: menu1
                    x: 20
                    y: 5
                    text: qsTr("Delay")
                    onClicked: {
                        effect1rec.state = "delay"
                    }
                }

                RadioButton {
                    id: menuchorus1
                    exclusiveGroup: menu1
                    x: 20
                    y: 30
                    text: qsTr("Chorus")
                    onClicked: {
                        effect1rec.state = "chorus"
                    }
                }

                RadioButton {
                    id: menuBase1
                    exclusiveGroup: menu1
                    x: 20
                    y: 55
                    text: qsTr("No effect")
                    onClicked: {
                        effect1rec.state = "base"
                    }
                }
            }


            Rectangle {
                id: menueffect2
                x: 800
                y: 10
                width: 150
                height: 80
                color: "#ffffff"
                radius: 1
                border.width: 2

                ExclusiveGroup{
                    id: menu2
                }

                RadioButton {
                    id: menudelay2
                    exclusiveGroup: menu2
                    x: 20
                    y: 5
                    text: qsTr("Delay")
                    onClicked: {
                        effect2rec.state = "delay"
                    }
                }

                RadioButton {
                    id: menuchorus2
                    exclusiveGroup: menu2
                    x: 20
                    y: 30
                    text: qsTr("Chorus")
                    onClicked: {
                        effect2rec.state = "chorus"
                    }
                }

                RadioButton {
                    id: menuBase2
                    exclusiveGroup: menu2
                    x: 20
                    y: 55
                    text: qsTr("No effect")
                    onClicked: {
                        effect2rec.state = "base"
                    }
                }
            }
        }
    }

    Item {
        id: containerRight
        x: 1260
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
        x: 0
        y: containerTop.height
        width: 1260
        height: parent.height-containerTop.height

        Rectangle {
            id: eqrec
            x: 0
            y: 0
            width: 1060
            height: 350
            color: "#ffffff"
            radius: 1
            border.width: 1

            GenericSlider{
                id: bass
                x: 25
                y: 60
                text1: "Bass"
            }


            GenericSlider{
                id: midrange
                x: 150
                y: 60
                text1: "Midrange"
            }

            GenericSlider{
                id: treble
                x: 275
                y: 60
                text1: "Treble"
            }

            Image {
                id: filterimg
                x: 400
                y: 20
                width: 600
                height: 300
                source: "qrc:/qtquickplugin/images/template_image.png"
            }
        }

        Rectangle {
            id: effect1rec
            x: 0
            y: 350
            width: 630
            height: 350
            color: "#ffffff"
            radius: 1
            border.width: 1
            state: "base"

            Text {
                id: e1content
                x: 310
                y: 121
                width: 209
                height: 113
                text: "No effect"
                font.pixelSize: 12
            }

            states: [
                State {
                    name: "base"
                    PropertyChanges {
                        target: e1content; text: "No effect"
                    }

                },
                State {
                    name: "delay"
                    PropertyChanges {
                        target: e1content; text: "Delay"
                    }
                },
                State {
                    name: "chorus"
                    PropertyChanges {
                        target: e1content; text: "Chorus"
                    }
                }

            ]
        }

        Rectangle {
            id: effect2rec
            x: 630
            y: 350
            width: 630
            height: 350
            color: "#ffffff"
            radius: 1
            border.width: 1

            Text {
                id: text1
                x: 217
                y: 201
                text: bassVal + " " + midVal + " " + trebleVal + " " + gainVal
                font.pixelSize: 24
            }

            Text {
                id: e2content
                x: 217
                y: 35
                width: 209
                height: 113
                text: "No effect"
                font.pixelSize: 12
            }

            states: [
                State {
                    name: "base"
                    PropertyChanges {
                        target: e2content; text: "No effect"
                    }

                },
                State {
                    name: "delay"
                    PropertyChanges {
                        target: e2content; text: "Delay"
                    }
                },
                State {
                    name: "chorus"
                    PropertyChanges {
                        target: e2content; text: "Chorus"
                    }
                }

            ]

        }

        Rectangle {
            id: volumerec
            x: 1060
            y: 0
            width: 200
            height: 350
            color: "#ffffff"
            radius: 1
            border.width: 1

            GenericGainSlider{
                id: volume
                x: 40
                y: 60
                text1: "Volume"
            }
        }

    }

    /*Slider {
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

    }*/

    /*ToolButton {
        id: toolButton1
        x: 321
        y: 186
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
    ]*/

}
