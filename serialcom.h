#ifndef SERIALCOM_H
#define SERIAlCOM_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>

class SerialCom : public QObject
{
    Q_OBJECT
public:
    explicit SerialCom(QObject *parent = 0);

signals:

public slots:

};

#endif // SERIALCOM_H
