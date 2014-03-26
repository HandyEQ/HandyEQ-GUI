import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

Rectangle {
    id: baseWindow
    width: 1400
    height: 800

    property int bassVal:   e1.bass
    property int midVal:    e1.midrange
    property int trebleVal: e1.treble
    property int gainVal:   volume.curValue
    property double delay1Val:    d1.curDelay
    property double delay2Val:    d2.curDelay
    property int chorus1Val:   c1.curChorus
    property int chorus2Val:   c2.curChorus


    Item {
        id: containerTop
        x: 0
        y: 0
        z: 1
        width: parent.width
        height: 100

        Text {
            id: applicationName
            x: 6
            y: 6
            text: qsTr("HandyEQ")
            font.bold: true
            font.pointSize: 48
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
                        effect1rec.state = "Delay"
                    }
                }

                RadioButton {
                    id: menuchorus1
                    exclusiveGroup: menu1
                    x: 20
                    y: 30
                    text: qsTr("Chorus")
                    onClicked: {
                        effect1rec.state = "Chorus"
                    }
                }

                RadioButton {
                    id: menuBase1
                    exclusiveGroup: menu1
                    x: 20
                    y: 55
                    text: qsTr("No effect")
                    checked: true
                    onClicked: {
                        effect1rec.state = "No effect"
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
                        effect2rec.state = "Delay"
                    }
                }

                RadioButton {
                    id: menuchorus2
                    exclusiveGroup: menu2
                    x: 20
                    y: 30
                    text: qsTr("Chorus")
                    onClicked: {
                        effect2rec.state = "Chorus"
                    }
                }

                RadioButton {
                    id: menuBase2
                    exclusiveGroup: menu2
                    x: 20
                    y: 55
                    text: qsTr("No effect")
                    checked: true
                    onClicked: {
                        effect2rec.state = "No effect"
                    }
                }
            }
        }
    }

    Item {
        id: containerRight
        x: contentContainer.width
        y: containerTop.height
        width: baseWindow.width-contentContainer.width
        height: baseWindow.height-containerTop.height

        Column {
            id: column
            x: 0
            y: 0
            spacing: 0
            anchors.fill: parent

            ListView {
                id: presetList
                x: 0
                y: 0
                width: containerRight.width
                height: containerRight.height-250
                highlightFollowsCurrentItem: true
                model: ListModel {
                    id: presetModel
                }
                Component.onCompleted: {
                    presetModel.append(fileH.read())
                }

                delegate: Rectangle {
                    x: 5
                    height: 40
                    width: presetList.width
                    z: 0
                    Text {
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            e1.bassStart = presetModel.get(index).bass
                            e1.midrangeStart = presetModel.get(index).mid
                            e1.trebleStart = presetModel.get(index).treble
                            volume.sValue = presetModel.get(index).gain*-1
                            if(presetModel.get(index).dsp1.name == "delay"){
                                menuDelay1.checked = true
                                effect1rec.state = "Delay"
                                d1.delayStart = presetModel.get(index).dps1.delay
                            }else if(presetModel.get(index).dsp1.name == "chorus"){
                                menuchorus1.checked = true
                                effect1rec.state = "Chorus"
                                c1.delayStart = presetModel.get(index).dsp1.val1
                            }else{
                                menuBase1.checked = true
                                effect1rec.state = "NoEffect"
                            }
                            if(presetModel.get(index).dsp2.name == "delay"){
                                menuDelay2.checked = true
                                effect2rec.state = "Delay"
                            }else if(presetModel.get(index).dsp2.name == "chorus"){
                                menuchorus2.checked = true
                                effect2rec.state = "Chorus"
                            }else{
                                menuBase2.checked = true
                                effect2rec.state = "NoEffect"
                            }

                            console.log("Index: "+index)
                            console.log("Preset: "+name+" ,bass:"+bassVal+" ,mid:"+midVal+" ,treble:"+trebleVal)
                            console.log("gain:"+gainVal)
                            console.log("Effect1:"+presetModel.get(index).dsp1.name)
                            console.log("Effect2:"+presetModel.get(index).dsp2.name)

                            if(presetModel.get(index).dsp1.name == "delay"){
                                console.log("Effect1val: "+delay1Val)
                            }else if(presetModel.get(index).dsp1.name == "chorus"){
                                console.log("Effect1val: "+chorus1Val)
                            }
                            if(presetModel.get(index).dsp2.name == "delay"){
                                console.log("Effect2val: "+delay2Val)
                            }else if(presetModel.get(index).dsp2.name == "chorus"){
                                console.log("Effect2val: "+chorus2Val)
                            }

                            console.log("List Size: "+presetList.count+"\n")
                        }
                    }
                }
            }

            Item {
                id: sendContainer
                x: 10
                y: containerRight.height-100
                width: 120
                height: 40

                Button {
                    id: sendButton
                    x: 0
                    y: 0
                    width: sendContainer.width
                    height: sendContainer.height
                    text: qsTr("Send")
                    onClicked: {
                        d1.delayStart = 1.555
                    }
                }
            }

            Item {
                id: resetContainer
                x: 10
                y: containerRight.height-200
                width: 120
                height: 40
                Button {
                    id: resetButton
                    x: 0
                    y: 0
                    width: resetContainer.width
                    height: resetContainer.height
                    text: qsTr("Reset")
                    onClicked: {
                        e1.bassStart        = 3
                        e1.midrangeStart    = 3
                        e1.trebleStart      = 3
                        d1.delayStart      = 3
                        d2.delayStart      = 3
                        volume.sValue       = 3
                        e1.bassStart        = 0
                        e1.midrangeStart    = 0
                        e1.trebleStart      = 0
                        d1.delayStart      = 0
                        d2.delayStart      = 0
                        volume.sValue       = 0
                    }
                }
            }

            Item {
                id: removeContainer
                x: 10
                y: containerRight.height-150
                width: 120
                height: 40

                Button {
                    id: removeButton
                    x: 0
                    y: 0
                    width: removeContainer.width
                    height: removeContainer.height
                    text: qsTr("Remove")
                    onClicked: {
                    }
                }
            }

            Item {
                id: saveContainer
                x: 10
                y: containerRight.height-100
                width: 120
                height: 80

                Button {
                    id: saveButton
                    x: 0
                    y: 0
                    width: saveContainer.width
                    height: saveContainer.height/2
                    text: qsTr("Save")
                    onClicked: {
                        var dsp1, dsp2
                        //Dsp effect one save generation
                        if(effect1rec.state == "Delay"){
                            dsp1 = {
                                "name": "delay",
                                "delay": delay1Val
                            }
                        } else if (effect1rec.state == "Chorus"){
                            dsp1 = {
                                "name": "chorus",
                                "val1": chorus1Val
                            }
                        } else {
                            dsp1 = {
                                "name": null
                            }
                        }
                        //Dsp effect two save generation
                        if(effect2rec.state == "Delay"){
                            dsp2 = {
                                "name": "delay",
                                "delay": delay2Val
                            }
                        } else if (effect2rec.state == "Chorus"){
                            dsp2= {
                                "name": "chorus",
                                "val1": chorus2Val
                            }
                        } else {
                            dsp2 = {
                                "name": null
                            }
                        }

                        var newPreset = {
                            "name": saveField.text,
                            "gain": gainVal,
                            "bass": bassVal,
                            "mid": midVal,
                            "treble": trebleVal,
                            "dsp1": dsp1,
                            "dsp2": dsp2
                        }
                        presetModel.append(newPreset)
                        fileH.write(newPreset)
                        saveField.text = ""
                    }
                    FileHandeler {
                        id: fileH
                        onError: console.log("Debug"+msg)
                        source: "presets.txt"
                    }
                }

                TextField {
                    id: saveField
                    x: 0
                    y: saveContainer.height/2
                    width: saveContainer.width
                    height: saveContainer.height/2
                    scale: 1
                    font.pointSize: 18
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: ""
                }
            }
        }
        /*Column {
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
        }*/
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
            height: contentContainer.height/2
            color: "#ffffff"
            radius: 1
            border.width: 1

            Equalizer{
                id: e1
            }
        }

        Rectangle {
            id: effect1rec
            x: 0
            y: 350
            width: contentContainer.width/2
            height: contentContainer.height/2
            color: "#ffffff"
            radius: 1
            border.width: 1
            state: "NoEffect"

            Delay{
                id: d1
                opacity: 0

            }

            Chorus{
                id: c1
                opacity: 0
            }

            NoEffect{
                id: n1
                opacity: 1
            }

            states: [
                State {
                    name: "No effect"
                    PropertyChanges {
                        target: d1; opacity: 0
                    }
                    PropertyChanges {
                        target: c1; opacity: 0
                    }
                    PropertyChanges {
                        target: n1; opacity: 1
                    }
                    PropertyChanges {
                        target: c1; z: 0
                    }
                    PropertyChanges {
                        target: d1; z: 0
                    }
                    PropertyChanges {
                        target: n1; z: 1
                    }
                },
                State {
                    name: "Delay"
                    PropertyChanges {
                        target: d1; opacity: 1
                    }
                    PropertyChanges {
                        target: c1; opacity: 0
                    }
                    PropertyChanges {
                        target: n1; opacity: 0
                    }
                    PropertyChanges {
                        target: c1; z: 0
                    }
                    PropertyChanges {
                        target: d1; z: 1
                    }
                    PropertyChanges {
                        target: n1; z: 0
                    }
                },
                State {
                    name: "Chorus"
                    PropertyChanges {
                        target: d1; opacity: 0
                    }
                    PropertyChanges {
                        target: c1; opacity: 1
                    }
                    PropertyChanges {
                        target: n1; opacity: 0
                    }
                    PropertyChanges {
                        target: c1; z: 1
                    }
                    PropertyChanges {
                        target: d1; z: 0
                    }
                    PropertyChanges {
                        target: n1; z: 0

                    }
                }
            ]
        }

        Rectangle {
            id: effect2rec
            x: contentContainer.width/2
            y: contentContainer.height/2
            width: contentContainer.width/2
            height: contentContainer.height/2
            radius: 1
            border.width: 1
            state: "NoEffect"

            Text {
                id: text1
                x: 270
                y: 161
                width: 93
                height: 29
                text: bassVal + " " + midVal + " " + trebleVal + " " + gainVal
                font.pixelSize: 24
            }

            Text {
                id: text2
                x: 270
                y: 215
                text: delay1Val + " " + delay2Val + " " + chorus1Val + " " + chorus2Val
                font.pixelSize: 24
            }

            Delay{
                id: d2
                opacity: 0
            }

            Chorus{
                id: c2
                opacity: 0
            }

            NoEffect{
                id: n2
                opacity: 1
            }


            states: [
                State {
                    name: "No effect"
                    PropertyChanges {
                        target: d2; opacity: 0
                    }
                    PropertyChanges {
                        target: c2; opacity: 0
                    }
                    PropertyChanges {
                        target: n2; opacity: 1
                    }
                    PropertyChanges {
                        target: c2; z: 0
                    }
                    PropertyChanges {
                        target: d2; z: 0
                    }
                    PropertyChanges {
                        target: n2; z: 1
                    }

                },
                State {
                    name: "Delay"
                    PropertyChanges {
                        target: d2; opacity: 1
                    }
                    PropertyChanges {
                        target: c2; opacity: 0
                    }
                    PropertyChanges {
                        target: n2; opacity: 0
                    }
                    PropertyChanges {
                        target: c2; z: 0
                    }
                    PropertyChanges {
                        target: d2; z: 1
                    }
                    PropertyChanges {
                        target: n2; z: 0
                    }
                },
                State {
                    name: "Chorus"
                    PropertyChanges {
                        target: d2; opacity: 0
                    }
                    PropertyChanges {
                        target: c2; opacity: 1
                    }
                    PropertyChanges {
                        target: n2; opacity: 0
                    }
                    PropertyChanges {
                        target: c2; z: 1
                    }
                    PropertyChanges {
                        target: d2; z: 0
                    }
                    PropertyChanges {
                        target: n2; z: 0
                    }
                }

            ]

        }

        Rectangle {
            id: volumerec
            x: eqrec.width
            y: 0
            width: contentContainer.width-eqrec.width
            height: contentContainer.height/2
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
}
