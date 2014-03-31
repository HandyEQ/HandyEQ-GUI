#ifndef SERIALCOM_H
#define SERIAlCOM_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QList>
#include <QJsonArray>


class SerialCom : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(QSerialPort* port
               READ port
               WRITE setPort
               NOTIFY portChanged)
    explicit SerialCom(QObject *parent = 0);

    Q_INVOKABLE bool sendData(const QString indata);
    Q_INVOKABLE QString readData();
    Q_INVOKABLE QJsonArray getPortList();
    Q_INVOKABLE bool setPortS(QString portS);

    QSerialPort* port()
    {
        return mPort;
    }

signals:
    void portChanged(const QString &datain);
    void error(const QString &msg);

public slots:
    void setPort(QSerialPort* &port){

        mPort = port;
    }

private:
    QSerialPort* mPort;
};

#endif // SERIALCOM_H
