import QtQuick 2.0
import QtQuick.Controls 1.1

Item{
    width: 630
    height: 350
    opacity: 1

    property double curDelay: seconds.curValue + mili.curValue
    property string text1: "Delay"
    property double delayStart: 0
    property int delayStartS: delayStart*10
    property int delayStartMS: (delayStart*1000)%100

    GenericHorizontalSlider{
        id: seconds
        x: 20
        y: 50
        text1: "Seconds"
        sValue: delayStartS

    }
    GenericHorizontalSlider{
        id: mili
        x: 20
        y: 200
        maxval: 99
        scale: 1000
        unit: "ms"
        text1: "Milliseconds"
        sValue: delayStartMS
    }

    Text {
        x: 10
        y: 0
        text: text1
        font.pixelSize: 28
    }

    Text {
        x: 450
        y: 50
        text: "Current value:"
        font.pixelSize: 20
    }

    Text {
        x: 502
        y: 80
        text: curDelay + " s"
        font.pixelSize: 20
    }
}
