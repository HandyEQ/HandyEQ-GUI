import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

Rectangle {
    width: 148
    height: 348

    Item {
        id: menu

        ExclusiveGroup {
            id: excmenu
        }
        RadioButton {
            id: noEff
            exclusiveGroup: excmenu
            x: 28
            y: 8
            text: qsTr("No Effect")
        }
        RadioButton {
            id: equal
            exclusiveGroup: excmenu
            x: 28
            y: 31
            text: qsTr("Equalizer")
        }
        RadioButton {
            id: volume
            exclusiveGroup: excmenu
            x: 28
            y: 54
            text: qsTr("Volume")
        }
        RadioButton {
            id: delay
            exclusiveGroup: excmenu
            x: 28
            y: 77
            text: qsTr("Delay")
        }
    }
}
