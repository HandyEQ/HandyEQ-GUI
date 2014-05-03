import QtQuick 2.2
 import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

Rectangle {
    id: baseWindow
    width: 1400
    height: 800
    state: "start"

    property int bassVal:   e1.bass
    property int midVal:    e1.midrange
    property int trebleVal: e1.treble
    property int gainVal:   volume.curValue
    property double delay1Val:    d1.curDelay
    property double delay2Val:    d2.curDelay
    property double chorus1Val:   c1.curChorus
    property double chorus2Val:   c2.curChorus

    property int tempVal: 0

    //These values are not done yet.
    //Values used to store the current first effects and its values.
    property string dsp1name: {if(effect1rec.state == "Delay")"delay";else "";if(effect1rec.state == "Chorus")"chorus"}
    property int dsp1val1: {if(effect1rec.state == "Delay")delay1Val*1000;else 0;if(effect1rec.state == "Chorus")chorus1Val}
    property int dsp1val2: {if(effect1rec.state == "Delay")delay1Val*1000;else 0;if(effect1rec.state == "Chorus")chorus1Val}
    property int dsp1val3: {if(effect1rec.state == "Delay")delay1Val*1000;else 0;if(effect1rec.state == "Chorus")chorus1Val}

    //Values used to store the current second effects and its values.
    property string dsp2name: {if(effect2rec.state == "Delay")"delay";else "";if(effect2rec.state == "Chorus")"chorus"}
    property int dsp2val1: {if(effect2rec.state == "Delay")delay2Val*1000;else 0;if(effect2rec.state == "Chorus")chorus2Val;}
    property int dsp2val2: {if(effect2rec.state == "Delay")delay1Val*1000;else 0;if(effect2rec.state == "Chorus")chorus1Val}
    property int dsp2val3: {if(effect2rec.state == "Delay")delay1Val*1000;else 0;if(effect2rec.state == "Chorus")chorus1Val}

    //Values used to store the current third effects and its values.
    property string dsp3name: {if(effect3rec.state == "Delay")"delay";else "";if(effect3rec.state == "Chorus")"chorus"}
    property int dsp3val1: {if(effect3rec.state == "Delay")delay1Val*1000;else 0;if(effect3rec.state == "Chorus")chorus1Val}
    property int dsp3val2: {if(effect3rec.state == "Delay")delay1Val*1000;else 0;if(effect3rec.state == "Chorus")chorus1Val}
    property int dsp3val3: {if(effect3rec.state == "Delay")delay1Val*1000;else 0;if(effect3rec.state == "Chorus")chorus1Val}

    //Values used to store the current forth effects and its values.
    property string dsp4name: {if(effect4rec.state == "Delay")"delay";else "";if(effect4rec.state == "Chorus")"chorus"}
    property int dsp4val1: {if(effect4rec.state == "Delay")delay2Val*1000;else 0;if(effect4rec.state == "Chorus")chorus2Val;}
    property int dsp4val2: {if(effect4rec.state == "Delay")delay1Val*1000;else 0;if(effect4rec.state == "Chorus")chorus1Val}
    property int dsp4val3: {if(effect4rec.state == "Delay")delay1Val*1000;else 0;if(effect4rec.state == "Chorus")chorus1Val}

    property string inText: ""

    SerialCom{
        id: serialC
        objectName: "serialC"
        onInDataStringnChanged: {
            inText = inText + serialC.inDataStringn
        }
        onInDatanChanged: {
            serialR.clear()
            serialR.append(serialC.inDatan)
            inText = inText + "New Json data read." + '\n'
            if(serialR.get(0).dsp1name == "Eq"){
                inText = inText + serialR.get(0).bass + '\n'
                e1.bassStart = serialR.get(0).bass
            }
        }
    }
    //With the new serialCom using signals the timer should not be needed.
    /*Timern {
        onTriggered:{
            serialR.append(serialC.inDatan)
        }
    }*/
    ListModel{
        //This will be used to store the data read from the serial port.
        id: serialR
    }
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
        MouseArea{
            x: 0
            y: 0
            z: 1
            opacity: 1
            width: 400
            height: 100

            onClicked: {
                baseWindow.state = "debug"
            }
        }
        Text {
            id: text1
            x: 300
            y: 0
            width: 93
            height: 29
            //text: bassVal + " " + midVal + " " + trebleVal + " " + gainVal
            text: dsp1name + ": " + dsp1val1
            font.pixelSize: 24
        }
        Text {
            id: text2
            x: 300
            y: 50
            width: 200
            //text: delay1Val + " " + delay2Val + " " + chorus1Val + " " + chorus2Val
            text: dsp2name + ": " + dsp2val1
            font.pixelSize: 24
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
                height: containerRight.height-500
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
                            if(removeBox.checked){
                                fileH.remove(index)
                                presetModel.remove(index)
                            }else{
                            e1.bassStart = presetModel.get(index).bass
                            e1.midrangeStart = presetModel.get(index).mid
                            e1.trebleStart = presetModel.get(index).treble
                            volume.sValue = presetModel.get(index).gain*-1

                            if(presetModel.get(index).dsp1name == "delay"){
                                baseWindow.tempVal = presetModel.get(index).dsp1val1
                                menuDelay1.checked = true
                                effect1rec.state = "Delay"
                                d1.delayStart = tempVal / 1000
                            }else if(presetModel.get(index).dsp1name == "chorus"){
                                menuchorus1.checked = true
                                effect1rec.state = "Chorus"
                            }else{
                                menuBase1.checked = true
                                effect1rec.state = "NoEffect"
                            }
                            if(presetModel.get(index).dsp2name == "delay"){
                                baseWindow.tempVal = presetModel.get(index).dsp2val1
                                menudelay2.checked = true
                                effect2rec.state = "Delay"                                
                                d2.delayStart = tempVal / 1000
                            }else if(presetModel.get(index).dsp2name == "chorus"){
                                menuchorus2.checked = true
                                effect2rec.state = "Chorus"
                            }else{
                                menuBase2.checked = true
                                effect2rec.state = "NoEffect"
                            }

                            console.log("Index: "+index)
                            console.log("Preset: "+name+" ,bass:"+bassVal+" ,mid:"+midVal+" ,treble:"+trebleVal)
                            console.log("gain:"+gainVal)
                            console.log("Effect1:"+presetModel.get(index).dsp1name)
                            console.log("Effect2:"+presetModel.get(index).dsp2name)

                            if(presetModel.get(index).dsp1name == "delay"){
                                    console.log("Effect1val: "+delay1Val)
                            }else if(presetModel.get(index).dsp1name == "chorus"){
                                    console.log("Effect1val: "+chorus1Val)
                                }
                            if(presetModel.get(index).dsp2name == "delay"){
                                    console.log("Effect2val: "+delay2Val)
                            }else if(presetModel.get(index).dsp2name == "chorus"){
                                    console.log("Effect2val: "+chorus2Val)
                                }

                            console.log("List Size: "+presetList.count+"\n")
                            }
                            }
                    }
                }
            }
        }
        Item {
                id: removeContainer
                x: 10
                y: containerRight.height-400
                width: 120
                height: 40

                CheckBox {
                    id: removeBox
                    x: 5
                    y: 10
                    text: qsTr("Remove preset")
                }
            }
        Item {
                id: serialContainer
                x: 10
                y: containerRight.height-350
                width: 120
                height: 200
                state: "setPortList"

                Item {
                    id: setPort
                    anchors.fill: serialContainer
                    opacity: 1
                    z: 1

                    Text {
                        id: serialText
                        text: qsTr("Available ports:")
                    }
                    Column{
                        id: portColumn
                        x: 0
                        y: serialText.height
                        spacing: 0
                        width: setPort.width
                        height: setPort.height-serialText.height-serialContainer.height

                        ListView{
                            id: portList
                            x: 0
                            y: 0
                            width: setPort.width
                            height: setPort.height-serialText.height-50
                            highlightFollowsCurrentItem: true
                            model: ListModel{
                                id: portlistmodel
                            }
                            Component.onCompleted: {
                                portlistmodel.append(serialC.getPortList())
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
                                        serialC.setPortS(name)
                                        serialContainer.state = "serialCom"
                                    }
                                }
                            }
                        }
                    }
                    Button {
                        id: renewPorts
                        x: 0
                        y: setPort.height-50
                        width: setPort.width
                        height: 40

                        text: qsTr("Get ports")
                        onClicked: {
                            portlistmodel.clear()
                            portlistmodel.append(serialC.getPortList())
                            //serialContainer.state = "serialCom"
                        }
                    }
                }
                Item{
                    id: serialCom
                    anchors.fill: serialContainer
                    opacity: 0
                    z: 0
                    state: "closed"
                    Button {
                        id: open
                        x: 0
                        y: 0
                        z: 1
                        opacity: 1
                        width: serialCom.width
                        height: 40
                        text: qsTr("Open port")
                        onClicked: {
                            serialCom.state = "open"
                            serialC.openPort()
                        }
                    }
                    Button {
                        id: close
                        x: 0
                        y: 0
                        z: 0
                        opacity: 0
                        width: serialCom.width
                        height: 40
                        text: qsTr("Close port")
                        onClicked: {
                            serialCom.state = "closed"
                            serialC.closePort()
                        }
                    }
                    Button {
                        id: sendSerialButton
                        x: 0
                        y: 50
                        z: 0
                        opacity: 0
                        width: serialCom.width
                        height: 40
                        text: qsTr("Send to board")
                        onClicked: {
                           var newPreset = {
                                "name": saveField.text,
                                "gain": gainVal,
                                "bass": bassVal,
                                "mid": midVal,
                                "treble": trebleVal,
                            }
                            serialC.sendData(newPreset)
                        }
                    }
                    Button {
                        id: changePortButton
                        x: 0
                        y: 50
                        z: 1
                        opacity: 1
                        width: serialCom.width
                        height: 40
                        text: qsTr("Change port")
                        onClicked: {
                            serialContainer.state = "setPortList"
                        }
                    }

                    states: [
                        State {
                            name: "open"
                            PropertyChanges {
                                target: open; opacity: 0
                            }
                            PropertyChanges {
                                target: open; z: 0
                            }
                            PropertyChanges {
                                target: close; opacity: 1
                            }
                            PropertyChanges {
                                target: close; z: 1
                            }
                            PropertyChanges {
                                target: sendSerialButton; opacity: 1
                            }
                            PropertyChanges {
                                target: sendSerialButton; z: 1
                            }
                            PropertyChanges {
                                target: changePortButton; opacity: 0
                            }
                            PropertyChanges {
                                target: changePortButton; z: 0
                            }
                        },
                        State {
                            name: "closed"
                            PropertyChanges {
                                target: open; opacity: 1
                            }
                            PropertyChanges {
                                target: open; z: 1
                            }
                            PropertyChanges {
                                target: close; opacity: 0
                            }
                            PropertyChanges {
                                target: close; z: 0
                            }
                            PropertyChanges {
                                target: sendSerialButton; opacity: 0
                            }
                            PropertyChanges {
                                target: sendSerialButton; z: 0
                            }
                            PropertyChanges {
                                target: changePortButton; opacity: 1
                            }
                            PropertyChanges {
                                target: changePortButton; z: 1
                            }
                        }

                    ]
                }

                states: [
                    State {
                        name: "setPortList"
                        PropertyChanges {
                            target: setPort; opacity: 1
                        }
                        PropertyChanges {
                            target: setPort; z: 1
                        }
                        PropertyChanges {
                            target: serialCom; z: 0
                        }
                        PropertyChanges {
                            target: serialCom; opacity: 0
                        }
                    },
                    State {
                        name: "serialCom"
                        PropertyChanges {
                            target: setPort; opacity: 0
                        }
                        PropertyChanges {
                            target: setPort; z: 0
                        }
                        PropertyChanges {
                            target: serialCom; z: 1
                        }
                        PropertyChanges {
                            target: serialCom; opacity: 1
                        }
                    }
                ]
            }
        Item {
                id: resetContainer
                x: 10
                y: containerRight.height-150
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
                        //Creates a new preset that is to be saved as an Json object.
                        var newPreset = {
                            "name": saveField.text,
                            "gain": gainVal,
                            "bass": bassVal,
                            "mid": midVal,
                            "treble": trebleVal,
                            "dsp1name": dsp1name,
                            "dsp1val1": dsp1val1,
                            "dsp2name": dsp2name,
                            "dsp2val1": dsp2val1
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
                    y: (saveContainer.height/2)+10
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
            width: contentContainer.width/2
            height: contentContainer.height/2
            color: "#ffffff"
            radius: 1
            border.width: 1

            Equalizer{
                id: e1
            }

            Item {
                id: dsp1menu
                x: 480
                y: 0
                width: contentContainer.width/2 - 480
                height: contentContainer.height/2

                DspMenu{
                    id: dsp1m
                    x: 1
                    y: 1
                }
            }
        }
        Rectangle {
            id: volumerec
            x: eqrec.width
            y: 0
            width: contentContainer.width/2
            height: contentContainer.height/2
            radius: 1
            border.width: 1

            GenericGainSlider{
                id: volume
                x: 40
                y: 60
                text1: "Volume"
            }
            Item {
                id: dsp2menu
                x: 480
                y: 0
                width: contentContainer.width/2 - 480
                height: contentContainer.height/2

                DspMenu{
                    id: dsp2m
                    x: 1
                    y: 1
                }
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
            Item {
                id: dsp3menu
                x: 480
                y: 0
                width: contentContainer.width/2 - 480
                height: contentContainer.height/2

                DspMenu{
                    id: dsp3m
                    x: 1
                    y: 1
                }
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
            Item {
                id: dsp4men
                x: 480
                y: 0
                width: contentContainer.width/2 - 480
                height: contentContainer.height/2

                DspMenu{
                    id: dsp4m
                    x: 1
                    y: 1
                }
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
    }
    Item {
        id: deBug
        x: 0
        y: containerTop.height
        z: 0
        opacity: 0
        width: 1400
        height: 700

        Rectangle {
            id: inputRec
            x: 700
            y: 0
            width: 700
            height: 700
            border.width: 1

            Text {
                id: inputText
                x: 10
                y: 10
                width: 100
                height: 40

                text: qsTr("Input text:")
                font.pixelSize: 20
            }
            Rectangle {
                id: intextRec
                x: 10
                y: 50
                width: 300
                height: 40
                border.width: 1

                TextInput {
                    id: textInput
                    anchors.fill: parent
                    z: 1
                    opacity: 1
                    text: "..."
                    font.pixelSize: 20
                }
            }
            Button {
                id: sendInput
                x: 311
                y: 50
                width: 100
                height: 40
                text: qsTr("Send")
                onClicked: {
                    inText += "GUI: " + textInput.text + "\n"
                }
            }
            Button {
                id: returnToGui
                x: 560
                y: 640
                width: 100
                height: 40
                z: 1
                opacity: 1
                text: qsTr("Return to GUI")
                onClicked: {
                    baseWindow.state = "gui"
                }
            }
            Button {
                id: clearLog
                x: 20
                y: 640
                width: 100
                height: 40
                z: 1
                opacity: 1
                text: qsTr("Clear")
                onClicked: {
                    inText = ""
                }
            }
        }
        Rectangle{
            id: debugRec
            x: 0
            y: 0
            width: 700
            height: 700
            border.width: 1

            Text {
                id: debugInput
                x: 10
                y: 10
                width: 680
                height: 680
                text: inText
                font.pixelSize: 20
            }
        }
    }
    Item {
        id: startContainer
        x: 0
        y: 0
        z: 1
        width: baseWindow.width
        height: baseWindow.height
        opacity: 0

        MouseArea {
            x: 400
            y: 0
            z: 1
            width: 1000
            height: 100
        }

        Item {
            id: setPortS
            x: 400
            y: 400
            opacity: 1
            z: 1

            Text {
                id: serialTextS
                text: qsTr("Available ports:")
            }
            Column{
                id: portColumnS
                x: 0
                y: serialText.height
                spacing: 0
                width: setPort.width
                height: setPort.height-serialText.height-serialContainer.height

                ListView{
                    id: portListS
                    x: 0
                    y: 0
                    width: setPort.width
                    height: setPort.height-serialText.height-50
                    highlightFollowsCurrentItem: true
                    model: ListModel{
                        id: portlistmodelS
                    }
                    Component.onCompleted: {
                        portlistmodelS.append(serialC.getPortList())
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
                                serialC.setPortS(name)
                                serialContainer.state = "serialCom"
                                baseWindow.state = "gui"
                            }
                        }
                    }
                }
            }
            Button {
                id: renewPortS
                x: 0
                y: setPort.height-50
                width: setPort.width
                height: 40

                text: qsTr("Get ports")
                onClicked: {
                    portlistmodelS.clear()
                    portlistmodelS.append(serialC.getPortList())
                    //serialContainer.state = "serialCom"
                }
            }
        }
    }
    states: [
        State {
            name: "gui"
            PropertyChanges {
                target: contentContainer; z: 1
            }
            PropertyChanges {
                target: contentContainer; opacity: 1
            }
            PropertyChanges {
                target: containerRight; z: 1
            }
            PropertyChanges {
                target: containerRight; opacity: 1
            }
            PropertyChanges {
                target: deBug; z: 0
            }
            PropertyChanges {
                target: deBug; opacity: 0
            }
            PropertyChanges {
                target: startContainer; z: 0
            }
            PropertyChanges {
                target: startContainer; opacity: 0

            }
        },
        State {
            name: "debug"
            PropertyChanges {
                target: contentContainer; z: 0
            }
            PropertyChanges {
                target: contentContainer; opacity: 0
            }
            PropertyChanges {
                target: containerRight; z: 0
            }
            PropertyChanges {
                target: containerRight; opacity: 0
            }
            PropertyChanges {
                target: deBug; z: 1
            }
            PropertyChanges {
                target: deBug; opacity: 1
            }
            PropertyChanges {
                target: startContainer; z: 0
            }
            PropertyChanges {
                target: startContainer; opacity: 0

            }

            PropertyChanges {
                target: debugInput
                wrapMode: "WrapAtWordBoundaryOrAnywhere"
            }
        },
        State {
            name: "start"
            PropertyChanges {
                target: contentContainer; z: 0
            }
            PropertyChanges {
                target: contentContainer; opacity: 0
            }
            PropertyChanges {
                target: containerRight; z: 0
            }
            PropertyChanges {
                target: containerRight; opacity: 0
            }
            PropertyChanges {
                target: deBug; z: 0
            }
            PropertyChanges {
                target: deBug; opacity: 0
            }
            PropertyChanges {
                target: containerTop; z: 0
            }
            PropertyChanges {
                target: containerTop; opacity: 0.5
            }
            PropertyChanges {
                target: startContainer; z: 1
            }
            PropertyChanges {
                target: startContainer; opacity: 1
            }
        }
    ]
}
