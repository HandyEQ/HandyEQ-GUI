import QtQuick 2.0
import QtQuick.Controls 1.1

Item{
    property string text1: "value"
    property int minval: 0
    property int maxval: 24
    property int s: 3
    property int wi: 30
    property int he: 280
    property int curValue: genSlider.value-12
    property int sValue: 12

    Slider {
        id: genSlider
        width: wi
        height: he
        stepSize: s
        value: sValue
        maximumValue: maxval
        minimumValue: minval
        orientation: 0
        onValueChanged: {
            curValue = genSlider.value-12
        }

    }
    Text {
        x: -46
        y: -44
        width: 123
        height: 31
        text: text1
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 28
    }

    Text {
        x: 40
        y: 0
        width: 60
        height: 30
        text: maxval/2 +" dB"
        font.pixelSize: 12
    }

    Text {
        x: 40
        y: 120
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
        text: -maxval/2 +" dB"
        font.pixelSize: 12
    }

    Text {
        x: 40
        y: 36
        width: 76
        height: 26
        text: qsTr("Current value:")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

    Text {
        x: 65
        y: 68
        width: 26
        height: 26
        text: curValue + " dB"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }

}
