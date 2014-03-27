#include "serialcom.h"
#include <QObject>
#include <QDebug>

SerialCom::SerialCom(QObject *parent) : QObject(parent)
{

}

QList<QString> SerialCom::getPortList(){
   /* QSerialPortInfo info;
    //Creates a list of available serial ports on the system.
    QList<QSerialPortInfo> aPorts = info.availablePorts();
    QList<QString> ports;*/

    foreach (const QSerialPortInfo &info, QSerialPortInfo::availablePorts()) {
       qDebug() << "Name : " << info.portName();
       qDebug() << "Description : " << info.description();
       qDebug() << "Manufacturer: " << info.manufacturer();
    }

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

    QByteArray datain;
    QString outData;
    //Trys to opens the mPort.
    if(mPort->open(QIODevice::ReadWrite)){
        //If the mPort is opened correctly.
        //Sets the Baudrate to 9600.
        mPort->setBaudRate(9600, QSerialPort::AllDirections);
        //Sets the data to 8 bits.
        mPort->setDataBits(QSerialPort::Data8);
        //Reads the data from the mPort to the qbitarray datain.
        datain = mPort->readAll();
        //Converts from a Qbytearray to a qstring and saves it into the outData variable.
        outData = QString::fromUtf8(datain);
    }else{
        //If the mPort is not opened correctly.
        //Sends an error message if the mPort could not be opened.
        emit error("Could not open mPort.");
        return "0";
    }
    //Close the mPort.
    mPort->close();
    //Returns the read data.
    return outData;
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
        mPort->write(indata.toUtf8());
    }else{
        //If the mPort is not opened correctly.
        //Sends an error message if the mPort could not be opened.
        emit error("Could not open mPort.");
        //The indata was not sent.
        return false;
    }
    //Close the mPort.
    mPort->close();
    //The indata was successfully sent.
    return true;
}

