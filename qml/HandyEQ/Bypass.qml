import QtQuick 2.0

Rectangle{
    //This rectangle is only used for displaying the text
    //bypassed to indicate that the effect have been bypassed.
    width: 628
    height: 348

    Text {
        //Text boxs that displays the wanted text.
        id: test1
        x: 254
        y: 157
        width: 123
        height: 36
        text: qsTr("Bypassed")
        font.pixelSize: 25
    }
}
