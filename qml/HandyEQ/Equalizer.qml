import QtQuick 2.0

Item {
    x: 0
    y: 0
    width: 480
    height: 350
    opacity: 1
    //Stores the current values of the bass, midrange and treble.
    //These values are converted to go from 0-8 in steps of 3 db.
    property int bass:      (bass.curValue+12)/3
    property int midrange:  (midrange.curValue+12)/3
    property int treble:    (treble.curValue+12)/3
    //These variables are used when changing the values of the equalizer settings(sliders).
    property int bassStart:     4
    property int midrangeStart: 4
    property int trebleStart:   4

    GenericSlider{
        //Slider for the bass.
        id: bass
        x: 25
        y: 60
        //Sets the text belonging to the slider to bass.
        text1: "Bass"
        //Sets the start value for the bass slider.
        sValue: (bassStart*3)
    }
    GenericSlider{
        //Slider for the midrange.
        id: midrange
        x: 150
        y: 60
        //Sets the text belonging to the slider to midrange.
        text1: "Midrange"
        //Sets the start value for the midrange slider.
        sValue: (midrangeStart*3)
    }
    GenericSlider{
        //Slider for the treble.
        id: treble
        x: 275
        y: 60
        //Sets the text belonging to the slider to treble.
        text1: "Treble"
        //Sets the start value for the treble slider.
        sValue: (trebleStart*3)
    }
}
