#include "serialcom.h"
#include <QObject>
#include <QSerialPort>

SerialCom::SerialCom(QObject *parent) : QObject(parent)
{

}

/*QList<QSerialPortInfo> SerialCom::listPorts(){
    QSerialPortInfo info;
    QList<QSerialPortInfo> ports = info.availablePorts();
    //ports.contains();
    return ports;
}*/

void SerialCom::recieveDataout(){

    QByteArray datain;
    //Trys to opens the port.
    if(port->open(QIODevice::ReadWrite)){
        //If the port is opened correctly.
        //Sets the Baudrate to 9600.
        port->setBaudRate(9600, QSerialPort::AllDirections);
        //Sets the data to 8 bits.
        port->setDataBits(QSerialPort::Data8);
        //Reads the data from the port to the qbitarray datain.
        datain = port->readAll();
        //Converts from a Qbytearray to a qstring and saves it into the outData variable.
        outData = QString::fromUtf8(datain);
    }else{
        //If the port is not opened correctly.
        //Sends an error message if the port could not be opened.
        emit error("Could not open port.");
    }
    //Close the port.
    port->close();
}

void SerialCom::sendDatain(){

    //Trys to open the port.
    if(port->open(QIODevice::ReadWrite)){
        //If the port is opened correctly.
        //Sets the Baudrate to 9600.
        port->setBaudRate(9600, QSerialPort::AllDirections);
        //Sets the data to 8 bits.
        port->setDataBits(QSerialPort::Data8);
        //Writes the data from the Qstring intData converted into a Qbytearray.
        port->write(intData.toUtf8());
    }else{
        //If the port is not opened correctly.
        //Sends an error message if the port could not be opened.
        emit error("Could not open port.");
    }
    //Close the port.
    port->close();
}

