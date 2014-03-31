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
    QString outData;
    //Trys to opens the mPort.

    if(mPort->open(QIODevice::ReadWrite)){
        //If the mPort is opened correctly.
        //Sets the Baudrate to 9600.
        mPort->setBaudRate(9600, QSerialPort::AllDirections);
        //Sets the data to 8 bits.
        mPort->setDataBits(QSerialPort::Data8);
        //Reads the data from the mPort to the qbitarray datain.
        outData = mPort->readAll();
        qDebug() << outData;
        //Close the mPort.
        mPort->close();
        //Returns the read data.
        return outData;
    }else{
        //If the mPort is not opened correctly.
        //Sends an error message if the mPort could not be opened.
        emit error("Could not open mPort.");
        return "0";
    }

}

bool SerialCom::sendData(const QString indata){

    //Trys to open the mPort.
    if(mPort->open(QIODevice::ReadWrite)){
        //If the mPort is opened correctly.
        //Sets the Baudrate to 9600.
        mPort->setBaudRate(9600, QSerialPort::AllDirections);
        //Sets the data to 8 bits.
        mPort->setDataBits(QSerialPort::Data8);
        //Writes the data from the Qstring intdata converted into a Qbytearray.
        qDebug() << indata;
        mPort->write(indata.toUtf8());
        //Close the mPort.
        mPort->close();
        //The indata was successfully sent.
        return true;
    }else{
        //If the mPort is not opened correctly.
        //Sends an error message if the mPort could not be opened.
        emit error("Could not open mPort.");
        //The indata was not sent.
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
            qDebug() << "Port found";
            return true;
        }else{
           qDebug() << "Port does not exist.";
        }
    }
    return false;
}
