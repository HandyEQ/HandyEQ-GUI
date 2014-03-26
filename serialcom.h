#ifndef SERIALCOM_H
#define SERIALCOM_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>

class Serialcom : public QObject
{
    Q_OBJECT
public:
    explicit Serialcom(QObject *parent = 0);
public slots:
signals:
private:
};

#endif // SERIALCOM_H
