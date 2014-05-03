#include "serialcom.h"
#include <QObject>
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QSerialPort>
#include <QFuture>
#include <QtConcurrent/QtConcurrent>

//This variable is used to temporary store the read Json string before it is completed.
QString inD;

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
bool SerialCom::sendDataDe(const QString send){
    //Checks if there is a port to open.
    if(PortNamed == 1){
        //Checks if the mPort is open.
        if(mPort->isOpen()){
            //If the mPort is opened.
            //Writes the data from the Qstring intdata converted into a Qbytearray.
            mPort->write(send.toUtf8());
            qDebug() << send.toUtf8();
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
            mPort->setBaudRate(9600, QSerialPort::AllDirections);
            mPort->setFlowControl(QSerialPort::NoFlowControl);
            mPort->setParity(QSerialPort::NoParity);
            mPort->setStopBits(QSerialPort::OneStop);
            //Sets the data to 8 bits.
            mPort->setDataBits(QSerialPort::Data8);
            qDebug() << "Port open!";
            //PortOpen is used to identify if the port is currently opened without using the Qserialport class.
            /*//--------------------------------------------
            //--------------------------------------------
            //Needed to use the parallel function to read.
            //--------------------------------------------
            //PortOpenCom is used to see if the port is open.
            portOpenCom = &portOpen;
            //Temporary sets the port to be open just for testing.
            *portOpenCom = true;
            //Allows the use of the serialport outside of the class.
            sCom = mPort;
            //Allows the function to change the inData in the class.
            inJArr = &inData;
            QFuture<void> future = QtConcurrent::run(readCom);
            //--------------------------------------------
            //--------------------------------------------
            //--------------------------------------------*/
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
}*/
