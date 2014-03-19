import QtQuick 2.0
import QtQuick.Controls 1.1

Item{
    property string text1: "value"
    property int curValue: gainSlide.value

    Slider {
        id: gainSlide
        width: 30
        height: 280
        stepSize: 3
        maximumValue: 99
        minimumValue: 0
        orientation: 0
        onValueChanged: {
            curValue = gainSlide.value
        }
    }

    Text {
        x: -46
        y: -44
        width: 123
        height: 31
        text: qsTr(text1)
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 28
    }

    Text {
        x: 40
        y: 0
        width: 60
        height: 30
        text: qsTr("0 dB")
        font.pixelSize: 12
    }

    Text {
        x: 40
        y: 250
        width: 60
        height: 30
        text:  qsTr("-99 dB")
        font.pixelSize: 12
    }

    Text {
        x: 40
        y: 36
        height: 26
        text: qsTr("Current value:")
        font.pixelSize: 12
    }

    Text {
        x: 65
        y: 68
        height: 26
        text: curValue-99 + " dB"
        font.pixelSize: 12
    }

}

