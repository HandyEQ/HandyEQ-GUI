import QtQuick 2.0
import QtQuick.Controls 1.1

Item{
    property string text1: "value"
    property string unit: "s"
    property int scale: 10
    property int minval: 0
    property int maxval: 20
    property int sValue: 0
    property int s: 1
    property int wi: 30
    property int he: 280
    property double curValue: sliderHorizontal.value/scale

    Slider {
        id: sliderHorizontal
        x: 0
        y: 79
        width: 350
        height: 30
        stepSize: 1
        value: sValue
        minimumValue: minval
        maximumValue: maxval
        onValueChanged: {
            curValue: sliderHorizontal.value/scale
        }
    }
    Text {
        x: 0
        y: 0
        width: 123
        height: 31
        text: text1
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 28
    }
    Text {
        x: 330
        y: 115
        width: 60
        height: 30
        text: maxval/scale + " " + unit
        font.pixelSize: 12
    }
    Text {
        x: 0
        y: 115
        width: 60
        height: 30
        text: "0 " + unit
        font.pixelSize: 12
    }
    Text {
        x: 180
        y: 0
        width: 76
        height: 26
        text: qsTr("Current value:")
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }
    Text {
        x: 205
        y: 32
        width: 26
        height: 26
        text: curValue + " s"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }
}
