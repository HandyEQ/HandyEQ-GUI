import QtQuick 2.0

Item{
    //This is currently not used and probaby will not be used since
    //there was no time to implement this effect.
    width: 480
    height: 350
    opacity: 1
    //This is used to read the value of the chorus slider.
    property double curChorus: chorus.curValue

    GenericSlider{
        //Test slider for the chorus.
        id: chorus
        x: 60
        y: 60
        //Setting the name of the slider to chorus.
        text1: "Chorus"
    }
}
