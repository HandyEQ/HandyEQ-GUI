#include "serialcom.h"
#include <QObject>
#include <QtSerialPort>

SerialCom::SerialCom(QObject *parent) : QObject(parent)
{

}

SerialCom::sendData(const char *intData){
    QSerialPort port;
    QSerialPortInfo info;
    QList ports = info.availablePorts();
    ports.contains();
    port.Baud9600;
    port.Data8;
    port.setPort();
    port.write(intData,8);
    port.close();
}
