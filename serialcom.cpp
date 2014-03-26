#include "serialcom.h"
#include <QObject>
#include <QSerialPort>

SerialCom::SerialCom(QObject *parent) : QObject(parent)
{

}

QList<QSerialPortInfo> SerialCom::listPorts(){
    QSerialPortInfo info;
    QList<QSerialPortInfo> ports = info.availablePorts();
    //ports.contains();
    return ports;
}

void SerialCom::recieveData(){
    port->open(QIODevice::ReadWrite);
    //port->read();
}

void SerialCom::sendData(){

    port->open(QIODevice::ReadWrite);
    port->setBaudRate(9600, QSerialPort::AllDirections);
    port->setDataBits(QSerialPort::Data8);
    port->write(intData.toUtf8());
    port->close();
}

