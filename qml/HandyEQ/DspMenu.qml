import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

Rectangle {
    //This is no longer being used since the radio buttons were not easy enought to set remotely.
    //This was instead moved into the main qml file.
    width: 148
    height: 348
    //Used to keep track of the states from outside this qml file.
    property string stateStart: "noEffect"
    property string curState: "noEffect"

    Item {
        id: menu

        ExclusiveGroup {
            //Creates an exclusive group so that only one of the radio buttons can be ckecked at a time.
            id: excmenu
        }
        //These radio buttons were to set the state of the effect rectangle that this have been declared in.
        RadioButton {
            id: noEff
            exclusiveGroup: excmenu
            x: 28
            y: 8
            text: qsTr("No Effect")
            checked: {if(stateStart == "noEffect")true; else false}
            onClicked: {
                curState = "noEffect"
            }
        }
        RadioButton {
            id: equal
            exclusiveGroup: excmenu
            x: 28
            y: 31
            text: qsTr("Equalizer")
            checked: {if(stateStart == "equalizer")true; else false}
            onClicked: {
                curState = "equalizer"
            }
        }
        RadioButton {
            id: volume
            exclusiveGroup: excmenu
            x: 28
            y: 54
            text: qsTr("Volume")
            checked: {if(stateStart == "volume")true; else false}
            onClicked: {
                curState = "volume"
            }
        }
        RadioButton {
            id: delay
            exclusiveGroup: excmenu
            x: 28
            y: 77
            text: qsTr("Delay")
            checked: {if(stateStart == "delay")true; else false}
            onClicked: {
                curState = "delay"
            }
        }
    }
}
