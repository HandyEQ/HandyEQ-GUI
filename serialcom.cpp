#include "serialcom.h"
#include <QObject>
#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>

SerialCom::SerialCom(QObject *parent) : QObject(parent)
{

}

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
    /*//Creates a list of the description string of the serial port,
    //if available; otherwise returns an empty string.
    //Looks if there is content in the list.
    if(!aPorts.isEmpty()){
        qDebug() << "OMG";
        //The list is created by looping though the available ports.
        for(int i=0; i<aPorts.size(); i++){
            qDebug() << "OMG!";
            ports[i] = aPorts[i].description();
            qDebug() << "OMG!!";
        }
    }
    qDebug() << "OMG!!!";
    //Returns the description strings of the available serial ports.
    return ports;*/
}

QString SerialCom::readData(){
    qint64 s = 32;
    char *inArr = new char[s];

    QString outData;

    //Checks if the port is open.
    if(mPort->isOpen()){
        //If the mPort is opened.
        //Reads the data from the mPort to the qbitarray datain.
        mPort->read(inArr, s);
        outData.sprintf(inArr);
        qDebug() << outData;
        //Returns the read data.
        return outData;
    }else{
        //If the mPort is not opened correctly.
        //Sends an error message if the mPort could not be opened.
        emit error("Port is closed!");
        return "0";
    }

}

bool SerialCom::sendData(const QString indata){
    //Checks if the mPort is open.
    if(mPort->isOpen()){
        //If the mPort is opened.
        //Writes the data from the Qstring intdata converted into a Qbytearray.
        mPort->write(indata.toUtf8());
        qDebug() << indata;
        return true;
    }else{
        //If its not open.
        qDebug() << "Port is closed!";
        return false;
    }
}

bool SerialCom::setPortS(QString portS){
    //Looks though the list to find a port with the same name as the given string.
    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts()) {
        qDebug() << "Name : " << info.portName();
        qDebug() << "Description : " << info.description();
        qDebug() << "Manufacturer: " << info.manufacturer();
        if(info.portName() == portS){
            mPort = new QSerialPort;
            mPort->setPort(info);
            qDebug() << "Port name set";
            return true;
        }else{
           qDebug() << "Port does not exist.";
        }
    }
    return false;
}

bool SerialCom::openPort(){
    //Trys to open the mPort.
    if(mPort->open(QIODevice::ReadWrite)){
        //If the mPort is opened correctly.
        //Sets the Baudrate.
        mPort->setBaudRate(9600, QSerialPort::AllDirections);
        mPort->setFlowControl(QSerialPort::NoFlowControl);
        mPort->setParity(QSerialPort::NoParity);
        mPort->setStopBits(QSerialPort::OneStop);
        //Sets the data to 8 bits.
        mPort->setDataBits(QSerialPort::Data8);
        qDebug() << "Port open!";
        //Close the mPort.
        return true;
    }else{
        //If the mPort is not opened correctly.
        //Sends an error message if the mPort could not be opened.
        emit error("Could not open mPort.");
        //The indata was not sent.
        return false;
    }
}

bool SerialCom::closePort(){
    //Close the port.
    if(mPort->isOpen()){
        mPort->close();
        qDebug() << "Closing the port!";
        return true;
    }else{
        qDebug() << "The port is not open!";
        return false;
    }

}
