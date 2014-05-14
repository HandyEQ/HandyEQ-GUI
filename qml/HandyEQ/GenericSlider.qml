import QtQuick 2.0
import QtQuick.Controls 1.1

Item{
    //This slider is used in the Equalizer and in the Delay.
    //This variable is used to set the name of the slider from outside this qml file.
    property string text1: "value"
    //These variables are used to set the min and max value of the slider from outside this qml file.
    property int minval: 0
    property int maxval: 24
    //This variable is used to set the step size from outside this qml file.
    property int s: 3
    //These variables are used to set the size of this slider and to allow the size to
    //be changed from outside this qml file.
    property int wi: 30
    property int he: 280
    //This variable is used to be able to read the value of the slider from outside this qml file.
    property double curValue: genSlider.value-12
    //This variable is used to change the value of the slider from outside this qml file.
    property int sValue: 12

    Slider {
        //Slider for changing settings.
        id: genSlider
        width: wi
        height: he
        //Sets the step size.
        stepSize: s
        //Sets the start value.
        value: sValue
        //Sets the min and max values of the slider.
        maximumValue: maxval
        minimumValue: minval
        orientation: 0
        //When the slider value is changed it updates the curValue variable.
        onValueChanged: {
            curValue = genSlider.value-12
        }
    }
    Text {
        //Displays the name of the slider.
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
        //Displays the max value of the slider.
        x: 40
        y: 0
        width: 60
        height: 30
        text: maxval/2 +" dB"
        font.pixelSize: 12
    }
    Text {
        //Displays the 0 of the slider.
        x: 40
        y: 120
        width: 60
        height: 30
        text: qsTr("0 dB")
        font.pixelSize: 12
    }
    Text {
        //Displays the min value of the slider.
        x: 40
        y: 250
        width: 60
        height: 30
        text: -maxval/2 +" dB"
        font.pixelSize: 12
    }
    Text {
        //Displays the current value of the slider.
        x: 40
        y: 36
        width: 76
        height: 26
        text: "Current value: \n" + curValue + " dB"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }
}
