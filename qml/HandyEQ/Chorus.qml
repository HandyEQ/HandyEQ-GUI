import QtQuick 2.0

Item{
    width: 480
    height: 350
    opacity: 1
    property double curChorus: chorus.curValue

    GenericSlider{
        id: chorus
        x: 60
        y: 60
        text1: "Chorus"
    }
}
