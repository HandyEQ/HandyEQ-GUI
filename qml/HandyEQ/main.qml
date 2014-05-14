import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.1

//Contine commenting in the right container serial part.

Rectangle {
    //This is the window where all of the GUI is contained.
    id: baseWindow
    width: 1400
    height: 800
    state: "start"

    //This value is used when reading from file.
    property int tempVal: 0

    //This will be used to temporary store a value that has been converted into 6 chars with the sign on the left.
    property string tempChar: ""

    //This string is used to temporary store the message sent to the board with configuration settings.
    property string tempString: ""

    //This variable is to stop the GUI from sending the new value when received a segment from the serialport.
    property bool receive: false

    //These variables are only used when sending on the serial port.
    //Float points are calculatedwith (2^15)*value or 32768*value, float points are used for the delay feedback and gain.
    //For the first effect.
    property string d1v1: serialC.valToChar(dsp1val1)
    property string d1v2: {if(effect1rec.state == "delay")serialC.valToChar((dsp1val2/1000)*32768);else serialC.valToChar(dsp1val2);}
    property string d1v3: {if(effect1rec.state == "delay")serialC.valToChar((dsp1val3/1000)*32768);else serialC.valToChar(dsp1val3);}
    //For the second effect.
    property string d2v1: serialC.valToChar(dsp2val1)
    property string d2v2: {if(effect2rec.state == "delay")serialC.valToChar((dsp2val2/1000)*32768);else serialC.valToChar(dsp2val2);}
    property string d2v3: {if(effect2rec.state == "delay")serialC.valToChar((dsp2val3/1000)*32768);else serialC.valToChar(dsp2val3);}
    //For the third effect.
    property string d3v1: serialC.valToChar(dsp3val1)
    property string d3v2: {if(effect3rec.state == "delay")serialC.valToChar((dsp3val2/1000)*32768);else serialC.valToChar(dsp3val2);}
    property string d3v3: {if(effect3rec.state == "delay")serialC.valToChar((dsp3val3/1000)*32768);else serialC.valToChar(dsp3val3);}
    //For the forth effect.
    property string d4v1: serialC.valToChar(dsp1val1)
    property string d4v2: {if(effect4rec.state == "delay")serialC.valToChar((dsp4val2/1000)*32768);else serialC.valToChar(dsp4val2);}
    property string d4v3: {if(effect4rec.state == "delay")serialC.valToChar((dsp4val3/1000)*32768);else serialC.valToChar(dsp4val3);}

    //Values used to store the current first effects and its values.
    property string dsp1name: effect1rec.dsp1State
    //If the delay is the active effect the first value (the delay) will be stored in ms instead of in s, other values are stored in their normal form.
    property int dsp1val1: {if(dsp1name == "equalizer")eE1.bass;else if(dsp1name == "volume")vE1.curValue;else if(dsp1name == "delay")dE1.curDelay*1000;else 0}
    //If the delay is the active effect the second value (the gain) will be stored as 100 times larger than it acctually is, other values are stored in their normal form.
    property int dsp1val2: {if(dsp1name == "equalizer")eE1.midrange;else if(dsp1name == "volume")0;else if(dsp1name == "delay")dE1.curGain*1000;else 0}
    property int dsp1val3: {if(dsp1name == "equalizer")eE1.treble;else if(dsp1name == "volume")0;else if(dsp1name == "delay")dE1.curFeedback*1000;else 0}

    //Values used to store the current second effects and its values.
    property string dsp2name: effect2rec.dsp2State
    //If the delay is the active effect the first value (the delay) will be stored in ms instead of in s, other values are stored in their normal form.
    property int dsp2val1: {if(dsp2name == "equalizer")eE2.bass;else if(dsp2name == "volume")vE2.curValue;else if(dsp2name == "delay")dE2.curDelay*1000;else 0}
    //If the delay is the active effect the second value (the gain) will be stored as 100 times larger than it acctually is, other values are stored in their normal form.
    property int dsp2val2: {if(dsp2name == "equalizer")eE2.midrange;else if(dsp2name == "volume")0;else if(dsp2name == "delay")dE2.curGain*1000;else 0}
    property int dsp2val3: {if(dsp2name == "equalizer")eE2.treble;else if(dsp2name == "volume")0;else if(dsp2name == "delay")dE2.curFeedback*1000;else 0}

    //Values used to store the current third effects and its values.
    property string dsp3name: effect3rec.dsp3State
    //If the delay is the active effect the first value (the delay) will be stored in ms instead of in s, other values are stored in their normal form.
    property int dsp3val1: {if(dsp3name == "equalizer")eE3.bass;else if(dsp3name == "volume")vE3.curValue;else if(dsp3name == "delay")dE3.curDelay*1000;else 0}
    //If the delay is the active effect the second value (the gain) will be stored as 100 times larger than it acctually is, other values are stored in their normal form.
    property int dsp3val2: {if(dsp3name == "equalizer")eE3.midrange;else if(dsp3name == "volume")0;else if(dsp3name == "delay")dE3.curGain*1000;else 0}
    property int dsp3val3: {if(dsp3name == "equalizer")eE3.treble;else if(dsp3name == "volume")0;else if(dsp3name == "delay")dE3.curFeedback*1000;else 0}

    //Values used to store the current forth effects and its values.
    property string dsp4name: effect4rec.dsp4State
    //If the delay is the active effect the first value (the delay) will be stored in ms instead of in s, other values are stored in their normal form.
    property int dsp4val1: {if(dsp4name == "equalizer")eE4.bass;else if(dsp4name == "volume")vE4.curValue;else if(dsp4name == "delay")dE4.curDelay*1000;else 0}
    //If the delay is the active effect the second value (the gain) will be stored as 100 times larger than it acctually is, other values are stored in their normal form.
    property int dsp4val2: {if(dsp4name == "equalizer")eE4.midrange;else if(dsp4name == "volume")0;else if(dsp4name == "delay")dE4.curGain*1000;else 0}
    property int dsp4val3: {if(dsp4name == "equalizer")eE4.treble;else if(dsp4name == "volume")0;else if(dsp4name == "delay")dE4.curFeedback*1000;else 0}

    //This part allows the GUI to send to the board when a value has been changed.
    //When a value is changed it is to be sent to the board.
    onD1v1Changed: {
        if(effect1rec.state == "equalizer"){
            //Will tell the board the value of the bass.
            tempString = tempString + '1' + 'E' + 'B' + 'A' + d1v1 + '#'
        }else if(effect1rec.state == "volume"){
            //Will tell the board the value of the gain.
            tempString = tempString + '1' + 'V' + 'G' + 'A' + d1v1 + '#'
        }else if(effect1rec.state == "delay"){
            //Will tell the board the value of the delay time.
            tempString = tempString + '1' + 'D' + 'D' + 'T' + d1v1 + '#'
        }else{
            //No value to send.
        }
    }
    onD1v2Changed: {
        if(effect1rec.state == "equalizer"){
            //Will tell the board the value of the mid.
            tempString = tempString + '1' + 'E' + 'M' + 'I' + d1v2 + '#'
        }else if(effect1rec.state == "delay"){
            //Will tell the board the value of the gain.
            tempString = tempString + '1' + 'D' + 'G' + 'A' + d1v2 + '#'
        }else{
            //No value to send.
        }
    }
    onD1v3Changed: {
        if(effect1rec.state == "equalizer"){
            //Will tell the board the value of the treble.
            tempString = tempString + '1' + 'E' + 'T' + 'R' + d1v3 + '#'
        }else if(effect1rec.state == "delay"){
            //Will tell the board the value of the delay time.
            tempString = tempString + '1' + 'D' + 'F' + 'B' + d1v3 + '#'
        }else{
            //No value to send.
        }
    }
    //When a value is changed it is to be sent to the board.
    onD2v1Changed: {
        if(effect2rec.state == "equalizer"){
            //Will tell the board the value of the bass.
            tempString = tempString + '2' + 'E' + 'B' + 'A' + d2v1 + '#'
        }else if(effect2rec.state == "volume"){
            //Will tell the board the value of the gain.
            tempString = tempString + '2' + 'V' + 'G' + 'A' + d2v1 + '#'
        }else if(effect2rec.state == "delay"){
            //Will tell the board the value of the delay time.
            tempString = tempString + '2' + 'D' + 'D' + 'T' + d2v1 + '#'
        }else{
            //No value to send.
        }
    }
    onD2v2Changed: {
        if(effect2rec.state == "equalizer"){
            //Will tell the board the value of the mid.
            tempString = tempString + '2' + 'E' + 'M' + 'I' + d2v2 + '#'
        }else if(effect2rec.state == "delay"){
            //Will tell the board the value of the gain.
            tempString = tempString + '2' + 'D' + 'G' + 'A' + d2v2 + '#'
        }else{
            //No value to send.
        }
    }
    onD2v3Changed: {
        if(effect2rec.state == "equalizer"){
            //Will tell the board the value of the treble.
            tempString = tempString + '2' + 'E' + 'T' + 'R' + d2v3 + '#'
        }else if(effect2rec.state == "delay"){
            //Will tell the board the value of the delay time.
            tempString = tempString + '2' + 'D' + 'F' + 'B' + d2v3 + '#'
        }else{
            //No value to send.
        }
    }
    //When a value is changed it is to be sent to the board.
    onD3v1Changed: {
        if(effect3rec.state == "equalizer"){
            //Will tell the board the value of the bass.
            tempString = tempString + '3' + 'E' + 'B' + 'A' + d3v1 + '#'
        }else if(effect3rec.state == "volume"){
            //Will tell the board the value of the gain.
            tempString = tempString + '3' + 'V' + 'G' + 'A' + d3v1 + '#'
        }else if(effect3rec.state == "delay"){
            //Will tell the board the value of the delay time.
            tempString = tempString + '3' + 'D' + 'D' + 'T' + d3v1 + '#'
        }else{
            //No value to send.
        }
    }
    onD3v2Changed: {
        if(effect3rec.state == "equalizer"){
            //Will tell the board the value of the mid.
            tempString = tempString + '3' + 'E' + 'M' + 'I' + d3v2 + '#'
        }else if(effect3rec.state == "delay"){
            //Will tell the board the value of the gain.
            tempString = tempString + '3' + 'D' + 'G' + 'A' + d3v2 + '#'
        }else{
            //No value to send.
        }
    }
    onD3v3Changed: {
        if(effect3rec.state == "equalizer"){
            //Will tell the board the value of the treble.
            tempString = tempString + '3' + 'E' + 'T' + 'R' + d3v3 + '#'
        }else if(effect3rec.state == "delay"){
            //Will tell the board the value of the delay time.
            tempString = tempString + '3' + 'D' + 'F' + 'B' + d3v3 + '#'
        }else{
            //No value to send.
        }
    }
    //When a value is changed from effect 3 it is to be sent to the board.
    onD4v1Changed: {
        if(effect4rec.state == "equalizer"){
            //Will tell the board the value of the bass.
            tempString = tempString + '4' + 'E' + 'B' + 'A' + d4v1 + '#'
        }else if(effect4rec.state == "volume"){
            //Will tell the board the value of the gain.
            tempString = tempString + '4' + 'V' + 'G' + 'A' + d4v1 + '#'
        }else if(effect4rec.state == "delay"){
            //Will tell the board the value of the delay time.
            tempString = tempString + '4' + 'D' + 'D' + 'T' + d4v1 + '#'
        }else{
            //No value to send.
        }
    }
    onD4v2Changed: {
        if(effect4rec.state == "equalizer"){
            //Will tell the board the value of the mid.
            tempString = tempString + '4' + 'E' + 'M' + 'I' + d4v2 + '#'
        }else if(effect4rec.state == "delay"){
            //Will tell the board the value of the gain.
            tempString = tempString + '4' + 'D' + 'G' + 'A' + d4v2 + '#'
        }else{
            //No value to send.
        }
    }
    onD4v3Changed: {
        if(effect4rec.state == "equalizer"){
            //Will tell the board the value of the treble.
            tempString = tempString + '4' + 'E' + 'T' + 'R' + d4v3 + '#'
        }else if(effect4rec.state == "delay"){
            //Will tell the board the value of the delay time.
            tempString = tempString + '4' + 'D' + 'F' + 'B' + d4v3 + '#'
        }else{
            //No value to send.
        }
    }
    //When an effect is changed it is to be sent to the board.
    onDsp1nameChanged: {
        if(effect1rec.state == "equalizer"){
            //Will tell the board that the effect in the first box should be equalizer.
            tempString = 'S' + '1' + 'E' + '2' + 'E' + 'Q' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the bass.
            tempString = tempString + '1' + 'E' + 'B' + 'A' + d1v1 + ':'
            //Will tell the board the value of the mid.
            tempString = tempString + '1' + 'E' + 'M' + 'I' + d1v2 + ':'
            //Will tell the board the value of the bass.
            tempString = tempString + '1' + 'E' + 'T' + 'R' + d1v3 + '#'
            */
        }else if(effect1rec.state == "volume"){
            //Will tell the board that the effect in the first box should be volume.
            tempString = 'S' + '1' + 'E' + '3' + 'V' + 'O' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the gain.
            tempString = tempString + '1' + 'V' + 'G' + 'A' + d1v1 + '#'
            */
        }else if(effect1rec.state == "delay"){
            //Will tell the board that the effect in the first box should be delay.
            tempString = 'S' + '1' + 'E' + '4' + 'D' + 'E' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the delay time.
            tempString = tempString + '1' + 'D' + 'D' + 'T' + d1v1 + ':'
            //Will tell the board the value of the gain.
            tempString = tempString + '1' + 'D' + 'G' + 'A' + d1v2 + ':'
            //Will tell the board the value of the feedback.
            tempString = tempString + '1' + 'D' + 'F' + 'B' + d1v3 + '#'
            */
        }else if(effect1rec.state == "noEffect"){
            //Will tell the board that the effect in the first box should be noeffect.
            tempString = 'S' + '1' + 'E' + '1' + 'N' + 'E' + '0' + '0' + '0' + '0' + '#'
            //No values are used here.
        }else{
            //Will tell the board that the effect in the first box should be bypassed.
            tempString = 'S' + '1' + 'E' + '0' + 'B' + 'Y' + '0' + '0' + '0' + '0' + '#'
            //No values are used here.
        }
    }
    //When an effect is changed it is to be sent to the board.
    onDsp2nameChanged: {
        if(effect2rec.state == "equalizer"){
            //Will tell the board that the effect in the second box should be equalizer.
            tempString = tempString + 'S' + '2' + 'E' + '2' + 'E' + 'Q' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the bass.
            tempString = tempString + '2' + 'E' + 'B' + 'A' + d2v1 + ':'
            //Will tell the board the value of the mid.
            tempString = tempString + '2' + 'E' + 'M' + 'I' + d2v2 + ':'
            //Will tell the board the value of the bass.
            tempString = tempString + '2' + 'E' + 'T' + 'R' + d2v3 + '#'
            */
        }else if(effect2rec.state == "volume"){
            //Will tell the board that the effect in the second box should be volume.
            tempString = tempString + 'S' + '2' + 'E' + '3' + 'V' + 'O' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the gain.
            tempString = tempString + '2' + 'V' + 'G' + 'A' + d2v1 + '#'
            */
        }else if(effect2rec.state == "delay"){
            //Will tell the board that the effect in the second box should be delay.
            tempString = tempString + 'S' + '2' + 'E' + '4' + 'D' + 'E' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the delay time.
            tempString = tempString + '2' + 'D' + 'D' + 'T' + d2v1 + ':'
            //Will tell the board the value of the gain.
            tempString = tempString + '2' + 'D' + 'G' + 'A' + d2v2 + ':'
            //Will tell the board the value of the feedback.
            tempString = tempString + '2' + 'D' + 'F' + 'B' + d2v3 + '#'
            */
        }else if(effect2rec.state == "noEffect"){
            //Will tell the board that the effect in the second box should be noeffect.
            tempString = tempString + 'S' + '2' + 'E' + '1' + 'N' + 'E' + '0' + '0' + '0' + '0' + '#'
            //No values are used here.
        }else{
            //Will tell the board that the effect in the second box should be bypassed.
            tempString = tempString + 'S' + '2' + 'E' + '0' + 'B' + 'Y' + '0' + '0' + '0' + '0' + '#'
            //No values are used here.
        }
    }
    //When an effect is changed it is to be sent to the board.
    onDsp3nameChanged: {
        if(effect3rec.state == "equalizer"){
            //Will tell the board that the effect in the third box should be equalizer.
            tempString = tempString + 'S' + '3' + 'E' + '2' + 'E' + 'Q' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the bass.
            tempString = tempString + '3' + 'E' + 'B' + 'A' + d3v1 + ':'
            //Will tell the board the value of the mid.
            tempString = tempString + '3' + 'E' + 'M' + 'I' + d3v2 + ':'
            //Will tell the board the value of the bass.
            tempString = tempString + '3' + 'E' + 'T' + 'R' + d3v3 + '#'
            */
        }else if(effect3rec.state == "volume"){
            //Will tell the board that the effect in the third box should be volume.
            tempString = tempString + 'S' + '3' + 'E' + '3' + 'V' + 'O' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the gain.
            tempString = tempString + '3' + 'V' + 'G' + 'A' + d3v1 + '#'
            */
        }else if(effect3rec.state == "delay"){
            //Will tell the board that the effect in the third box should be delay.
            tempString = tempString + 'S' + '3' + 'E' + '4' + 'D' + 'E' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the delay time.
            tempString = tempString + '3' + 'D' + 'D' + 'T' + d3v1 + ':'
            //Will tell the board the value of the gain.
            tempString = tempString + '3' + 'D' + 'G' + 'A' + d3v2 + ':'
            //Will tell the board the value of the feedback.
            tempString = tempString + '3' + 'D' + 'F' + 'B' + d3v3 + '#'
            */
        }else if(effect3rec.state == "noEffect"){
            //Will tell the board that the effect in the third box should be noeffect.
            tempString = tempString + 'S' + '3' + 'E' + '1' + 'N' + 'E' + '0' + '0' + '0' + '0' + '#'
            //No values are used here.
        }else{
            //Will tell the board that the effect in the third box should be bypassed.
            tempString = tempString + 'S' + '3' + 'E' + '0' + 'B' + 'Y' + '0' + '0' + '0' + '0' + '#'
            //No values are used here.
        }
    }
    //When an effect is changed it is to be sent to the board.
    onDsp4nameChanged: {
        if(effect4rec.state == "equalizer"){
            //Will tell the board that the effect in the fourth box should be equalizer.
            tempString = tempString + 'S' + '4' + 'E' + '2' + 'E' + 'Q' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the bass.
            tempString = tempString + '4' + 'E' + 'B' + 'A' + d4v1 + ':'
            //Will tell the board the value of the mid.
            tempString = tempString + '4' + 'E' + 'M' + 'I' + d4v2 + ':'
            //Will tell the board the value of the bass.
            tempString = tempString + '4' + 'E' + 'T' + 'R' + d4v3 + '#'
            */
        }else if(effect4rec.state == "volume"){
            //Will tell the board that the effect in the fourth box should be volume.
            tempString = tempString + 'S' + '4' + 'E' + '3' + 'V' + 'O' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the gain.
            tempString = tempString + '4' + 'V' + 'G' + 'A' + d4v1 + '#'
            */
        }else if(effect4rec.state == "delay"){
            //Will tell the board that the effect in the fourth box should be delay.
            tempString = tempString + 'S' + '4' + 'E' + '4' + 'D' + 'E' + '0' + '0' + '0' + '0' + '#'
            /*
            //Will tell the board the value of the delay time.
            tempString = tempString + '4' + 'D' + 'D' + 'T' + d4v1 + ':'
            //Will tell the board the value of the gain.
            tempString = tempString + '4' + 'D' + 'G' + 'A' + d4v2 + ':'
            //Will tell the board the value of the feedback.
            tempString = tempString + '4' + 'D' + 'F' + 'B' + d4v3 + '#'
            */
        }else if(effect4rec.state == "noEffect"){
            //Will tell the board that the effect in the fourth box should be noeffect.
            tempString = tempString + 'S' + '4' + 'E' + '1' + 'N' + 'E' + '0' + '0' + '0' + '0' + '#'
            //No values are used here.
        }else{
            //Will tell the board that the effect in the fourth box should be bypassed.
            tempString = tempString + 'S' + '4' + 'E' + '0' + 'B' + 'Y' + '0' + '0' + '0' + '0' + '#'
            //No values are used here.
        }
    }
    //Used in the debug window.
    property string inText: ""
    property string inTexter: tempString.length

    Timer{
        //This will be used to when sending to the board.
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            //Will send the tempString if the port is open and if the tempString is not empty.
            if(serialCom.state == "open" && receive){
                if(tempString.length > 0 ){
                    //Sending the string created to the board.
                    serialC.sendDataDe(tempString)
                }
            }
            if(tempString.length > 0){
                //inText += tempString + "\n"
            }
            //Clears the string used to store the message send to the board.
            tempString = ""
            receive = true
        }
    }

    SerialCom{
        //Declaration of the Serial class, to be able to use the serial port.
        id: serialC
        objectName: "serialC"
        onInDatanChanged: {
            //When a new JSon value have been read from the serial port the vlaue is stored in the SerialR list, the list is first cleared.
            serialR.clear()
            serialR.append(serialC.inDatan)
            inText = inText + "New Json data read." + '\n'
            //-------------------------------------------------------------------
            //-----------Determines the first box and its settings.--------------
            //-------------------------------------------------------------------
            //----------------------Bypass---------------------------------------
            if(serialR.get(0).d1name == "byPass"){
                //Determins that the first effect is bypassed.
                effect1rec.state = "byPass"
                menuEff1.state = "byPass"
            }
            //----------------------NoEffect-------------------------------------
            if(serialR.get(0).d1name == "noEffect"){
                //Determins that the first effect is no effect.
                effect1rec.state = "noEffect"
                menuEff1.state = "effect"
                noEff1.checked = true
            }
            //----------------------Equalizer------------------------------------
            if(serialR.get(0).d1name == "equalizer"){
                //Determins that the first effect is the equalizer.
                effect1rec.state = "equalizer"
                menuEff1.state = "effect"
                equal1.checked = true
                if(serialR.get(0).ds1val1 == "change"){
                    //Sets the first equalizer setting
                    eE1.bassStart = serialR.get(0).dsp1val1
                }
                if(serialR.get(0).ds1val2 == "change"){
                    //Sets the second equalizer setting
                    eE1.midrangeStart = serialR.get(0).dsp1val2
                }
                if(serialR.get(0).ds1val3 == "change"){
                    //Sets the third equalizer setting
                    eE1.trebleStart = serialR.get(0).dsp1val3
                }
            }
            //----------------------Delay----------------------------------------
            if(serialR.get(0).d1name == "delay"){
                //Determins that the first effect is the delay.
                effect1rec.state = "delay"
                menuEff1.state = "effect"
                delay1.checked = true
                if(serialR.get(0).ds1val1 == "change"){
                    //Sets the first delay setting
                    dE1.delayStart = serialR.get(0).dsp1val1
                }
                if(serialR.get(0).ds1val2 == "change"){
                    //Sets the second delay setting
                    dE1.gainStart = serialR.get(0).dsp1val2 / 32768
                }
                if(serialR.get(0).ds1val3 == "change"){
                    //Sets the third delay setting
                    dE1.feedbackStart = serialR.get(0).dsp1val3  / 32768
                }
            }
            //----------------------volume---------------------------------------
            if(serialR.get(0).d1name == "volume"){
                //Determins that the first effect is volume.
                effect1rec.state = "volume"
                menuEff1.state = "effect"
                volume1.checked = true
                if(serialR.get(0).ds1val1 == "change"){
                    //Sets the first volume setting
                    vE1.sValue = serialR.get(0).dsp1val1 * -1
                }
            }
            //-------------------------------------------------------------------
            //-----------Determines the second box and its settings.-------------
            //-------------------------------------------------------------------
            //----------------------Bypass---------------------------------------
            if(serialR.get(0).d2name == "byPass"){
                //Determins that the second effect is bypassed.
                effect2rec.state = "byPass"
                menuEff2.state = "byPass"
            }
            //----------------------NoEffect-------------------------------------
            if(serialR.get(0).d2name ==  "noEffect"){
                //Determins that the second effect is no effect.
                effect2rec.state = "noEffect"
                menuEff2.state = "effect"
                noEff2.checked = true
            }
            //----------------------Equalizer------------------------------------
            if(serialR.get(0).d2name == "equalizer"){
                //Determins that the second effect is the equalizer.
                effect2rec.state = "equalizer"
                menuEff2.state = "effect"
                equal2.checked = true
                if(serialR.get(0).ds2val1 == "change"){
                    //Sets the first equalizer setting
                    eE2.bassStart = serialR.get(0).dsp2val1
                }
                if(serialR.get(0).ds2val2 == "change"){
                    //Sets the second equalizer setting
                    eE2.midrangeStart = serialR.get(0).dsp2val2
                }
                if(serialR.get(0).ds2val3 == "change"){
                    //Sets the third equalizer setting
                    eE2.trebleStart = serialR.get(0).dsp2val3
                }
            }
            //----------------------Delay----------------------------------------
            if(serialR.get(0).d2name == "delay"){
                //Determins that the second effect is the delay.
                effect2rec.state = "delay"
                menuEff2.state = "effect"
                delay2.checked = true
                if(serialR.get(0).ds2val1 == "change"){
                    //Sets the first delay setting
                    dE2.delayStart = serialR.get(0).dsp2val1
                }
                if(serialR.get(0).ds2val2 == "change"){
                    //Sets the second delay setting
                    dE2.gainStart = serialR.get(0).dsp2val2 / 32768
                }
                if(serialR.get(0).ds2val3 == "change"){
                    //Sets the third delay setting
                    dE2.feedbackStart = serialR.get(0).dsp2val3  / 32768
                }
            }
            //----------------------volume---------------------------------------
            if(serialR.get(0).d2name == "volume"){
                //Determins that the second effect is volume.
                effect2rec.state = "volume"
                menuEff2.state = "effect"
                volume2.checked = true
                if(serialR.get(0).ds2val1 == "change"){
                    //Sets the first volume setting
                    vE2.sValue = serialR.get(0).dsp2val1 * -1
                }
            }
            //-------------------------------------------------------------------
            //-----------Determines the third box and its settings.--------------
            //-------------------------------------------------------------------
            //----------------------Bypass---------------------------------------
            if(serialR.get(0).d3name == "byPass"){
                //Determins that the third effect is bypassed.
                effect3rec.state = "byPass"
                menuEff3.state = "byPass"
            }
            //----------------------NoEffect-------------------------------------
            if(serialR.get(0).d3name == "noEffect"){
                //Determins that the third effect is no effect.
                effect3rec.state = "noEffect"
                menuEff3.state = "effect"
                noEff3.checked = true
            }
            //----------------------Equalizer------------------------------------
            if(serialR.get(0).d3name == "equalizer"){
                //Determins that the third effect is the equalizer.
                effect3rec.state = "equalizer"
                menuEff3.state = "effect"
                equal3.checked = true
                if(serialR.get(0).ds3val1 == "change"){
                    //Sets the first equalizer setting
                    eE3.bassStart = serialR.get(0).dsp3val1
                }
                if(serialR.get(0).ds3val2 == "change"){
                    //Sets the second equalizer setting
                    eE3.midrangeStart = serialR.get(0).dsp3val2
                }
                if(serialR.get(0).ds3val3 == "change"){
                    //Sets the third equalizer setting
                    eE3.trebleStart = serialR.get(0).dsp3val3
                }
            }
            //----------------------Delay----------------------------------------
            if(serialR.get(0).d3name == "delay"){
                //Determins that the third effect is the delay.
                effect3rec.state = "delay"
                menuEff3.state = "effect"
                delay3.checked = true
                if(serialR.get(0).ds3val1 == "change"){
                    //Sets the first delay setting
                    dE3.delayStart = serialR.get(0).dsp3val1
                }
                if(serialR.get(0).ds3val2 == "change"){
                    //Sets the second delay setting
                    dE3.gainStart = serialR.get(0).dsp3val2 / 32768
                }
                if(serialR.get(0).ds3val3 == "change"){
                    //Sets the third delay setting
                    dE3.feedbackStart = serialR.get(0).dsp3val3  / 32768
                }
            }
            //----------------------volume---------------------------------------
            if(serialR.get(0).d3name == "volume"){
                //Determins that the third effect is volume.
                effect3rec.state = "volume"
                menuEff3.state = "effect"
                volume3.checked = true
                if(serialR.get(0).ds3val1 == "change"){
                    //Sets the first volume setting
                    vE3.sValue = serialR.get(0).dsp3val1 * -1
                }
            }
            //-------------------------------------------------------------------
            //-----------Determines the forth box and its settings.--------------
            //-------------------------------------------------------------------
            //----------------------Bypass---------------------------------------
            if(serialR.get(0).d4name == "byPass"){
                //Determins that the forth effect is bypassed.
                effect4rec.state = "byPass"
                menuEff4.state = "byPass"
            }
            //----------------------NoEffect-------------------------------------
            if(serialR.get(0).d4name == "noEffect"){
                //Determins that the forth effect is no effect.
                effect4rec.state = "noEffect"
                menuEff4.state = "effect"
                noEff4.checked = true
            }
            //----------------------Equalizer------------------------------------
            if(serialR.get(0).d4name == "equalizer"){
                //Determins that the forth effect is the equalizer.
                effect4rec.state = "equalizer"
                menuEff4.state = "effect"
                equal4.checked = true
                if(serialR.get(0).ds4val1 == "change"){
                    //Sets the first equalizer setting
                    eE4.bassStart = serialR.get(0).dsp4val1
                }
                if(serialR.get(0).ds4val2 == "change"){
                    //Sets the second equalizer setting
                    eE4.midrangeStart = serialR.get(0).dsp4val2
                }
                if(serialR.get(0).ds4val3 == "change"){
                    //Sets the third equalizer setting
                    eE4.trebleStart = serialR.get(0).dsp4val3
                }
            }
            //----------------------Delay----------------------------------------
            if(serialR.get(0).d4name == "delay"){
                //Determins that the forth effect is the delay.
                effect4rec.state = "delay"
                menuEff4.state = "effect"
                delay4.checked = true
                if(serialR.get(0).ds4val1 == "change"){
                    //Sets the first delay setting
                    dE4.delayStart = serialR.get(0).dsp4val1
                }
                if(serialR.get(0).ds4val2 == "change"){
                    //Sets the second delay setting
                    dE4.gainStart = serialR.get(0).dsp4val2 / 32768
                }
                if(serialR.get(0).ds4val3 == "change"){
                    //Sets the third delay setting
                    dE4.feedbackStart = serialR.get(0).dsp4val3  / 32768
                }
            }
            //----------------------volume---------------------------------------
            if(serialR.get(0).d4name == "volume"){
                //Determins that the forth effect is volume.
                effect4rec.state = "volume"
                menuEff4.state = "effect"
                volume4.checked = true
                if(serialR.get(0).ds4val1 == "change"){
                    //Sets the first volume setting
                    vE4.sValue = serialR.get(0).dsp4val1 * -1
                }
            }
            receive = false
        }

    }
    ListModel{
        //This is used to store the data read from the serial port.
        id: serialR
    }
    Item {
        //This is the area in the top of the window.
        id: containerTop
        x: 0
        y: 0
        z: 1
        width: parent.width
        height: 100

        Text {
            //Displays the name of the project.
            id: applicationName
            x: 6
            y: 6
            text: qsTr("HandyEQ")
            font.bold: true
            font.pointSize: 48
            font.family: "Courier"
        }
        MouseArea{
            //When clicked takes you to the debug state, which is not currently used.
            x: 0
            y: 0
            z: 1
            opacity: 1
            width: 400
            height: 100

            onClicked: {
                baseWindow.state = "debug"
            }
        }
        //These text areas are used for testing and needs to be removed later.
        Text {
            id: text1
            x: 300
            y: 0
            width: 93
            height: 29
            text: inTexter
            font.pixelSize: 24
        }
        Text {
            id: text2
            x: 300
            y: 50
            width: 200
            text: tempString
            font.pixelSize: 24
        }
        //This item will changed later.
        Item {
            //This area is used to choose whether to bypass the effect or to use them.
            id: systemoverview
            x: 400
            y: 0
            width: 1000
            height: 100

            Rectangle {
                //This is where you can choose to bypass the first effect.
                id: menuEff1
                x: 50
                y: 10
                width: 150
                height: 80
                radius: 1
                border.width: 2
                property string eff1: {if(menuEff1.state == "byPass")"byPass";else"effect";}
                state: "byPass"

                MouseArea {
                    //When this is clicked it toggles the state of the first effect between using effects and bypassing them.
                    x: 0
                    y: 0
                    width: menuEff1.width
                    height: menuEff1.height

                    onClicked: {
                        if(menuEff1.state == "byPass"){
                            //Sets the first effect to active.
                            menuEff1.state = "effect"
                            //This part makes sure that that the correct effect is active.
                            if(noEff1.checked){
                                effect1rec.state = "noEffect"
                            }else if(equal1.checked){
                                effect1rec.state = "equalizer"
                            }else if(volume1.checked){
                                effect1rec.state = "volume"
                            }else if(delay1.checked){
                                effect1rec.state = "delay"
                            }
                        }else if(menuEff1.state == "effect"){
                            //Sets the first effect to bypassed.
                            menuEff1.state = "byPass"
                            effect1rec.state = "byPass"
                        }
                    }
                }
                Text {
                    //Displays whether the first effect is bypassed of not.
                    id: eff1t
                    width: 150
                    height: 80
                    text: menuEff1.eff1
                    font.pointSize: 24
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle {
                //This is where you can choose to bypass the second effect.
                id: menuEff2
                x: 300
                y: 10
                width: 150
                height: 80
                radius: 1
                border.width: 2
                property string eff2: {if(menuEff2.state == "byPass")"byPass";else"effect";}
                state: "byPass"

                MouseArea {
                    //When this is clicked it toggles the state of the second effect between using effects and bypassing them.
                    x: 0
                    y: 0
                    width: menuEff2.width
                    height: menuEff2.height

                    onClicked: {
                        if(menuEff2.state == "byPass"){
                            //Sets the first effect to active.
                            menuEff2.state = "effect"
                            //This part makes sure that that the correct effect is active.
                            if(noEff2.checked){
                                effect2rec.state = "noEffect"
                            }else if(equal2.checked){
                                effect2rec.state = "equalizer"
                            }else if(volume2.checked){
                                effect2rec.state = "volume"
                            }else if(delay2.checked){
                                effect2rec.state = "delay"
                            }
                        }else if(menuEff2.state == "effect"){
                            //Sets the second effect to bypassed.
                            menuEff2.state = "byPass"
                            effect2rec.state = "byPass"
                        }
                    }
                }
                Text {
                    //Displays whether the second effect is bypassed of not.
                    id: eff2t
                    width: 150
                    height: 80
                    text: menuEff2.eff2
                    font.pointSize: 24
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle {
                //This is where you can choose to bypass the third effect.
                id: menuEff3
                x: 550
                y: 10
                width: 150
                height: 80
                radius: 1
                border.width: 2
                property string eff3: {if(menuEff3.state == "byPass")"byPass";else"effect";}
                state: "byPass"

                MouseArea {
                    //When this is clicked it toggles the state of the third effect between using effects and bypassing them.
                    x: 0
                    y: 0
                    width: menuEff3.width
                    height: menuEff3.height

                    onClicked: {
                        if(menuEff3.state == "byPass"){
                            //Sets the third effect to active.
                            menuEff3.state = "effect"
                            //This part makes sure that that the correct effect is active.
                            if(noEff3.checked){
                                effect3rec.state = "noEffect"
                            }else if(equal3.checked){
                                effect3rec.state = "equalizer"
                            }else if(volume3.checked){
                                effect3rec.state = "volume"
                            }else if(delay3.checked){
                                effect3rec.state = "delay"
                            }
                        }else if(menuEff3.state == "effect"){
                            //Sets the third effect to bypassed.
                            menuEff3.state = "byPass"
                            effect3rec.state = "byPass"
                        }
                    }
                }
                Text {
                    //Displays whether the third effect is bypassed of not.
                    id: eff3t
                    width: 150
                    height: 80
                    text: menuEff3.eff3
                    font.pointSize: 24
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            Rectangle {
                //This is where you can choose to bypass the second effect.
                id: menuEff4
                x: 800
                y: 10
                width: 150
                height: 80
                radius: 1
                border.width: 2
                property string eff4: {if(menuEff4.state == "byPass")"byPass";else"effect";}
                state: "byPass"

                MouseArea {
                    //When this is clicked it toggles the state of the forth effect between using effects and bypassing them.
                    x: 0
                    y: 0
                    width: menuEff4.width
                    height: menuEff4.height

                    onClicked: {
                        if(menuEff4.state == "byPass"){
                            //Sets the forth effect to active.
                            menuEff4.state = "effect"
                            //This part makes sure that that the correct effect is active.
                            if(noEff4.checked){
                                effect4rec.state = "noEffect"
                            }else if(equal4.checked){
                                effect4rec.state = "equalizer"
                            }else if(volume4.checked){
                                effect4rec.state = "volume"
                            }else if(delay4.checked){
                                effect4rec.state = "delay"
                            }
                        }else if(menuEff4.state == "effect"){
                            //Sets the forth effect to bypassed.
                            menuEff4.state = "byPass"
                            effect4rec.state = "byPass"
                        }
                    }
                }
                Text {
                    //Displays whether the forth effect is bypassed of not.
                    id: eff4t
                    width: 150
                    height: 80
                    text: menuEff4.eff4
                    font.pointSize: 24
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
    Item {
        //This is the area to the most right in the window.
        id: containerRight
        x: contentContainer.width
        y: containerTop.height
        width: baseWindow.width-contentContainer.width
        height: baseWindow.height-containerTop.height

        Column {
            //This column is used to display the available presets.
            id: column
            x: 0
            y: 0
            spacing: 0
            anchors.fill: parent

            ListView {
                //This is used to dispaly the list of presets.
                id: presetList
                x: 0
                y: 0
                width: containerRight.width
                height: containerRight.height-500
                highlightFollowsCurrentItem: true

                model: ListModel {
                    id: presetModel
                }
                Component.onCompleted: {
                    //When the column is created the content of the file containing the presets is read and loaded into this list.
                    presetModel.append(fileH.read())
                }
                delegate: Rectangle {
                    //Descibe the properties of the items in the list.
                    x: 5
                    height: 40
                    width: presetList.width
                    z: 0

                    Text {
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea {
                        //When a preset in the list is clicked.
                        anchors.fill: parent
                        onClicked: {
                            if(removeBox.checked){
                                //If the remove box is checked the preset is removed.
                                fileH.remove(index)
                                presetModel.remove(index)
                            }else{
                                //If the remove box is not checked a preset is loaded.
                                //Loads the effect 1 values.
                                menuEff1.state = "effect"
                                if(presetModel.get(index).dsp1name == "equalizer"){
                                    equal1.checked = true
                                    effect1rec.state = "equalizer"
                                    eE1.bassStart = presetModel.get(index).dsp1val1
                                    eE1.midrangeStart = presetModel.get(index).dsp1val2
                                    eE1.trebleStart = presetModel.get(index).dsp1val3
                                }else if(presetModel.get(index).dsp1name== "volume"){
                                    volume1.checked = true
                                    effect1rec.state = "volume"
                                    vE1.sValue = presetModel.get(index).dsp1val1 * -1
                                }else if(presetModel.get(index).dsp1name == "delay"){
                                    delay1.checked = true
                                    effect1rec.state = "delay"
                                    dE1.delayStart = presetModel.get(index).dsp1val1 / 1000
                                    dE1.gainStart = presetModel.get(index).dsp1val2 / 1000
                                    dE1.feedbackStart = presetModel.get(index).dsp1val3 / 1000
                                }else if(presetModel.get(index).dsp1name == "noEffect"){
                                    noEff1.checked = true
                                    effect1rec.state = "noEffect"
                                }else{
                                    effect1rec.state = "byPass"
                                    menuEff1.state = "byPass"
                                }

                                //Loads the effect 2 values.
                                menuEff2.state = "effect"
                                if(presetModel.get(index).dsp2name == "equalizer"){
                                    equal2.checked = true
                                    effect2rec.state = "equalizer"
                                    eE2.bassStart = presetModel.get(index).dsp2val1
                                    eE2.midrangeStart = presetModel.get(index).dsp2val2
                                    eE2.trebleStart = presetModel.get(index).dsp2val3
                                }else if(presetModel.get(index).dsp2name== "volume"){
                                    volume2.checked = true
                                    effect2rec.state = "volume"
                                    vE2.sValue = presetModel.get(index).dsp2val1 * -1
                                }else if(presetModel.get(index).dsp2name == "delay"){
                                    delay2.checked = true
                                    effect2rec.state = "delay"
                                    dE2.delayStart = presetModel.get(index).dsp2val1 / 1000
                                    dE2.gainStart = presetModel.get(index).dsp2val2 / 1000
                                    dE2.feedbackStart = presetModel.get(index).dsp2val3 / 1000
                                }else if(presetModel.get(index).dsp2name == "noEffect"){
                                    noEff2.checked = true
                                    effect2rec.state = "noEffect"
                                }else{
                                    effect2rec.state = "byPass"
                                    menuEff2.state = "byPass"
                                }
                                //Loads the effect 3 values.
                                menuEff3.state = "effect"
                                if(presetModel.get(index).dsp3name == "equalizer"){
                                    equal3.checked = true
                                    effect3rec.state = "equalizer"
                                    eE3.bassStart = presetModel.get(index).dsp3val1
                                    eE3.midrangeStart = presetModel.get(index).dsp3val2
                                    eE3.trebleStart = presetModel.get(index).dsp3val3
                                }else if(presetModel.get(index).dsp3name== "volume"){
                                    volume3.checked = true
                                    effect3rec.state = "volume"
                                    vE3.sValue = presetModel.get(index).dsp3val1 * -1
                                }else if(presetModel.get(index).dsp3name == "delay"){
                                    delay3.checked = true
                                    effect3rec.state = "delay"
                                    dE3.delayStart = presetModel.get(index).dsp3val1 / 1000
                                    dE3.gainStart = presetModel.get(index).dsp3val2 / 1000
                                    dE3.feedbackStart = presetModel.get(index).dsp3val3 / 1000
                                }else if(presetModel.get(index).dsp3name == "noEffect"){
                                    noEff3.checked = true
                                    effect3rec.state = "noEffect"
                                }else{
                                    effect3rec.state = "byPass"
                                    menuEff3.state = "byPass"
                                }
                                //Loads the effect 4 values.
                                menuEff4.state = "effect"
                                if(presetModel.get(index).dsp4name == "equalizer"){
                                    equal4.checked = true
                                    effect4rec.state = "equalizer"
                                    eE4.bassStart = presetModel.get(index).dsp4val1
                                    eE4.midrangeStart = presetModel.get(index).dsp4val2
                                    eE4.trebleStart = presetModel.get(index).dsp4val3
                                }else if(presetModel.get(index).dsp4name== "volume"){
                                    volume4.checked = true
                                    effect4rec.state = "volume"
                                    vE4.sValue = presetModel.get(index).dsp4val1 * -1
                                }else if(presetModel.get(index).dsp4name == "delay"){
                                    delay4.checked = true
                                    effect4rec.state = "delay"
                                    dE4.delayStart = presetModel.get(index).dsp4val1 / 1000
                                    dE4.gainStart = presetModel.get(index).dsp4val2 / 1000
                                    dE4.feedbackStart = presetModel.get(index).dsp4val3 / 1000
                                }else if(presetModel.get(index).dsp4name == "noEffect"){
                                    noEff4.checked = true
                                    effect4rec.state = "noEffect"
                                }else{
                                    effect4rec.state = "byPass"
                                    menuEff4.state = "byPass"
                                }
                                //Prints the number of available presets.
                                console.log("List Size: "+presetList.count+"\n")
                            }
                        }
                    }
                }
            }
        }
        Item {
                //When the radio button is checked the list above removes the clicked preset.
                id: removeContainer
                x: 10
                y: containerRight.height-400
                width: 120
                height: 40

                CheckBox {
                    id: removeBox
                    x: 5
                    y: 10
                    text: qsTr("Remove preset")
                }
            }
        Item {
                //In this container you can change the serial port choosen earlier, you can also open and close the port.
                //This is also where you can send all the settings currently in the effect areas to the board with the send to bard button.
                id: serialContainer
                x: 10
                y: containerRight.height-350
                width: 120
                height: 200
                state: "setPortList"

                Item {
                    //This item is uesd to contain the list of available ports.
                    id: setPort
                    anchors.fill: serialContainer
                    opacity: 1
                    z: 1

                    Text {
                        //Headline of the container.
                        id: serialText
                        text: qsTr("Available ports:")
                    }
                    Column{
                        //This is used to contain the list of available ports.
                        id: portColumn
                        x: 0
                        y: serialText.height
                        spacing: 0
                        width: setPort.width
                        height: setPort.height-serialText.height-serialContainer.height

                        ListView{
                            id: portList
                            x: 0
                            y: 0
                            width: setPort.width
                            height: setPort.height-serialText.height-50
                            highlightFollowsCurrentItem: true
                            model: ListModel{
                                //This list is used to store the available ports.
                                id: portlistmodel
                            }
                            Component.onCompleted: {
                                //When the column is created the available ports are loaded into the list displayed in the column.
                                portlistmodel.append(serialC.getPortList())
                            }
                            delegate: Rectangle {
                                x: 5
                                height: 40
                                width: presetList.width
                                z: 0
                                Text {
                                    text: name
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                MouseArea {
                                    //When a port is chosen it is set as active and the state in the serialcontainer is changed to be able to open the port.
                                    anchors.fill: parent
                                    onClicked: {
                                        serialC.setPortS(name)
                                        serialContainer.state = "serialCom"
                                    }
                                }
                            }
                        }
                    }
                    Button {
                        //This is used to renew the list of available ports.
                        id: renewPorts
                        x: 0
                        y: setPort.height-50
                        width: setPort.width
                        height: 40

                        text: qsTr("Get ports")
                        onClicked: {
                            portlistmodel.clear()
                            portlistmodel.append(serialC.getPortList())
                            //serialContainer.state = "serialCom"
                        }
                    }
                }
                Item{
                    //Used to handle the serial port.
                    id: serialCom
                    anchors.fill: serialContainer
                    opacity: 0
                    z: 0
                    state: "closed"
                    Button {
                        //Used to open the serial port and when clicked displays the close and send to board buttons in the serialcontainer.
                        id: open
                        x: 0
                        y: 0
                        z: 1
                        opacity: 1
                        width: serialCom.width
                        height: 40
                        text: qsTr("Open port")
                        onClicked: {
                            serialCom.state = "open"
                            //Opens the port.
                            serialC.openPort()
                            //Sends a request to the board to get the current settings.
                            tempString = "IIIIIIIIII#"
                            serialC.sendDataDe(tempString)
                            //This makes sure that the string is not sent twice.
                            receive = false
                        }
                    }
                    Button {
                        //Used to close the serial port and return to displaying the open port / change port in the serialcontainer.
                        id: close
                        x: 0
                        y: 0
                        z: 0
                        opacity: 0
                        width: serialCom.width
                        height: 40
                        text: qsTr("Close port")
                        onClicked: {
                            serialCom.state = "closed"
                            serialC.closePort()
                        }
                    }
                    Button {
                        //Used to send all the current settings to the board via the serial port.
                        id: sendSerialButton
                        x: 0
                        y: 50
                        z: 0
                        opacity: 0
                        width: serialCom.width
                        height: 40
                        text: qsTr("Send to board")
                        onClicked: {
                            //Sorts the format that the values are to be sent in.                            
                            //Clears the string used to store the message send to the board.
                            tempString = ""
                            //Creates a String that is to be sent to the Board.
                            //Looks what the first effect is.
                            if(effect1rec.state == "equalizer"){
                                //Will tell the board that the effect in the first box should be equalizer.
                                tempString = 'S' + '1' + 'E' + '2' + 'E' + 'Q' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the bass.
                                tempString = tempString + '1' + 'E' + 'B' + 'A' + d1v1 + ':'
                                //Will tell the board the value of the mid.
                                tempString = tempString + '1' + 'E' + 'M' + 'I' + d1v2 + ':'
                                //Will tell the board the value of the bass.
                                tempString = tempString + '1' + 'E' + 'T' + 'R' + d1v3 + ':'
                            }else if(effect1rec.state == "volume"){
                                //Will tell the board that the effect in the first box should be volume.
                                tempString = 'S' + '1' + 'E' + '3' + 'V' + 'O' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the gain.
                                tempString = tempString + '1' + 'V' + 'G' + 'A' + d1v1 + ':'
                            }else if(effect1rec.state == "delay"){
                                //Will tell the board that the effect in the first box should be delay.
                                tempString = 'S' + '1' + 'E' + '4' + 'D' + 'E' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the delay time.
                                tempString = tempString + '1' + 'D' + 'D' + 'T' + d1v1 + ':'
                                //Will tell the board the value of the gain.
                                tempString = tempString + '1' + 'D' + 'G' + 'A' + d1v2 + ':'
                                //Will tell the board the value of the feedback.
                                tempString = tempString + '1' + 'D' + 'F' + 'B' + d1v3 + ':'
                            }else if(effect1rec.state == "noEffect"){
                                //Will tell the board that the effect in the first box should be noeffect.
                                tempString = 'S' + '1' + 'E' + '1' + 'N' + 'E' + '0' + '0' + '0' + '0' + ':'
                                //No values are used here.
                            }else{
                                //Will tell the board that the effect in the first box should be bypassed.
                                tempString = 'S' + '1' + 'E' + '0' + 'B' + 'Y' + '0' + '0' + '0' + '0' + ':'
                                //No values are used here.
                            }
                            //Looks what the second effect is.
                            if(effect2rec.state == "equalizer"){
                                //Will tell the board that the effect in the second box should be equalizer.
                                tempString = tempString + 'S' + '2' + 'E' + '2' + 'E' + 'Q' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the bass.
                                tempString = tempString + '2' + 'E' + 'B' + 'A' + d2v1 + ':'
                                //Will tell the board the value of the mid.
                                tempString = tempString + '2' + 'E' + 'M' + 'I' + d2v2 + ':'
                                //Will tell the board the value of the bass.
                                tempString = tempString + '2' + 'E' + 'T' + 'R' + d2v3 + ':'
                            }else if(effect2rec.state == "volume"){
                                //Will tell the board that the effect in the second box should be volume.
                                tempString = tempString + 'S' + '2' + 'E' + '3' + 'V' + 'O' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the gain.
                                tempString = tempString + '2' + 'V' + 'G' + 'A' + d2v1 + ':'
                            }else if(effect2rec.state == "delay"){
                                //Will tell the board that the effect in the second box should be delay.
                                tempString = tempString + 'S' + '2' + 'E' + '4' + 'D' + 'E' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the delay time.
                                tempString = tempString + '2' + 'D' + 'D' + 'T' + d2v1 + ':'
                                //Will tell the board the value of the gain.
                                tempString = tempString + '2' + 'D' + 'G' + 'A' + d2v2 + ':'
                                //Will tell the board the value of the feedback.
                                tempString = tempString + '2' + 'D' + 'F' + 'B' + d2v3 + ':'
                            }else if(effect2rec.state == "noEffect"){
                                //Will tell the board that the effect in the second box should be noeffect.
                                tempString = tempString + 'S' + '2' + 'E' + '1' + 'N' + 'E' + '0' + '0' + '0' + '0' + ':'
                                //No values are used here.
                            }else{
                                //Will tell the board that the effect in the second box should be bypassed.
                                tempString = tempString + 'S' + '2' + 'E' + '0' + 'B' + 'Y' + '0' + '0' + '0' + '0' + ':'
                                //No values are used here.
                            }
                            //Looks what the third effect is.
                            if(effect3rec.state == "equalizer"){
                                //Will tell the board that the effect in the third box should be equalizer.
                                tempString = tempString + 'S' + '3' + 'E' + '2' + 'E' + 'Q' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the bass.
                                tempString = tempString + '3' + 'E' + 'B' + 'A' + d3v1 + ':'
                                //Will tell the board the value of the mid.
                                tempString = tempString + '3' + 'E' + 'M' + 'I' + d3v2 + ':'
                                //Will tell the board the value of the bass.
                                tempString = tempString + '3' + 'E' + 'T' + 'R' + d3v3 + ':'
                            }else if(effect3rec.state == "volume"){
                                //Will tell the board that the effect in the third box should be volume.
                                tempString = tempString + 'S' + '3' + 'E' + '3' + 'V' + 'O' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the gain.
                                tempString = tempString + '3' + 'V' + 'G' + 'A' + d3v1 + ':'
                            }else if(effect3rec.state == "delay"){
                                //Will tell the board that the effect in the third box should be delay.
                                tempString = tempString + 'S' + '3' + 'E' + '4' + 'D' + 'E' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the delay time.
                                tempString = tempString + '3' + 'D' + 'D' + 'T' + d3v1 + ':'
                                //Will tell the board the value of the gain.
                                tempString = tempString + '3' + 'D' + 'G' + 'A' + d3v2 + ':'
                                //Will tell the board the value of the feedback.
                                tempString = tempString + '3' + 'D' + 'F' + 'B' + d3v3 + ':'
                            }else if(effect3rec.state == "noEffect"){
                                //Will tell the board that the effect in the third box should be noeffect.
                                tempString = tempString + 'S' + '3' + 'E' + '1' + 'N' + 'E' + '0' + '0' + '0' + '0' + ':'
                                //No values are used here.
                            }else{
                                //Will tell the board that the effect in the third box should be bypassed.
                                tempString = tempString + 'S' + '3' + 'E' + '0' + 'B' + 'Y' + '0' + '0' + '0' + '0' + ':'
                                //No values are used here.
                            }
                            //Looks what the fourth effect is.
                            if(effect4rec.state == "equalizer"){
                                //Will tell the board that the effect in the fourth box should be equalizer.
                                tempString = tempString + 'S' + '4' + 'E' + '2' + 'E' + 'Q' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the bass.
                                tempString = tempString + '4' + 'E' + 'B' + 'A' + d4v1 + ':'
                                //Will tell the board the value of the mid.
                                tempString = tempString + '4' + 'E' + 'M' + 'I' + d4v2 + ':'
                                //Will tell the board the value of the bass.
                                tempString = tempString + '4' + 'E' + 'T' + 'R' + d4v3 + '#'
                            }else if(effect4rec.state == "volume"){
                                //Will tell the board that the effect in the fourth box should be volume.
                                tempString = tempString + 'S' + '4' + 'E' + '3' + 'V' + 'O' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the gain.
                                tempString = tempString + '4' + 'V' + 'G' + 'A' + d4v1 + '#'
                            }else if(effect4rec.state == "delay"){
                                //Will tell the board that the effect in the fourth box should be delay.
                                tempString = tempString + 'S' + '4' + 'E' + '4' + 'D' + 'E' + '0' + '0' + '0' + '0' + ':'
                                //Will tell the board the value of the delay time.
                                tempString = tempString + '4' + 'D' + 'D' + 'T' + d4v1 + ':'
                                //Will tell the board the value of the gain.
                                tempString = tempString + '4' + 'D' + 'G' + 'A' + d4v2 + ':'
                                //Will tell the board the value of the feedback.
                                tempString = tempString + '4' + 'D' + 'F' + 'B' + d4v3 + '#'
                            }else if(effect4rec.state == "noEffect"){
                                //Will tell the board that the effect in the fourth box should be noeffect.
                                tempString = tempString + 'S' + '4' + 'E' + '1' + 'N' + 'E' + '0' + '0' + '0' + '0' + '#'
                                //No values are used here.
                            }else{
                                //Will tell the board that the effect in the fourth box should be bypassed.
                                tempString = tempString + 'S' + '4' + 'E' + '0' + 'B' + 'Y' + '0' + '0' + '0' + '0' + '#'
                                //No values are used here.
                            }
                            //Sending the string created to the board.
                            serialC.sendDataDe(tempString)
                            //Clears the string used to store the message send to the board.
                            tempString = ""
                        }
                    }
                    Button {
                        //When clicked the list of serial ports is displayed in the serialcontainer area.
                        id: changePortButton
                        x: 0
                        y: 50
                        z: 1
                        opacity: 1
                        width: serialCom.width
                        height: 40
                        text: qsTr("Change port")
                        onClicked: {
                            serialContainer.state = "setPortList"
                        }
                    }

                    states: [
                        //The different states the serialcom uses to display the different buttons.
                        State {
                            name: "open"
                            PropertyChanges {
                                target: open; opacity: 0
                            }
                            PropertyChanges {
                                target: open; z: 0
                            }
                            PropertyChanges {
                                target: close; opacity: 1
                            }
                            PropertyChanges {
                                target: close; z: 1
                            }
                            PropertyChanges {
                                target: sendSerialButton; opacity: 1
                            }
                            PropertyChanges {
                                target: sendSerialButton; z: 1
                            }
                            PropertyChanges {
                                target: changePortButton; opacity: 0
                            }
                            PropertyChanges {
                                target: changePortButton; z: 0
                            }
                        },
                        State {
                            name: "closed"
                            PropertyChanges {
                                target: open; opacity: 1
                            }
                            PropertyChanges {
                                target: open; z: 1
                            }
                            PropertyChanges {
                                target: close; opacity: 0
                            }
                            PropertyChanges {
                                target: close; z: 0
                            }
                            PropertyChanges {
                                target: sendSerialButton; opacity: 0
                            }
                            PropertyChanges {
                                target: sendSerialButton; z: 0
                            }
                            PropertyChanges {
                                target: changePortButton; opacity: 1
                            }
                            PropertyChanges {
                                target: changePortButton; z: 1
                            }
                        }

                    ]
                }

                states: [
                    //The different states that are used by the serialcontainer to display the buttons or list of ports.
                    State {
                        name: "setPortList"
                        PropertyChanges {
                            target: setPort; opacity: 1
                        }
                        PropertyChanges {
                            target: setPort; z: 1
                        }
                        PropertyChanges {
                            target: serialCom; z: 0
                        }
                        PropertyChanges {
                            target: serialCom; opacity: 0
                        }
                    },
                    State {
                        name: "serialCom"
                        PropertyChanges {
                            target: setPort; opacity: 0
                        }
                        PropertyChanges {
                            target: setPort; z: 0
                        }
                        PropertyChanges {
                            target: serialCom; z: 1
                        }
                        PropertyChanges {
                            target: serialCom; opacity: 1
                        }
                    }
                ]
            }
        Item {
                //This container is used when resetting all the settings of the GUI.
                id: resetContainer
                x: 10
                y: containerRight.height-150
                width: 120
                height: 40

                Button {
                    //The button that is used when resetting.
                    id: resetButton
                    x: 0
                    y: 0
                    width: resetContainer.width
                    height: resetContainer.height
                    text: qsTr("Reset")
                    onClicked: {
                        //Resets effect 1 rectangle.
                        //Sets the effect 1 to no effect.
                        effect1rec.state = "byPass"
                        menuEff1.eff1 = "byPass"
                        noEff1.checked = true
                        //Resets the delay sliders.
                        dE1.delayStart       = 3
                        dE1.gainStart        = 3
                        dE1.feedbackStart    = 3
                        dE1.delayStart       = 0
                        dE1.gainStart        = 0
                        dE1.feedbackStart    = 0
                        //Resets the equalizer.
                        eE1.bassStart        = 3
                        eE1.midrangeStart    = 3
                        eE1.trebleStart      = 3
                        eE1.bassStart        = 4
                        eE1.midrangeStart    = 4
                        eE1.trebleStart      = 4
                        //Resets the volume slider
                        vE1.sValue           = 3
                        vE1.sValue           = 0
                        //Resets effect 2 rectangle.
                        //Sets the effect 2 to no effect.
                        effect2rec.state = "byPass"
                        menuEff2.eff2 = "byPass"
                        noEff2.checked = true
                        //Resets the delay sliders.
                        dE2.delayStart       = 3
                        dE2.gainStart        = 3
                        dE2.feedbackStart    = 3
                        dE2.delayStart       = 0
                        dE2.gainStart        = 0
                        dE2.feedbackStart    = 0
                        //Resets the equalizer.
                        eE2.bassStart        = 3
                        eE2.midrangeStart    = 3
                        eE2.trebleStart      = 3
                        eE2.bassStart        = 4
                        eE2.midrangeStart    = 4
                        eE2.trebleStart      = 4
                        //Resets the volume slider
                        vE2.sValue           = 3
                        vE2.sValue           = 0
                        //Resets effect 3 rectangle.
                        //Sets the effect 3 to no effect.
                        effect3rec.state = "byPass"
                        menuEff3.eff3 = "byPass"
                        noEff3.checked = true
                        //Resets the delay sliders.
                        dE3.delayStart       = 3
                        dE3.gainStart        = 3
                        dE3.feedbackStart    = 3
                        dE3.delayStart       = 4
                        dE3.gainStart        = 4
                        dE3.feedbackStart    = 4
                        //Resets the equalizer.
                        eE3.bassStart        = 3
                        eE3.midrangeStart    = 3
                        eE3.trebleStart      = 3
                        eE3.bassStart        = 0
                        eE3.midrangeStart    = 0
                        eE3.trebleStart      = 0
                        //Resets the volume slider
                        vE3.sValue           = 3
                        vE3.sValue           = 0
                        //Resets effect 4 rectangle.
                        //Sets the effect 4 to no effect.
                        effect4rec.state = "byPass"
                        menuEff4.eff4 = "byPass"
                        noEff4.checked = true
                        //Resets the delay sliders.
                        dE4.delayStart       = 3
                        dE4.gainStart        = 3
                        dE4.feedbackStart    = 3
                        dE4.delayStart       = 0
                        dE4.gainStart        = 0
                        dE4.feedbackStart    = 0
                        //Resets the equalizer.
                        eE4.bassStart        = 3
                        eE4.midrangeStart    = 3
                        eE4.trebleStart      = 3
                        eE4.bassStart        = 4
                        eE4.midrangeStart    = 4
                        eE4.trebleStart      = 4
                        //Resets the volume slider
                        vE4.sValue           = 3
                        vE4.sValue           = 0
                    }
                }
            }
        Item {
                //This container is used when saving an preset to a file.
                id: saveContainer
                x: 10
                y: containerRight.height-100
                width: 120
                height: 80

                Button {
                    //When this button is clicked the current settings are saved to a file and added to the preset list.
                    id: saveButton
                    x: 0
                    y: 0
                    width: saveContainer.width
                    height: saveContainer.height/2
                    text: qsTr("Save")
                    onClicked: {
                        //Creates a new preset that is to be saved as an Json object.
                        var newPreset = {
                            "name": saveField.text,
                            "dsp1name": dsp1name,
                            "dsp1val1": dsp1val1,
                            "dsp1val2": dsp1val2,
                            "dsp1val3": dsp1val3,
                            "dsp2name": dsp2name,
                            "dsp2val1": dsp2val1,
                            "dsp2val2": dsp2val2,
                            "dsp2val3": dsp2val3,
                            "dsp3name": dsp3name,
                            "dsp3val1": dsp3val1,
                            "dsp3val2": dsp3val2,
                            "dsp3val3": dsp3val3,
                            "dsp4name": dsp4name,
                            "dsp4val1": dsp4val1,
                            "dsp4val2": dsp4val2,
                            "dsp4val3": dsp4val3
                        }
                        //Adds the new preset to the list.
                        presetModel.append(newPreset)
                        //Writes the new preset to the file.
                        fileH.write(newPreset)
                        saveField.text = ""
                    }
                    FileHandeler {
                        //Declare the file handler class.
                        id: fileH
                        onError: console.log("Debug"+msg)
                        //Sets the source file that the presets will be written to.
                        source: "presets.txt"
                    }
                }
                TextField {
                    //This field is used to name the preset. The preset name is the input of this textField.
                    id: saveField
                    x: 0
                    y: (saveContainer.height/2)+10
                    width: saveContainer.width
                    height: saveContainer.height/2
                    scale: 1
                    font.pointSize: 18
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: ""
                }
        }
    }
    Item {
        //This is where all the effect settings are changed in four different fields.
        id: contentContainer
        x: 0
        y: containerTop.height
        width: 1260
        height: parent.height-containerTop.height

        Rectangle {
            //This is where the first effects settings are displayed and chosen.
            id: effect1rec
            x: 0
            y: 0
            width: contentContainer.width/2
            height: contentContainer.height/2
            radius: 1
            border.width: 1
            //The effects starts as bypassed.
            state: "byPass"
            //This variable displays the current state of the effect1rec.
            property string dsp1State: effect1rec.state

            Bypass {
                //Creating the bypass area for the first effect box.
                id: bE1
                x: 1
                y: 1
                z: 1
                opacity: 0.8
            }
            NoEffect{
                //Creating the noeffect area for the first effect box.
                id: nE1
                z: 0
                opacity: 1
            }
            Equalizer{
                //Creating the equalizer area for the first effect box.
                id: eE1
                z: 0
                opacity: 0
            }
            Delay{
                //Creating the delay area for the first effect box.
                id: dE1
                z: 0
                opacity: 0
            }
            GenericGainSlider{
                //Creating the volume area for the first effect box.
                id: vE1
                x: 40
                y: 60
                z: 0
                opacity: 0
                text1: "Volume"
            }

            Item {
                //Menu for chosing the first effect if the first box is not bypassed.
                id: dsp1menu
                x: 481
                y: 1
                width: contentContainer.width/2 - 480
                height: contentContainer.height/2

                ExclusiveGroup {
                    //This is used to only be able to chose on effect.
                    id: excmenu1
                }
                RadioButton {
                    //This is used when chosing no effect for the first box.
                    id: noEff1
                    exclusiveGroup: excmenu1
                    x: 28
                    y: 8
                    text: qsTr("No Effect")
                    checked: true
                    onClicked: {
                        if(effect1rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect1rec.state = "noEffect"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing equalizer for the first box.
                    id: equal1
                    exclusiveGroup: excmenu1
                    x: 28
                    y: 31
                    text: qsTr("Equalizer")
                    onClicked: {
                        if(effect1rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect1rec.state = "equalizer"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing volume for the first box.
                    id: volume1
                    exclusiveGroup: excmenu1
                    x: 28
                    y: 54
                    text: qsTr("Volume")
                    onClicked: {
                        if(effect1rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect1rec.state = "volume"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing delay for the first box.
                    id: delay1
                    exclusiveGroup: excmenu1
                    x: 28
                    y: 77
                    text: qsTr("Delay")
                    onClicked: {
                        if(effect1rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect1rec.state = "delay"
                        }
                    }
                }
            }
            states:[
                //The different states here are used when switching between the effect settings.
                State {
                    name: "byPass"
                    PropertyChanges {
                        target: bE1; opacity: 0.8
                    }
                    PropertyChanges {
                        target: bE1; z: 1
                    }
                    PropertyChanges {
                        target: bE1; z: 0
                    }
                    PropertyChanges {
                        target: eE1; z: 0
                    }
                    PropertyChanges {
                        target: nE1; z: 0
                    }
                    PropertyChanges {
                        target: dE1; z: 0
                    }
                    PropertyChanges {
                        target: vE1; z: 0
                    }
                },
                State {
                    name: "noEffect"
                    PropertyChanges {
                        target: bE1; opacity: 0
                    }
                    PropertyChanges {
                        target: eE1; opacity: 0
                    }
                    PropertyChanges {
                        target: nE1; opacity: 1
                    }
                    PropertyChanges {
                        target: dE1; opacity: 0
                    }
                    PropertyChanges {
                        target: vE1; opacity: 0
                    }
                    PropertyChanges {
                        target: bE1; z: 0
                    }
                    PropertyChanges {
                        target: eE1; z: 0
                    }
                    PropertyChanges {
                        target: nE1; z: 1
                    }
                    PropertyChanges {
                        target: dE1; z: 0
                    }
                    PropertyChanges {
                        target: vE1; z: 0
                    }
                },
                State {
                    name: "equalizer"
                    PropertyChanges {
                        target: bE1; opacity: 0
                    }
                    PropertyChanges {
                        target: eE1; opacity: 1
                    }
                    PropertyChanges {
                        target: nE1; opacity: 0
                    }
                    PropertyChanges {
                        target: dE1; opacity: 0
                    }
                    PropertyChanges {
                        target: vE1; opacity: 0
                    }
                    PropertyChanges {
                        target: bE1; z: 0
                    }
                    PropertyChanges {
                        target: eE1; z: 1
                    }
                    PropertyChanges {
                        target: nE1; z: 0
                    }
                    PropertyChanges {
                        target: dE1; z: 0
                    }
                    PropertyChanges {
                        target: vE1; z: 0
                    }
                },
                State {
                    name: "volume"
                    PropertyChanges {
                        target: bE1; opacity: 0
                    }
                    PropertyChanges {
                        target: eE1; opacity: 0
                    }
                    PropertyChanges {
                        target: nE1; opacity: 0
                    }
                    PropertyChanges {
                        target: dE1; opacity: 0
                    }
                    PropertyChanges {
                        target: vE1; opacity: 1
                    }
                    PropertyChanges {
                        target: bE1; z: 0
                    }
                    PropertyChanges {
                        target: eE1; z: 0
                    }
                    PropertyChanges {
                        target: nE1; z: 0
                    }
                    PropertyChanges {
                        target: dE1; z: 0
                    }
                    PropertyChanges {
                        target: vE1; z: 1
                    }
                },
                State {
                    name: "delay"
                    PropertyChanges {
                        target: bE1; opacity: 0
                    }
                    PropertyChanges {
                        target: eE1; opacity: 0
                    }
                    PropertyChanges {
                        target: nE1; opacity: 0
                    }
                    PropertyChanges {
                        target: dE1; opacity: 1
                    }
                    PropertyChanges {
                        target: vE1; opacity: 0
                    }
                    PropertyChanges {
                        target: bE1; z: 0
                    }
                    PropertyChanges {
                        target: eE1; z: 0
                    }
                    PropertyChanges {
                        target: nE1; z: 0
                    }
                    PropertyChanges {
                        target: dE1; z: 1
                    }
                    PropertyChanges {
                        target: vE1; z: 0
                    }
                }
            ]
        }
        Rectangle {
            //This is where the second effects settings are displayed and chosen.
            id: effect2rec
            x: effect1rec.width
            y: 0
            width: contentContainer.width/2
            height: contentContainer.height/2
            radius: 1
            border.width: 1
            //The effects starts as bypassed.
            state: "byPass"
            //This variable displays the current state of the effect1rec.
            property string dsp2State: effect2rec.state

            Bypass {
                //Creating the bypass area for the second effect box.
                id: bE2
                x: 1
                y: 1
                z: 1
                opacity: 0.8
            }
            NoEffect{
                //Creating the no effect area for the second effect box.
                id: nE2
                z: 0
                opacity: 1
            }
            Equalizer{
                //Creating the equalizer area for the second effect box.
                id: eE2
                z: 0
                opacity: 0
            }
            Delay{
                //Creating the delay area for the second effect box.
                id: dE2
                z: 0
                opacity: 0
            }
            GenericGainSlider{
                //Creating the volume area for the second effect box.
                id: vE2
                x: 40
                y: 60
                z: 0
                opacity: 0
                text1: "Volume"
            }

            Item {
                //Menu for chosing the second effect if the second box is not bypassed.
                id: dsp2menu
                x: 481
                y: 1
                width: contentContainer.width/2 - 480
                height: contentContainer.height/2

                ExclusiveGroup {
                    //This is used to only be able to chose on effect.
                    id: excmenu2
                }
                RadioButton {
                    //This is used when chosing no effect for the second box.
                    id: noEff2
                    exclusiveGroup: excmenu2
                    x: 28
                    y: 8
                    text: qsTr("No Effect")
                    checked: true
                    onClicked: {
                        if(effect2rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect2rec.state = "noEffect"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing equalizer for the second box.
                    id: equal2
                    exclusiveGroup: excmenu2
                    x: 28
                    y: 31
                    text: qsTr("Equalizer")
                    onClicked: {
                        if(effect2rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect2rec.state = "equalizer"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing volume for the second box.
                    id: volume2
                    exclusiveGroup: excmenu2
                    x: 28
                    y: 54
                    text: qsTr("Volume")
                    onClicked: {
                        if(effect2rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect2rec.state = "volume"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing delay for the second box.
                    id: delay2
                    exclusiveGroup: excmenu2
                    x: 28
                    y: 77
                    text: qsTr("Delay")
                    onClicked: {
                        if(effect2rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect2rec.state = "delay"
                        }
                    }
                }
            }
            states:[
                //The different states here are used when switching between the effect settings.
                State {
                    name: "byPass"
                    PropertyChanges {
                        target: bE2; opacity: 0.8
                    }
                    PropertyChanges {
                        target: bE2; z: 1
                    }
                    PropertyChanges {
                        target: bE2; z: 0
                    }
                    PropertyChanges {
                        target: eE2; z: 0
                    }
                    PropertyChanges {
                        target: nE2; z: 0
                    }
                    PropertyChanges {
                        target: dE2; z: 0
                    }
                    PropertyChanges {
                        target: vE2; z: 0
                    }
                },
                State {
                    name: "noEffect"
                    PropertyChanges {
                        target: bE2; opacity: 0
                    }
                    PropertyChanges {
                        target: eE2; opacity: 0
                    }
                    PropertyChanges {
                        target: nE2; opacity: 1
                    }
                    PropertyChanges {
                        target: dE2; opacity: 0
                    }
                    PropertyChanges {
                        target: vE2; opacity: 0
                    }
                    PropertyChanges {
                        target: bE2; z: 0
                    }
                    PropertyChanges {
                        target: eE2; z: 0
                    }
                    PropertyChanges {
                        target: nE2; z: 1
                    }
                    PropertyChanges {
                        target: dE2; z: 0
                    }
                    PropertyChanges {
                        target: vE2; z: 0
                    }
                },
                State {
                    name: "equalizer"
                    PropertyChanges {
                        target: bE2; opacity: 0
                    }
                    PropertyChanges {
                        target: eE2; opacity: 1
                    }
                    PropertyChanges {
                        target: nE2; opacity: 0
                    }
                    PropertyChanges {
                        target: dE2; opacity: 0
                    }
                    PropertyChanges {
                        target: vE2; opacity: 0
                    }
                    PropertyChanges {
                        target: bE2; z: 0
                    }
                    PropertyChanges {
                        target: eE2; z: 1
                    }
                    PropertyChanges {
                        target: nE2; z: 0
                    }
                    PropertyChanges {
                        target: dE2; z: 0
                    }
                    PropertyChanges {
                        target: vE2; z: 0
                    }
                },
                State {
                    name: "volume"
                    PropertyChanges {
                        target: bE2; opacity: 0
                    }
                    PropertyChanges {
                        target: eE2; opacity: 0
                    }
                    PropertyChanges {
                        target: nE2; opacity: 0
                    }
                    PropertyChanges {
                        target: dE2; opacity: 0
                    }
                    PropertyChanges {
                        target: vE2; opacity: 1
                    }
                    PropertyChanges {
                        target: bE2; z: 0
                    }
                    PropertyChanges {
                        target: eE2; z: 0
                    }
                    PropertyChanges {
                        target: nE2; z: 0
                    }
                    PropertyChanges {
                        target: dE2; z: 0
                    }
                    PropertyChanges {
                        target: vE2; z: 1
                    }
                },
                State {
                    name: "delay"
                    PropertyChanges {
                        target: bE2; opacity: 0
                    }
                    PropertyChanges {
                        target: eE2; opacity: 0
                    }
                    PropertyChanges {
                        target: nE2; opacity: 0
                    }
                    PropertyChanges {
                        target: dE2; opacity: 1
                    }
                    PropertyChanges {
                        target: vE2; opacity: 0
                    }
                    PropertyChanges {
                        target: bE2; z: 0
                    }
                    PropertyChanges {
                        target: eE2; z: 0
                    }
                    PropertyChanges {
                        target: nE2; z: 0
                    }
                    PropertyChanges {
                        target: dE2; z: 1
                    }
                    PropertyChanges {
                        target: vE2; z: 0
                    }
                }
            ]
        }
        Rectangle {
            //This is where the third effects settings are displayed and chosen.
            id: effect3rec
            x: 0
            y: contentContainer.height/2
            width: contentContainer.width/2
            height: contentContainer.height/2
            radius: 1
            border.width: 1
            //The effects starts as bypassed.
            state: "byPass"
            //This variable displays the current state of the effect1rec.
            property string dsp3State: effect3rec.state

            Bypass {
                //Creating the bypass area for the third effect box.
                id: bE3
                x: 1
                y: 1
                z: 1
                opacity: 0.8
            }
            NoEffect{
                //Creating the no effect area for the third effect box.
                id: nE3
                z: 0
                opacity: 1
            }
            Equalizer{
                //Creating the equalizer area for the third effect box.
                id: eE3
                z: 0
                opacity: 0
            }
            Delay{
                //Creating the delay area for the third effect box.
                id: dE3
                z: 0
                opacity: 0
            }
            GenericGainSlider{
                //Creating the volume area for the third effect box.
                id: vE3
                x: 40
                y: 60
                z: 0
                opacity: 0
                text1: "Volume"
            }

            Item {
                //Menu for chosing the third effect if the third box is not bypassed.
                id: dsp3menu
                x: 481
                y: 1
                width: contentContainer.width/2 - 480
                height: contentContainer.height/2

                ExclusiveGroup {
                    //This is used to only be able to chose on effect.
                    id: excmenu3
                }
                RadioButton {
                    //This is used when chosing no effect for the third box.
                    id: noEff3
                    exclusiveGroup: excmenu3
                    x: 28
                    y: 8
                    text: qsTr("No Effect")
                    checked: true
                    onClicked: {
                        if(effect3rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect3rec.state = "noEffect"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing equalizer for the third box.
                    id: equal3
                    exclusiveGroup: excmenu3
                    x: 28
                    y: 31
                    text: qsTr("Equalizer")
                    onClicked: {
                        if(effect3rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect3rec.state = "equalizer"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing volume for the third box.
                    id: volume3
                    exclusiveGroup: excmenu3
                    x: 28
                    y: 54
                    text: qsTr("Volume")
                    onClicked: {
                        if(effect3rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect3rec.state = "volume"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing delay for the third box.
                    id: delay3
                    exclusiveGroup: excmenu3
                    x: 28
                    y: 77
                    text: qsTr("Delay")
                    onClicked: {
                        if(effect3rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect3rec.state = "delay"
                        }
                    }
                }
            }
            states:[
                //The different states here are used when switching between the effect settings.
                State {
                    name: "byPass"
                    PropertyChanges {
                        target: bE3; opacity: 0.8
                    }
                    PropertyChanges {
                        target: bE3; z: 1
                    }
                    PropertyChanges {
                        target: bE3; z: 0
                    }
                    PropertyChanges {
                        target: eE3; z: 0
                    }
                    PropertyChanges {
                        target: nE3; z: 0
                    }
                    PropertyChanges {
                        target: dE3; z: 0
                    }
                    PropertyChanges {
                        target: vE3; z: 0
                    }
                },
                State {
                    name: "noEffect"
                    PropertyChanges {
                        target: bE3; opacity: 0
                    }
                    PropertyChanges {
                        target: eE3; opacity: 0
                    }
                    PropertyChanges {
                        target: nE3; opacity: 1
                    }
                    PropertyChanges {
                        target: dE3; opacity: 0
                    }
                    PropertyChanges {
                        target: vE3; opacity: 0
                    }
                    PropertyChanges {
                        target: bE3; z: 0
                    }
                    PropertyChanges {
                        target: eE3; z: 0
                    }
                    PropertyChanges {
                        target: nE3; z: 1
                    }
                    PropertyChanges {
                        target: dE3; z: 0
                    }
                    PropertyChanges {
                        target: vE3; z: 0
                    }
                },
                State {
                    name: "equalizer"
                    PropertyChanges {
                        target: bE3; opacity: 0
                    }
                    PropertyChanges {
                        target: eE3; opacity: 1
                    }
                    PropertyChanges {
                        target: nE3; opacity: 0
                    }
                    PropertyChanges {
                        target: dE3; opacity: 0
                    }
                    PropertyChanges {
                        target: vE3; opacity: 0
                    }
                    PropertyChanges {
                        target: bE3; z: 0
                    }
                    PropertyChanges {
                        target: eE3; z: 1
                    }
                    PropertyChanges {
                        target: nE3; z: 0
                    }
                    PropertyChanges {
                        target: dE3; z: 0
                    }
                    PropertyChanges {
                        target: vE3; z: 0
                    }
                },
                State {
                    name: "volume"
                    PropertyChanges {
                        target: bE3; opacity: 0
                    }
                    PropertyChanges {
                        target: eE3; opacity: 0
                    }
                    PropertyChanges {
                        target: nE3; opacity: 0
                    }
                    PropertyChanges {
                        target: dE3; opacity: 0
                    }
                    PropertyChanges {
                        target: vE3; opacity: 1
                    }
                    PropertyChanges {
                        target: bE3; z: 0
                    }
                    PropertyChanges {
                        target: eE3; z: 0
                    }
                    PropertyChanges {
                        target: nE3; z: 0
                    }
                    PropertyChanges {
                        target: dE3; z: 0
                    }
                    PropertyChanges {
                        target: vE3; z: 1
                    }
                },
                State {
                    name: "delay"
                    PropertyChanges {
                        target: bE3; opacity: 0
                    }
                    PropertyChanges {
                        target: eE3; opacity: 0
                    }
                    PropertyChanges {
                        target: nE3; opacity: 0
                    }
                    PropertyChanges {
                        target: dE3; opacity: 1
                    }
                    PropertyChanges {
                        target: vE3; opacity: 0
                    }
                    PropertyChanges {
                        target: bE3; z: 0
                    }
                    PropertyChanges {
                        target: eE3; z: 0
                    }
                    PropertyChanges {
                        target: nE3; z: 0
                    }
                    PropertyChanges {
                        target: dE3; z: 1
                    }
                    PropertyChanges {
                        target: vE3; z: 0
                    }
                }
            ]
        }
        Rectangle {
            //This is where the forth effects settings are displayed and chosen.
            id: effect4rec
            x: contentContainer.width/2
            y: contentContainer.height/2
            width: contentContainer.width/2
            height: contentContainer.height/2
            radius: 1
            border.width: 1
            //The effects starts as bypassed.
            state: "byPass"
            //This variable displays the current state of the effect1rec.
            property string dsp4State: effect4rec.state

            Bypass {
                //Creating the bypass area for the forth effect box.
                id: bE4
                x: 1
                y: 1
                z: 1
                opacity: 0.8
            }
            NoEffect{
                //Creating the no effect area for the forth effect box.
                id: nE4
                z: 0
                opacity: 1
            }
            Equalizer{
                //Creating the equalizer area for the forth effect box.
                id: eE4
                z: 0
                opacity: 0
            }
            Delay{
                //Creating the delay area for the forth effect box.
                id: dE4
                z: 0
                opacity: 0
            }
            GenericGainSlider{
                //Creating the volume area for the forth effect box.
                id: vE4
                x: 40
                y: 60
                z: 0
                opacity: 0
                text1: "Volume"
            }

            Item {
                //Menu for chosing the forth effect if the forth box is not bypassed.
                id: dsp4menu
                x: 481
                y: 1
                width: contentContainer.width/2 - 480
                height: contentContainer.height/2

                ExclusiveGroup {
                    //This is used to only be able to chose on effect.
                    id: excmenu4
                }
                RadioButton {
                    //This is used when chosing no effect for the forth box.
                    id: noEff4
                    exclusiveGroup: excmenu4
                    x: 28
                    y: 8
                    text: qsTr("No Effect")
                    checked: true
                    onClicked: {
                        if(effect4rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect4rec.state = "noEffect"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing equalizer for the forth box.
                    id: equal4
                    exclusiveGroup: excmenu4
                    x: 28
                    y: 31
                    text: qsTr("Equalizer")
                    onClicked: {
                        if(effect4rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect4rec.state = "equalizer"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing volume for the forth box.
                    id: volume4
                    exclusiveGroup: excmenu4
                    x: 28
                    y: 54
                    text: qsTr("Volume")
                    onClicked: {
                        if(effect4rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect4rec.state = "volume"
                        }
                    }
                }
                RadioButton {
                    //This is used when chosing delay for the forth box.
                    id: delay4
                    exclusiveGroup: excmenu4
                    x: 28
                    y: 77
                    text: qsTr("Delay")
                    onClicked: {
                        if(effect4rec.state == "byPass"){
                            //No effect can be choosen.
                        }else{
                            effect4rec.state = "delay"
                        }
                    }
                }
            }
            states:[
                //The different states here are used when switching between the effect settings.
                State {
                    name: "byPass"
                    PropertyChanges {
                        target: bE4; opacity: 0.8
                    }
                    PropertyChanges {
                        target: bE4; z: 1
                    }
                    PropertyChanges {
                        target: bE4; z: 0
                    }
                    PropertyChanges {
                        target: eE4; z: 0
                    }
                    PropertyChanges {
                        target: nE4; z: 0
                    }
                    PropertyChanges {
                        target: dE4; z: 0
                    }
                    PropertyChanges {
                        target: vE4; z: 0
                    }
                },
                State {
                    name: "noEffect"
                    PropertyChanges {
                        target: bE4; opacity: 0
                    }
                    PropertyChanges {
                        target: eE4; opacity: 0
                    }
                    PropertyChanges {
                        target: nE4; opacity: 1
                    }
                    PropertyChanges {
                        target: dE4; opacity: 0
                    }
                    PropertyChanges {
                        target: vE4; opacity: 0
                    }
                    PropertyChanges {
                        target: bE4; z: 0
                    }
                    PropertyChanges {
                        target: eE4; z: 0
                    }
                    PropertyChanges {
                        target: nE4; z: 1
                    }
                    PropertyChanges {
                        target: dE4; z: 0
                    }
                    PropertyChanges {
                        target: vE4; z: 0
                    }
                },
                State {
                    name: "equalizer"
                    PropertyChanges {
                        target: bE4; opacity: 0
                    }
                    PropertyChanges {
                        target: eE4; opacity: 1
                    }
                    PropertyChanges {
                        target: nE4; opacity: 0
                    }
                    PropertyChanges {
                        target: dE4; opacity: 0
                    }
                    PropertyChanges {
                        target: vE4; opacity: 0
                    }
                    PropertyChanges {
                        target: bE4; z: 0
                    }
                    PropertyChanges {
                        target: eE4; z: 1
                    }
                    PropertyChanges {
                        target: nE4; z: 0
                    }
                    PropertyChanges {
                        target: dE4; z: 0
                    }
                    PropertyChanges {
                        target: vE4; z: 0
                    }
                },
                State {
                    name: "volume"
                    PropertyChanges {
                        target: bE4; opacity: 0
                    }
                    PropertyChanges {
                        target: eE4; opacity: 0
                    }
                    PropertyChanges {
                        target: nE4; opacity: 0
                    }
                    PropertyChanges {
                        target: dE4; opacity: 0
                    }
                    PropertyChanges {
                        target: vE4; opacity: 1
                    }
                    PropertyChanges {
                        target: bE4; z: 0
                    }
                    PropertyChanges {
                        target: eE4; z: 0
                    }
                    PropertyChanges {
                        target: nE4; z: 0
                    }
                    PropertyChanges {
                        target: dE4; z: 0
                    }
                    PropertyChanges {
                        target: vE4; z: 1
                    }
                },
                State {
                    name: "delay"
                    PropertyChanges {
                        target: bE4; opacity: 0
                    }
                    PropertyChanges {
                        target: eE4; opacity: 0
                    }
                    PropertyChanges {
                        target: nE4; opacity: 0
                    }
                    PropertyChanges {
                        target: dE4; opacity: 1
                    }
                    PropertyChanges {
                        target: vE4; opacity: 0
                    }
                    PropertyChanges {
                        target: bE4; z: 0
                    }
                    PropertyChanges {
                        target: eE4; z: 0
                    }
                    PropertyChanges {
                        target: nE4; z: 0
                    }
                    PropertyChanges {
                        target: dE4; z: 1
                    }
                    PropertyChanges {
                        target: vE4; z: 0
                    }
                }
            ]
        }
    }
    Item {
        //This window has no functionality in the current GUI, it was created to be able to display the read and sent data to the serial port.
        //It was suppose to be possible to send from here aswell, however this is not used since time did not allow to finish this.
        id: deBug
        x: 0
        y: containerTop.height
        z: 0
        opacity: 0
        width: 1400
        height: 700

        Rectangle {
            //This area was suppose to be used to send data to the serial port.
            id: inputRec
            x: 700
            y: 0
            width: 700
            height: 700
            border.width: 1

            Text {
                id: inputText
                x: 10
                y: 10
                width: 100
                height: 40

                text: qsTr("Input text:")
                font.pixelSize: 20
            }
            Rectangle {
                //This is the area where the input text is to be written.
                id: intextRec
                x: 10
                y: 50
                width: 300
                height: 40
                border.width: 1

                TextInput {
                    //This is the input text area.
                    id: textInput
                    anchors.fill: parent
                    z: 1
                    opacity: 1
                    text: "..."
                    font.pixelSize: 20
                }
            }
            Button {
                //This button is suppose to send to the serial port when clicked, but this was not implemented.
                id: sendInput
                x: 311
                y: 50
                width: 100
                height: 40
                text: qsTr("Send")
                onClicked: {
                    //This simply displays the values from the input to the debug input area.
                    inText += "GUI: " + textInput.text + "\n"
                }
            }
            Button {
                //This is used to return to the window with the effect settings.
                id: returnToGui
                x: 560
                y: 640
                width: 100
                height: 40
                z: 1
                opacity: 1
                text: qsTr("Return to GUI")
                onClicked: {
                    baseWindow.state = "gui"
                }
            }
            Button {
                //This is used to clear the debug input text.
                id: clearLog
                x: 20
                y: 640
                width: 100
                height: 40
                z: 1
                opacity: 1
                text: qsTr("Clear")
                onClicked: {
                    inText = ""
                }
            }
        }
        Rectangle{
            //This area is used to display the debug input.
            id: debugRec
            x: 0
            y: 0
            width: 700
            height: 700
            border.width: 1

            Text {
                id: debugInput
                x: 10
                y: 10
                width: 680
                height: 680
                text: inText
                font.pixelSize: 20
            }
        }
    }
    Item {
        //This is the window that is displayed when the GUI is stared.
        id: startContainer
        x: 0
        y: 0
        z: 1
        width: baseWindow.width
        height: baseWindow.height
        opacity: 0

        MouseArea {
            //Used to block the larger part of the topcontainer, the part that is not blocked is used to get to the debug window.
            x: 400
            y: 0
            z: 1
            width: 1000
            height: 100
        }

        Item {
            id: setPortS
            x: 400
            y: 400
            opacity: 1
            z: 1

            Text {
                id: serialTextS
                text: qsTr("Available ports:")
            }
            Column{
                //This is used to contain the list of available ports.
                id: portColumnS
                x: 0
                y: serialText.height
                spacing: 0
                width: setPort.width
                height: setPort.height-serialText.height-serialContainer.height

                ListView{
                    //Used to describe the list that is used to contain the available ports.
                    id: portListS
                    x: 0
                    y: 0
                    width: setPort.width
                    height: setPort.height-serialText.height-50
                    highlightFollowsCurrentItem: true
                    model: ListModel{
                        //List that is used to contain the available port info.
                        id: portlistmodelS
                    }
                    Component.onCompleted: {
                        //When the component has been created the port list is gathered from all the available ports on the computer.
                        portlistmodelS.append(serialC.getPortList())
                    }
                    delegate: Rectangle {
                        //Used to describe each of the elements of the list.
                        x: 5
                        height: 40
                        width: presetList.width
                        z: 0
                        Text {
                            //Displays the name of the port.
                            text: name
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        MouseArea {
                            //When an element of the list has been clicked.
                            anchors.fill: parent
                            onClicked: {
                                //The port with the name contained is set as the port to use.
                                //The state of the GUI is set to the main window, where the effect settings can be set.
                                serialC.setPortS(name)
                                serialContainer.state = "serialCom"
                                baseWindow.state = "gui"
                            }
                        }
                    }
                }
            }
            Button {
                //Used to renew the port list, for when a new port is connected.
                id: renewPortS
                x: 0
                y: setPort.height-50
                width: setPort.width
                height: 40

                text: qsTr("Get ports")
                onClicked: {
                    //Updates the port list.
                    portlistmodelS.clear()
                    portlistmodelS.append(serialC.getPortList())
                    //serialContainer.state = "serialCom"
                }
            }
        }
    }
    states: [
        //This are the changes that are done when switching between the GUI, Start and the debug windows.
        State {
            name: "gui"
            PropertyChanges {
                target: contentContainer; z: 1
            }
            PropertyChanges {
                target: contentContainer; opacity: 1
            }
            PropertyChanges {
                target: containerRight; z: 1
            }
            PropertyChanges {
                target: containerRight; opacity: 1
            }
            PropertyChanges {
                target: deBug; z: 0
            }
            PropertyChanges {
                target: deBug; opacity: 0
            }
            PropertyChanges {
                target: startContainer; z: 0
            }
            PropertyChanges {
                target: startContainer; opacity: 0

            }
        },
        State {
            name: "debug"
            PropertyChanges {
                target: contentContainer; z: 0
            }
            PropertyChanges {
                target: contentContainer; opacity: 0
            }
            PropertyChanges {
                target: containerRight; z: 0
            }
            PropertyChanges {
                target: containerRight; opacity: 0
            }
            PropertyChanges {
                target: deBug; z: 1
            }
            PropertyChanges {
                target: deBug; opacity: 1
            }
            PropertyChanges {
                target: startContainer; z: 0
            }
            PropertyChanges {
                target: startContainer; opacity: 0

            }

            PropertyChanges {
                target: debugInput
                wrapMode: "WrapAtWordBoundaryOrAnywhere"
            }
        },
        State {
            name: "start"
            PropertyChanges {
                target: contentContainer; z: 0
            }
            PropertyChanges {
                target: contentContainer; opacity: 0
            }
            PropertyChanges {
                target: containerRight; z: 0
            }
            PropertyChanges {
                target: containerRight; opacity: 0
            }
            PropertyChanges {
                target: deBug; z: 0
            }
            PropertyChanges {
                target: deBug; opacity: 0
            }
            PropertyChanges {
                target: containerTop; z: 0
            }
            PropertyChanges {
                target: containerTop; opacity: 0.5
            }
            PropertyChanges {
                target: startContainer; z: 1
            }
            PropertyChanges {
                target: startContainer; opacity: 1
            }
        }
    ]
}
//This code is no longer being used and might be removed.
/*
                                eE1.bassStart = presetModel.get(index).bass
                                eE1.midrangeStart = presetModel.get(index).mid
                }
            }
        }
    }
    states: [
        //This are the changes that are done when switching between the GUI, Start and the debug windows.
        State {
            name: "gui"
            PropertyChanges {
                target: contentContainer; z: 1
            }
            PropertyChanges {
                target: contentContainer; opacity: 1
            }
            PropertyChanges {
                target: containerRight; z: 1
            }
            PropertyChanges {
                target: containerRight; opacity: 1
            }
            PropertyChanges {
                target: deBug; z: 0
            }
            PropertyChanges {
                target: deBug; opacity: 0
            }
            PropertyChanges {
                target: startContainer; z: 0
            }
            PropertyChanges {
                target: startContainer; opacity: 0

            }
        },
        State {
            name: "debug"
            PropertyChanges {
                target: contentContainer; z: 0
            }
            PropertyChanges {
                target: contentContainer; opacity: 0
            }
            PropertyChanges {
                target: containerRight; z: 0
            }
            PropertyChanges {
                target: containerRight; opacity: 0
            }
            PropertyChanges {
                target: deBug; z: 1
            }
            PropertyChanges {
                target: deBug; opacity: 1
            }
            PropertyChanges {
                target: startContainer; z: 0
            }
            PropertyChanges {
                target: startContainer; opacity: 0

            }

            PropertyChanges {
                target: debugInput
                wrapMode: "WrapAtWordBoundaryOrAnywhere"
            }
        },
        State {
            name: "start"
            PropertyChanges {
                target: contentContainer; z: 0
            }
            PropertyChanges {
                target: contentContainer; opacity: 0
            }
            PropertyChanges {
                target: containerRight; z: 0
            }
            PropertyChanges {
                target: containerRight; opacity: 0
            }
            PropertyChanges {
                target: deBug; z: 0
            }
            PropertyChanges {
                target: deBug; opacity: 0
            }
            PropertyChanges {
                target: containerTop; z: 0
            }
            PropertyChanges {
                target: containerTop; opacity: 0.5
            }
            PropertyChanges {
                target: startContainer; z: 1
            }
            PropertyChanges {
                target: startContainer; opacity: 1
            }
        }
    ]
}
//This code is no longer being used and might be removed.
/*
                                eE1.bassStart = presetModel.get(index).bass
                                eE1.midrangeStart = presetModel.get(index).mid
                                eE1.trebleStart = presetModel.get(index).treble
                                volume.sValue = presetModel.get(index).gain*-1

                                if(presetModel.get(index).dsp1name == "delay"){
                                    baseWindow.tempVal = presetModel.get(index).dsp1val1
                                    menuDelay1.checked = true
                                    effect3rec.state = "Delay"
                                    d1.delayStart = tempVal / 1000
                                }else if(presetModel.get(index).dsp1name == "chorus"){
                                    menuchorus1.checked = true
                                eE1.trebleStart = presetModel.get(index).treble
                                volume.sValue = presetModel.get(index).gain*-1

                                if(presetModel.get(index).dsp1name == "delay"){
                                    baseWindow.tempVal = presetModel.get(index).dsp1val1
                                    menuDelay1.checked = true
                                    effect3rec.state = "Delay"
                                    d1.delayStart = tempVal / 1000
                                }else if(presetModel.get(index).dsp1name == "chorus"){
                                    menuchorus1.checked = true
                                    effect3rec.state = "Chorus"
                                }else{
                                    menuBase1.checked = true
                                    effect3rec.state = "NoEffect"
                                }
                                if(presetModel.get(index).dsp2name == "delay"){
                                    baseWindow.tempVal = presetModel.get(index).dsp2val1
                                    menudelay2.checked = true
                                    effect4rec.state = "Delay"
                                    d2.delayStart = tempVal / 1000
                                }else if(presetModel.get(index).dsp2name == "chorus"){
                                    menuchorus2.checked = true
                                    effect4rec.state = "Chorus"
                                }else{
                                    menuBase2.checked = true
                                    effect4rec.state = "NoEffect"
                                }

                                console.log("Index: "+index)
                                console.log("Preset: "+name+" ,bass:"+bassVal+" ,mid:"+midVal+" ,treble:"+trebleVal)
                                console.log("gain:"+gainVal)
                                console.log("Effect1:"+presetModel.get(index).dsp1name)
                                console.log("Effect2:"+presetModel.get(index).dsp2name)

                                if(presetModel.get(index).dsp1name == "delay"){
                                        console.log("Effect1val: "+delay1Val)
                                }else if(presetModel.get(index).dsp1name == "chorus"){
                                        console.log("Effect1val: "+chorus1Val)
                                    }
                                if(presetModel.get(index).dsp2name == "delay"){
                                        console.log("Effect2val: "+delay2Val)
                                }else if(presetModel.get(index).dsp2name == "chorus"){
                                        console.log("Effect2val: "+chorus2Val)
                                }
*/
