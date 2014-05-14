import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

Item{
    //This is where the settings for the delay effect/effects will be configuered.
    width: 480
    height: 350
    opacity: 1
    //Remodel, all sliders vertical, feedback should have from 0-1 values without a unit, remove the unit for the gain.
    //These variables are used when reading the current values from the sliders, these values are updated when the
    //values are changed on the slider connected to the variable.
    property double curDelay: tempDelay/10
    //Used to get rid of unwanted values that occur when dividing ints.
    property int tempDelay: secSlider.value
    property double curGain: tempGain/100
    //Used to get rid of unwanted values that occur when dividing ints.
    property int tempGain: gainSlider.value
    property double curFeedback: tempFeedback/100
    //Used to get rid of unwanted values that occur when dividing ints.
    property int tempFeedback: feedbackSlider.value
    //These variables are used when changing the values of the delay settings(sliders).
    property double delayStart: 0
    property double gainStart: 0
    property double feedbackStart: 0
    //This is used to scale down the start value to fit the delay slider.
    property int delayStartS: delayStart*10

    Item {
        //Slider for the delay setting.
        id: seconds
        x: 30
        y: 0
        width: 120
        height: 350

        Slider {
            id: secSlider
            x: 0
            y: 60
            width: 30
            height: 280
            minimumValue: 0
            maximumValue: 20
            value: delayStartS
            orientation: 0
        }
        Text {
            x: 35
            y: 60
            text: qsTr("2 Sec")
            font.pixelSize: 12
        }
        Text {
            x: 35
            y: 320
            text: qsTr("0 Sec")
            font.pixelSize: 12
        }
        Text {
            x: 40
            y: 90
            text: "Current value: \n" + curDelay + "s"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
        Text {
            x: -27
            y: 8
            width: 90
            height: 40
            text: qsTr("Delay")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 28
        }
    }
    Item {
        //Slider for the delay gain setting.
        id: gain
        x: 150
        y: 0
        width: 120
        height: 350

        Slider {
            id: gainSlider
            x: 0
            y: 60
            width: 30
            height: 280
            minimumValue: 0
            maximumValue: 100
            value: gainStart*100
            orientation: 0
        }
        Text {
            x: 35
            y: 60
            text: qsTr("1")
            font.pixelSize: 12
        }
        Text {
            x: 35
            y: 320
            text: qsTr("0")
            font.pixelSize: 12
        }

        Text {
            x: 40
            y: 90
            text: "Current value: \n" + curGain
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
        Text {
            x: -49
            y: 8
            width: 90
            height: 40
            text: qsTr("Gain")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 28
        }
    }
    Item {
        //Slider for the delay feedback setting.
        id: feedback
        x: 270
        y: 0
        width: 120
        height: 350

        Slider {
            id: feedbackSlider
            x: 0
            y: 60
            width: 30
            height: 280
            minimumValue: 0
            maximumValue: 100
            value: feedbackStart*100
            orientation: 0
        }
        Text {
            x: 35
            y: 60
            text: qsTr("1")
            font.pixelSize: 12
        }
        Text {
            x: 35
            y: 320
            text: qsTr("0")
            font.pixelSize: 12
        }
        Text {
            x: 40
            y: 90
            text: "Current value: \n" + curFeedback
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }
        Text {
            x: -49
            y: 8
            width: 90
            height: 40
            text: qsTr("Feedback")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 28
        }
    }
}
