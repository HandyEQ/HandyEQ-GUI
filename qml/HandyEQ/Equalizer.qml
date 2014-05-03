import QtQuick 2.0

Item {
    x: 0
    y: 0
    width: 480
    height: 350
    opacity: 1

    property int bass:      bass.curValue
    property int midrange:  midrange.curValue
    property int treble:    treble.curValue
    property int bassStart:     0
    property int midrangeStart: 0
    property int trebleStart:   0

    GenericSlider{
        id: bass
        x: 25
        y: 60
        text1: "Bass"
        sValue: bassStart+12
    }
    GenericSlider{
        id: midrange
        x: 150
        y: 60
        text1: "Midrange"
        sValue: midrangeStart+12
    }
    GenericSlider{
        id: treble
        x: 275
        y: 60
        text1: "Treble"
        sValue: trebleStart+12
    }
}
