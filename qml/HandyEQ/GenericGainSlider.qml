import QtQuick 2.0
import QtQuick.Controls 1.1

Item{
    //This slider is to be used to decide gain.
    //text1 is used to set the lable of the slider from outside this qml file.
    property string text1: "value"
    //This variable is used to be able to read the value of the slider from outside this qml file.
    property int curValue: 0-gainSlide.value
    //This value is used to change the setting(slider) of the gain.
    property int sValue: 0

    Slider {
        //Slider for displaying and changing the gain.
        id: gainSlide
        width: 30
        height: 280
        //Rotates the slider to be vertical.
        rotation: 180
        stepSize: 3
        //Sets the max value to 99.
        maximumValue: 99
        //Sets the min value to 0.
        minimumValue: 0
        //Sets the start value.
        value: sValue
        orientation: 0
        //When the slider is moved the curValue is updated.
        onValueChanged: {
            curValue = -gainSlide.value
        }
    }
    Text {
        x: -46
        y: -44
        width: 123
        height: 31
        //Displays the effect name.
        text: qsTr(text1)
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 28
    }
    Text {
        //This is used to display where the 0 dB is situated on the slider.
        x: 40
        y: 0
        width: 60
        height: 30
        text: qsTr("0 dB")
        font.pixelSize: 12
    }
    Text {
        //This is used to display where the 99 dB is situated on the slider.
        x: 40
        y: 250
        width: 60
        height: 30
        text:  qsTr("-99 dB")
        font.pixelSize: 12
    }
    Text {
        //This is used to display current value.
        x: 40
        y: 36
        height: 26
        text: qsTr("Current value:")
        font.pixelSize: 12
    }
    Text {
        //This is used to display current value.
        x: 65
        y: 68
        height: 26
        text: curValue + " dB"
        font.pixelSize: 12
    }
}

