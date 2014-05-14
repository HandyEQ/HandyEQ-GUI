import QtQuick 2.0
import QtQuick.Controls 1.1

Item{
    //This slider is used in the delay effect.------------------This probably will not be used later.
    //This value is used to set the displayed name of the slider.
    property string text1: "value"
    //This variable is used to set the unit used by the slider.
    property string unit: "s"
    //This variable is used to scale the values to fit the slider values or to display the correct value.
    property int scaleVal: 10
    //These variables are used to set the min value and the max value.
    property int minval: 0
    property int maxval: 20
    //This variable is used to change the slider setting.
    property int sValue: 0
    //This variable is no longer being used.
    property int s: 1
    //These variables are used when the window size is to be changed.
    property int wi: 30
    property int he: 280
    //This is used to read the value of the slider from outside the qml file.
    property double curValue: sliderHorizontal.value/scaleVal
    //This variable is used to rotate the text boxes.
    property int rot: 0

    Slider {
        //Slider for chaning settings.
        id: sliderHorizontal
        x: 0
        y: 79
        width: 300
        height: 30
        //Sets the size of the steps of the slider.
        stepSize: 1
        //Sets the value of the slider.
        value: sValue
        //Sets the max and min values of the slider.
        minimumValue: minval
        maximumValue: maxval
        //When the value change on the slider curValue is changed.
        onValueChanged: {
            curValue: sliderHorizontal.value/scale
        }
    }
    Text {
        //Displays the name of the slider
        x: 0
        y: 0
        width: 123
        height: 31
        text: text1
        //Used when rotating the text box.
        rotation: rot
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignLeft
        font.pixelSize: 28
    }
    Text {
        //Displays the max value of the slider.
        x: 281
        y: 115
        width: 60
        height: 30
        //Used when rotating the text box.
        rotation: rot
        text: (maxval / scaleVal) + " " + unit
        font.pixelSize: 12
    }
    Text {
        //Displays the lowest value of the slider.
        x: 0
        y: 115
        width: 60
        height: 30
        //Used when rotating the text box.
        rotation: rot
        text: "0 " + unit
        font.pixelSize: 12
    }
    Text {
        //Dispalys the current value of the slider, scaled to its correct value and unit.
        x: 180
        y: 0
        width: 76
        height: 26
        //Used when rotating the text box.
        rotation: rot
        text: "Current value: " + curValue + " " + unit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 12
    }
}
