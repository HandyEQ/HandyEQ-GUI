#include "serialcom.h"
#include <QObject>
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QSerialPort>
//Not currently used.
//#include <QFuture>
//#include <QtConcurrent/QtConcurrent>
//#include <stdio.h>

//This variable is used to temporary store the read Json string before it is completed.
QString inD;
//This int is used to decide if a Json is currently beeing created or not, if its set to 1 it starts with adding a [{ to the string.
//other wise it does nothing.
int JsonC = 1;
//Used to temporart store the Json format before its moved into a Jsondocument and Jsonarray.
QString tempJson;

//This function will convert from 6 chars with a sign on the left into an int value.
int charToInt(QString tempS);

//The variables below will not be used and can be removed when everything works as intended.
/*bool* portOpenCom;
int* pe;
int tem;
QJsonArray *inJArr;
QSerialPort *sCom;
void readCom();*/

//The functions below will be used.
//This function is used when creating the port and it currently connects the readReady signal with the read function.
SerialCom::SerialCom(QObject *parent) : QObject(parent)
{
    mPort = new QSerialPort;
    PortNamed = false;
    connect(mPort, SIGNAL(readyRead()), this, SLOT(read()));
}
//These send funcions will be used to send data on the serial port
//either as a Json object or as a string.
bool SerialCom::sendData(const QJsonObject &object){
    //Checks if there is a port to open.
    if(PortNamed == 1){
        //Checks if the mPort is open.
        if(mPort->isOpen()){
            //If the mPort is opened.
            //Writes the data from the Qstring intdata converted into a Qbytearray.
            //Create JSONDoc from file content
            QJsonDocument doc;
            //Create JSONArray and JSONObject
            QJsonArray arr;
            arr.append(object);
            doc.setArray(arr);
            QString outData = doc.toJson(QJsonDocument::Compact);
            qDebug() << outData;
            qDebug() << "outdata.";
            if(mPort->write(outData.toUtf8()) == outData.size())
                qDebug() << "Done sending";
            else{
                qDebug() << "outData was not sent completly.";
            }
            qDebug() << outData.toUtf8();
            return true;
        }else{
            //If its not open.
            qDebug() << "Port is closed!";
            return false;
        }
    }else{
        //No port is set.
        qDebug() << "No port is set!";
        return false;
    }
}
bool SerialCom::sendDataDe(const QString outData){
    //Checks if there is a port to open.
    if(PortNamed == 1){
        //Checks if the mPort is open.
        if(mPort->isOpen()){
            //If the mPort is opened.
            qDebug() << outData;
            qDebug() << "outdata.";
            if(mPort->write(outData.toUtf8()) == outData.size())
                qDebug() << "Done sending";
            else{
                qDebug() << "outData was not sent completly.";
            }
            qDebug() << outData.toUtf8();
            return true;
        }else{
            //If its not open.
            qDebug() << "Port is closed!";
            return false;
        }
    }else{
        //No port is set.
        qDebug() << "No port is set!";
        return false;
    }
}
//These functions are used to chose what port to use, to set it up and to open/close it.
QJsonArray SerialCom::getPortList(){
    QJsonArray serialArray;
    //Creates a list of available serial ports on the system.
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts()) {
        qDebug() << "Name : " << info.portName();
        qDebug() << "Description : " << info.description();
        qDebug() << "Manufacturer: " << info.manufacturer();
        QJsonObject obj;
        obj.insert("name", info.portName());
        serialArray.append(obj);
    }
    return serialArray;
}
bool SerialCom::setPortS(QString portS){
    //Looks though the list to find a port with the same name as the given string.
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts()) {
        qDebug() << "Name : " << info.portName();
        qDebug() << "Description : " << info.description();
        qDebug() << "Manufacturer: " << info.manufacturer();
        if(info.portName() == portS){
            mPort->setPort(info);
            //The port has now a name.
            PortNamed = 1;
            qDebug() << "Port name set";
            return true;
        }else{
           qDebug() << "Port does not exist.";
        }
    }
    return false;
}
bool SerialCom::openPort(){
    //Checks if the port has a name.
    if(PortNamed == 1){
        //Trys to open the mPort.
        if(mPort->open(QIODevice::ReadWrite)){
            //If the mPort is opened correctly.
            //Sets the Baudrate, flowcontrol, parity and the stopbit.
            mPort->setBaudRate(115200, QSerialPort::AllDirections);
            mPort->setFlowControl(QSerialPort::NoFlowControl);
            mPort->setParity(QSerialPort::NoParity);
            mPort->setStopBits(QSerialPort::OneStop);
            //Sets the data to 8 bits.
            mPort->setDataBits(QSerialPort::Data8);
            qDebug() << "Port open!";
            return true;
        }else{
            //If the mPort is not opened correctly.
            //Sends an error message if the mPort could not be opened.
            emit error("Could not open mPort.");
            //The indata was not sent.
            return false;
        }
    }else{
        qDebug() << "No port is set!";
        return false;
    }
}
bool SerialCom::closePort(){
    //Checks if the port has a name.
    if(PortNamed == 1){
        //Close the port.
        if(mPort->isOpen()){
            mPort->close();
            qDebug() << "Closing the port!";
            return true;
        }else{
            qDebug() << "The port is not open!";
            return false;
        }
    }else{
        qDebug() << "No port is set!";
        return false;
    }
}
//The function below is connected to the readReady signal and is executed everytime the signal is emmited.
//When this function is executed it is to identify if the data is sent in Json or just as a string.
void SerialCom::read(){
    qDebug() << "Read: ";
    //Used to create a QJson object.
    QJsonArray jArr;
    //Temporary int used to store values.
    int tempI;
    //Reading all that is on the serial port.
    QString t = mPort->readAll();
    //Prints the read data to the application output.
    qDebug() << t;
    //Adds the read data to the inD string for processing.
    inD += t;
    //Prints the read message to the application output.
    qDebug() << inD;
    //Looks to see if the entire message is read.
    while(inD.size() > 10){
        //If a JSonarray has been started.
        if(JsonC == 1){
            //Creates the first part of the Jsonarray.
            tempJson.append("[{");
            //Tells the QML file that the effect settings have not changed.
            //tempJson.append("\"ds1val1\": \"noChange\", \"ds1val2\": \"noChange\", \"ds1val3\": \"noChange\",");
            //Tells the QML file that the effect settings have not changed.
            //tempJson.append("\"ds2val1\": \"noChange\", \"ds2val2\": \"noChange\", \"ds2val3\": \"noChange\",");
            //Tells the QML file that the effect settings have not changed.
            //tempJson.append("\"ds3val1\": \"noChange\", \"ds3val2\": \"noChange\", \"ds3val3\": \"noChange\",");
            //Tells the QML file that the effect settings have not changed.
            //tempJson.append("\"ds4val1\": \"noChange\", \"ds4val2\": \"noChange\", \"ds4val3\": \"noChange\",");
            //A temproary string containing a Jsonarray has been started.
            JsonC = 0;
        }
        //Looks what the data received contain.
        if(inD.at(0) == 'S'){
            //If an effect box is changed.
            if(inD.at(1) == '1'){
                //If the first effect is changed.
                if(inD.at(3) == '0'){
                    //Effect bypassed.
                    tempJson.append("\"d1name\": \"byPass\"");
                }else if(inD.at(3) == '1'){
                    //Effect noEffect.
                    tempJson.append("\"d1name\": \"noEffect\"");
                }else if(inD.at(3) == '2'){
                    //Effect equalizer.
                    tempJson.append("\"d1name\": \"equalizer\"");
                }else if(inD.at(3) == '3'){
                    //Effect volume.
                    tempJson.append("\"d1name\": \"volume\"");
                }else if(inD.at(3) == '4'){
                    //Effect delay.
                    tempJson.append("\"d1name\": \"delay\"");
                }
            }else if(inD.at(1) == '2'){
                //If the second effect is changed.
                if(inD.at(3) == '0'){
                    //Effect bypassed.
                    tempJson.append("\"d2name\": \"byPass\"");
                }else if(inD.at(3) == '1'){
                    //Effect noEffect.
                    tempJson.append("\"d2name\": \"noEffect\"");
                }else if(inD.at(3) == '2'){
                    //Effect equalizer.
                    tempJson.append("\"d2name\": \"equalizer\"");
                }else if(inD.at(3) == '3'){
                    //Effect volume.
                    tempJson.append("\"d2name\": \"volume\"");
                }else if(inD.at(3) == '4'){
                    //Effect delay.
                    tempJson.append("\"d2name\": \"delay\"");
                }
            }else if(inD.at(1) == '3'){
                //If the third effect is changed.
                if(inD.at(3) == '0'){
                    //Effect bypassed.
                    tempJson.append("\"d3name\": \"byPass\"");
                }else if(inD.at(3) == '1'){
                    //Effect noEffect.
                    tempJson.append("\"d3name\": \"noEffect\"");
                }else if(inD.at(3) == '2'){
                    //Effect equalizer.
                    tempJson.append("\"d3name\": \"equalizer\"");
                }else if(inD.at(3) == '3'){
                    //Effect volume.
                    tempJson.append("\"d3name\": \"volume\"");
                }else if(inD.at(3) == '4'){
                    //Effect delay.
                    tempJson.append("\"d3name\": \"delay\"");
                }
            }else if(inD.at(1) == '4'){
                //If the fourth effect is changed.
                if(inD.at(3) == '0'){
                    //Effect bypassed.
                    tempJson.append("\"d4name\": \"byPass\"");
                }else if(inD.at(3) == '1'){
                    //Effect noEffect.
                    tempJson.append("\"d4name\": \"noEffect\"");
                }else if(inD.at(3) == '2'){
                    //Effect equalizer.
                    tempJson.append("\"d4name\": \"equalizer\"");
                }else if(inD.at(3) == '3'){
                    //Effect volume.
                    tempJson.append("\"d4name\": \"volume\"");
                }else if(inD.at(3) == '4'){
                    //Effect delay.
                    tempJson.append("\"d4name\": \"delay\"");
                }
            }
        }else if(inD.at(0) == '1'){
            //Change the settings for the first effect.
            if(inD.at(1) == 'D'){
                //Delay settings.
                if(inD.at(2) == 'D'){
                    //Delay time setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d1name\": \"delay\", \"ds1val1\": \"change\", \"dsp1val1\": " + QString::number(tempI));
                }else if(inD.at(2) == 'G'){
                    //Volume setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d1name\": \"delay\", \"ds1val2\": \"change\", \"dsp1val2\": " + QString::number(tempI));
                }else if(inD.at(2) == 'F'){
                    //Feedback setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d1name\": \"delay\", \"ds1val3\": \"change\", \"dsp1val3\": " + QString::number(tempI));
                }
            }else if(inD.at(1) == 'V'){
                //Volume settings.
                tempI = charToInt(inD.mid(4,6));
                //Here a objects are added to the Jsonarray, the dsp name does not need a number
                //to make it easier in the qml file, since its the only value of the volume.
                tempJson.append("\"d1name\": \"volume\", \"ds1val1\": \"change\", \"dsp1val1\": " + QString::number(tempI));
            }else if(inD.at(1) == 'E'){
                //Equalizer settings
                if(inD.at(2) == 'B'){
                    //Bass setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d1name\": \"equalizer\", \"ds1val1\": \"change\", \"dsp1val1\": " + QString::number(tempI));
                }else if(inD.at(2) == 'M'){
                    //Mid setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d1name\": \"equalizer\", \"ds1val2\": \"change\", \"dsp1val2\": " + QString::number(tempI));
                }else if(inD.at(2) == 'T'){
                    //Treble setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d1name\": \"equalizer\", \"ds1val3\": \"change\", \"dsp1val3\": " + QString::number(tempI));
                }
            }else{
                //Bypassed and noEffect have no settings.
                //These settings should be made with the settings box.
            }
        }else if(inD.at(0) == '2'){
            //Change the settings for the second effect.
            if(inD.at(1) == 'D'){
                //Delay settings.
                if(inD.at(2) == 'D'){
                    //Delay time setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d2name\": \"delay\", \"ds2val1\": \"change\", \"dsp2val1\": " + QString::number(tempI));
                }else if(inD.at(2) == 'G'){
                    //Gain setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d2name\": \"delay\", \"ds2val2\": \"change\", \"dsp2val2\": " + QString::number(tempI));
                }else if(inD.at(2) == 'F'){
                    //Feedback setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d2name\": \"delay\", \"ds2val3\": \"change\", \"dsp2val3\": " + QString::number(tempI));
                }
            }else if(inD.at(1) == 'V'){
                //Volume settings.
                tempI = charToInt(inD.mid(4,6));
                //Here a objects are added to the Jsonarray, the dsp name does not need a number
                //to make it easier in the qml file, since its the only value of the volume.
                tempJson.append("\"d2name\": \"volume\", \"ds2val1\": \"change\", \"dsp2val1\": " + QString::number(tempI));
            }else if(inD.at(1) == 'E'){
                //Equalizer settings
                if(inD.at(2) == 'B'){
                    //Bass setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d2name\": \"equalizer\", \"ds2val1\": \"change\", \"dsp2val1\": " + QString::number(tempI));
                }else if(inD.at(2) == 'M'){
                    //Mid setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d2name\": \"equalizer\", \"ds2val2\": \"change\", \"dsp2val2\": " + QString::number(tempI));
                }else if(inD.at(2) == 'T'){
                    //Treble setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d2name\": \"equalizer\", \"ds2val3\": \"change\", \"dsp2val3\": " + QString::number(tempI));
                }
            }else{
                //Bypassed and noEffect have no settings.
                //These settings should be made with the settings box.
            }
        }else if(inD.at(0) == '3'){
            //Change the settings for the third effect.
            if(inD.at(1) == 'D'){
                //Delay settings.
                if(inD.at(2) == 'D'){
                    //Delay time setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d3name\": \"delay\", \"ds3val1\": \"change\", \"dsp3val1\": " + QString::number(tempI));
                }else if(inD.at(2) == 'G'){
                    //Gain setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d3name\": \"delay\", \"ds3val2\": \"change\", \"dsp3val2\": " + QString::number(tempI));
                }else if(inD.at(2) == 'F'){
                    //Feedback setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d3name\": \"delay\", \"ds3val3\": \"change\", \"dsp3val3\": " + QString::number(tempI));
                }
            }else if(inD.at(1) == 'V'){
                //Volume settings.
                tempI = charToInt(inD.mid(4,6));
                //Here a objects are added to the Jsonarray, the dsp name does not need a number
                //to make it easier in the qml file, since its the only value of the volume.
                tempJson.append("\"d3name\": \"volume\", \"ds3val1\": \"change\", \"dsp3val1\": " + QString::number(tempI));
            }else if(inD.at(1) == 'E'){
                //Equalizer settings
                if(inD.at(2) == 'B'){
                    //Bass setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d3name\": \"equalizer\", \"ds3val1\": \"change\", \"dsp3val1\": " + QString::number(tempI));
                }else if(inD.at(2) == 'M'){
                    //Mid setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d3name\": \"equalizer\", \"ds3val2\": \"change\", \"dsp3val2\": " + QString::number(tempI));
                }else if(inD.at(2) == 'T'){
                    //Treble setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d3name\": \"equalizer\", \"ds3val3\": \"change\", \"dsp3val3\": " + QString::number(tempI));
                }
            }else{
                //Bypassed and noEffect have no settings.
                //These settings should be made with the settings box.
            }
        }else if(inD.at(0) == '4'){
            //Change the settings for the fourth effect.
            if(inD.at(1) == 'D'){
                //Delay settings.
                if(inD.at(2) == 'D'){
                    //Delay time setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d4name\": \"delay\", \"ds4val1\": \"change\", \"dsp4val1\": " + QString::number(tempI));
                }else if(inD.at(2) == 'G'){
                    //Gain setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d4name\": \"delay\", \"ds4val2\": \"change\", \"dsp4val2\": " + QString::number(tempI));
                }else if(inD.at(2) == 'F'){
                    //Feedback setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d4name\": \"delay\", \"ds4val3\": \"change\", \"dsp4val3\": " + QString::number(tempI));
                }
            }else if(inD.at(1) == 'V'){
                //Volume settings.
                tempI = charToInt(inD.mid(4,6));
                //Here a objects are added to the Jsonarray, the dsp name does not need a number
                //to make it easier in the qml file, since its the only value of the volume.
                tempJson.append("\"d4name\": \"volume\", \"ds4val1\": \"change\", \"dsp4val1\": " + QString::number(tempI));
            }else if(inD.at(1) == 'E'){
                //Equalizer settings
                if(inD.at(2) == 'B'){
                    //Bass setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d4name\": \"equalizer\", \"ds4val1\": \"change\", \"dsp4val1\": " + QString::number(tempI));
                }else if(inD.at(2) == 'M'){
                    //Mid setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d4name\": \"equalizer\", \"ds4val2\": \"change\", \"dsp4val2\": " + QString::number(tempI));
                }else if(inD.at(2) == 'T'){
                    //Treble setting.
                    tempI = charToInt(inD.mid(4,6));
                    //Here a objects are added to the Jsonarray, the dsp name also contains the value receiveds number
                    //to make it easier in the qml file.
                    tempJson.append("\"d4name\": \"equalizer\", \"ds4val3\": \"change\", \"dsp4val3\": " + QString::number(tempI));
                }
            }else{
                //Bypassed and noEffect have no settings.
                //These settings should be made with the settings box.
            }
        }else
        {
            //Data is in wrong format.
            tempJson.clear();
            inD.clear();
            //The Jsonarray is resetet.
            JsonC = 1;
        }
        //Is more data is available?
        if(inD.at(10) == '#'){
            //This was all the data recieved.
            tempJson .append( "}]");
            //The Jsonarray is completed.
            JsonC = 1;
            qDebug() << tempJson;
            //Creates a Json document and stores the indata there.
            QJsonDocument jDoc = QJsonDocument::fromJson(tempJson.toUtf8());
            //Clears the indata strings.
            tempJson.clear();
            inD.remove(0,11);
            //Prints the content of the Json document to the application output.
            qDebug() << "Json doc content";
            qDebug() << jDoc.toJson();
            //Converts the content of the Json document to a Jsonarray
            jArr = jDoc.array();
            //Saves the read data as a Jsonarray in the class variable inData.
            inData = jArr;
            //Emits a signal to make the QML file read the new available data.
            emit inDatanChanged("New indata is available");
            qDebug() << inData;
        }else if(inD.at(10) == ':'){
            //More data is available.
            tempJson.append(", ");
            qDebug() << tempJson;
            //Removes the first data to be able to process the later data.
            inD.remove(0, 11);
        }else
        {
            //Data is in wrong format.
            tempJson.clear();
            inD.clear();
            //The Jsonarray is resetet.
            JsonC = 1;
        }
    }
}
//This function is used in the qml file to convert from an int into 6 char string.
QString SerialCom::valToChar(int val){
    //This function will convert the value from val into a string consisting of 6 chars and the char to the left is the sign.
    QString sTemp;
    //This value is used to test the values of val.
    int temp;
    //Checks if the value is negative.
    if(val<0){
        //If the value is negative the first char is set to -.
        sTemp = '-';
        val *= -1;
    }else{
        //If the value is positive the first char is set to +.
        sTemp = '+';
    }
    //Checks to see if the value is between 90000-10000.
    temp = (val/10000)%10;
    if(temp == 9){
        //If the value is 90000.
        sTemp = sTemp + '9';
    }else if(temp == 8){
        //If the value is 80000.
        sTemp = sTemp + '8';
    }else if(temp == 7){
        //If the value is 70000.
        sTemp = sTemp + '7';
    }else if(temp == 6){
        //If the value is 60000.
        sTemp = sTemp + '6';
    }else if(temp == 5){
        //If the value is 50000.
        sTemp = sTemp + '5';
    }else if(temp == 4){
        //If the value is 40000.
        sTemp = sTemp + '4';
    }else if(temp == 3){
        //If the value is 30000.
        sTemp = sTemp + '3';
    }else if(temp == 2){
        //If the value is 20000.
        sTemp = sTemp + '2';
    }else if(temp == 1){
        //If the value is 10000.
        sTemp = sTemp + '1';
    }else{
        //If the value is less than 10000.
        sTemp = sTemp + '0';
    }
    //Checks to see if the value is between 9000-1000.
    temp = (val/1000)%10;
    if(temp == 9){
        //If the value is 9000.
        sTemp = sTemp + '9';
    }else if(temp == 8){
        //If the value is 8000.
        sTemp = sTemp + '8';
    }else if(temp == 7){
        //If the value is 7000.
        sTemp = sTemp + '7';
    }else if(temp == 6){
        //If the value is 6000.
        sTemp = sTemp + '6';
    }else if(temp == 5){
        //If the value is 5000.
        sTemp = sTemp + '5';
    }else if(temp == 4){
        //If the value is 4000.
        sTemp = sTemp + '4';
    }else if(temp == 3){
        //If the value is 3000.
        sTemp = sTemp + '3';
    }else if(temp == 2){
        //If the value is 2000.
        sTemp = sTemp + '2';
    }else if(temp == 1){
        //If the value is 1000.
        sTemp = sTemp + '1';
    }else{
        //If the value is less than 1000.
        sTemp = sTemp + '0';
    }
    //Checks to see if the value is between 900-100.
    temp = (val/100)%10;
    if(temp == 9){
        //If the value is 900.
        sTemp = sTemp + '9';
    }else if(temp == 8){
        //If the value is 800.
        sTemp = sTemp + '8';
    }else if(temp == 7){
        //If the value is 700.
        sTemp = sTemp + '7';
    }else if(temp == 6){
        //If the value is 600.
        sTemp = sTemp + '6';
    }else if(temp == 5){
        //If the value is 500.
        sTemp = sTemp + '5';
    }else if(temp == 4){
        //If the value is 400.
        sTemp = sTemp + '4';
    }else if(temp == 3){
        //If the value is 300.
        sTemp = sTemp + '3';
    }else if(temp == 2){
        //If the value is 200.
        sTemp = sTemp + '2';
    }else if(temp == 1){
        //If the value is 100.
        sTemp = sTemp + '1';
    }else{
        //If the value is less than 100.
        sTemp = sTemp + '0';
    }
    //Checks to see if the value is between 90-10.
    temp = (val/10)%10;
    if(temp == 9){
        //If the value is 90.
        sTemp = sTemp + '9';
    }else if(temp == 8){
        //If the value is 80.
        sTemp = sTemp + '8';
    }else if(temp == 7){
        //If the value is 70.
        sTemp = sTemp + '7';
    }else if(temp == 6){
        //If the value is 60.
        sTemp = sTemp + '6';
    }else if(temp == 5){
        //If the value is 50.
        sTemp = sTemp + '5';
    }else if(temp == 4){
        //If the value is 40.
        sTemp = sTemp + '4';
    }else if(temp == 3){
        //If the value is 30.
        sTemp = sTemp + '3';
    }else if(temp == 2){
        //If the value is 20.
        sTemp = sTemp + '2';
    }else if(temp == 1){
        //If the value is 10.
        sTemp = sTemp + '1';
    }else{
        //If the value is less than 10.
        sTemp = sTemp + '0';
    }
    //Checks to see if the value is between 9-1.
    temp = val%10;
    if(temp == 9){
        //If the value is 9.
        sTemp = sTemp + '9';
    }else if(temp == 8){
        //If the value is 8.
        sTemp = sTemp + '8';
    }else if(temp == 7){
        //If the value is 7.
        sTemp = sTemp + '7';
    }else if(temp == 6){
        //If the value is 6.
        sTemp = sTemp + '6';
    }else if(temp == 5){
        //If the value is 5.
        sTemp = sTemp + '5';
    }else if(temp == 4){
        //If the value is 4.
        sTemp = sTemp + '4';
    }else if(temp == 3){
        //If the value is 3.
        sTemp = sTemp + '3';
    }else if(temp == 2){
        //If the value is 2.
        sTemp = sTemp + '2';
    }else if(temp == 1){
        //If the value is 1.
        sTemp = sTemp + '1';
    }else{
        //If the value is 0.
        sTemp = sTemp + '0';
    }
    //Returns the string.
    return sTemp;
}

//This function will convert from 6 chars with a sign on the left into an int value.-11111
int charToInt(QString tempS){
    int i;
    //Converts the string into an integer.
    i = tempS.toInt();
    //Returns the converted integer.
    return i;
}

//The functions below will not be used and can be removed when everything works as intended.
/*void readCom(){
    qint64 s = 64;
    int b;
    char *inArr = new char[s];
    QJsonArray jArr;
    QString outData;
    bool r = true;
    int i = 0;
    while(*portOpenCom){
        //Checks if the port is open.
        if(sCom->isOpen()){
            qDebug() <<"-----------------------------------testmore";
            //If the mPort is opened.
            //Looks if the data is ready to be read. readable and then
            //use bytesAvailable() to find out how many bytes that are available on the port.
            //Could possible use isReadable to see if its
            //if(sCom->waitForReadyRead(10000)){
                //Reads the data one char at a time untill the null bit is found.
                //b = sCom->bytesAvailable();
                i = 0;
                r = true;
                qDebug() << "------------------------------test";

                while(b){
                    //Saves the read char in to the in array.
                    //getChar() can not read /0.
                    sCom->getChar(&inArr[i]);
                    //Prints the read char to the application output.
                    qDebug() << &inArr[i];
                    //The available bits.
                    b--;
                    //i is used to decide what place in the array that the read char is saved.
                    i++;
                }
                qDebug() << sCom->readAll();
                while(r){
                    //Saves the read char in to the in array.
                    //getChar() can not read /0.
                    sCom->getChar(&inArr[i]);
                    //Prints the read char to the application output.
                    qDebug() << &inArr[i];
                    if(sCom->atEnd()){
                        //If there is no more data currently available for reading.
                        r = false;
                    }else{
                        //If more data is available.
                        i++;
                    }
                }
                //Convert from a array into a Qstring.
                outData.sprintf(inArr);
                qDebug() << "Reading serial:";
                qDebug() << outData;
                QJsonDocument jDoc = QJsonDocument::fromJson(outData.toUtf8());
                qDebug() << "Json doc content";
                qDebug() << jDoc.toJson(QJsonDocument::Indented);
                //Stores the read data into the inData variable in the serialCom class.
                *inJArr = jDoc.array();
                //The inData value is read from the QML file with a cerain interval.
            //}
        }
    }
}
QString SerialCom::readDataDe(){
    qint64 se = 64;
    char *inArrDe = new char[se];
    QString outDataDe;
    if(PortNamed == 1){
        //Checks if the port is open.
        if(mPort->isOpen()){
            //If the mPort is opened.
            //Reads the data from the mPort to the qbitarray datain.
            mPort->read(inArrDe, se);
            outDataDe.sprintf(inArrDe);
            qDebug() << "Reading serial:";
            qDebug() << outDataDe;
            //Returns the read data.
            return outDataDe;
        }else{
            //If the mPort is not opened correctly.
            //Sends an error message if the mPort could not be opened.
            emit error("Port is closed!");
            return "0";
        }
    }else{
        qDebug() << "No port is set!";
        return "0";
    }
}
void SerialCom::readData(){
    qint64 s = 64;
    char *inArr = new char[s];
    QJsonArray jArr;
    QString outData;
    bool r = true;
    int i = 0;
    qDebug() << "------------------------------test";
    while(portOpen){
        qDebug() <<"Help!";
        if(PortNamed == 1){
            //Checks if the port is open.
            qDebug() <<"More help!";
            if(mPort->isOpen()){
                //If the mPort is opened.
                //Waits for the data to be ready to be read.
                while(!mPort->waitForReadyRead(1))

                //Reads the data one char at a time untill the null bit is found.
                while(r){
                    mPort->getChar(&inArr[i]);
                    if(inArr[i]=='\0'){
                        r = false;
                    }else{
                        i++;
                    }
                }
                outData.sprintf(inArr);
                qDebug() << "Reading serial:";
                qDebug() << outData;
                QJsonDocument jDoc = QJsonDocument::fromJson(outData.toUtf8());
                qDebug() << "Json doc content";
                qDebug() << jDoc.toJson();
                jArr = jDoc.array();
                //Returns the read data.
                inData = jArr;
                //emit dataR("New data is available!");

            }else{
                //If the mPort is not opened correctly.
                qDebug() << "No port is open!";
                //Sends an error message if the mPort could not be opened.
                emit error("Port is closed!");
            }
        }else{
            qDebug() << "No port is set!";
            //Sends an error message if the mPort could not be opened.
            emit error("No port is set!");
        }
    }
}
void SerialCom::read(){
    qDebug() << "Read: ";
    QJsonArray jArr;
    QString t = mPort->readAll();
    qDebug() << t;

    inD += t;
    qDebug() << inD;
    //Looks if the read data is in Json format.
    if(inD.at(0) == '['){
        //If the data is in Json format
        qDebug() << "Json format";
        //Looks if the Json object is fully read.
        if(inD.endsWith(']')){
            qDebug() << "Json read!";
            //Creates a Json document and stores the indata there.
            QJsonDocument jDoc = QJsonDocument::fromJson(inD.toUtf8());
            //Clears the indata string.
            inD.clear();
            //Prints the content of the Json document to the application output.
            qDebug() << "Json doc content";
            qDebug() << jDoc.toJson();
            //Converts the content of the Json document to a Jsonarray
            jArr = jDoc.array();
            //Saves the read data as a Jsonarray in the class variable inData.
            inData = jArr;
            //Emits a signal to make the QML file read the new available data.
            emit inDatanChanged("New indata is available");
            qDebug() << inData;



        }
    }else{
        //The data is not in Json format
        //The data is saved into the string variable in the class.
        inDataString = inD;
        //Clears the indata string.
        inD.clear();
        //Emits a signal to make the QML file read the new avaiable data.
        emit inDataStringnChanged("New indata is available");
    }
}*/
