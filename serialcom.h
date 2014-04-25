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
    Q_PROPERTY(QJsonArray inDatan
               READ inDatan
               WRITE setInDatan
               NOTIFY inDatanChanged)
    explicit SerialCom(QObject *parent = 0);

    Q_INVOKABLE bool sendData(const QJsonObject &object);
    void readData();
    Q_INVOKABLE bool sendDataDe(const QString send);
    Q_INVOKABLE QString readDataDe();
    Q_INVOKABLE QJsonArray getPortList();
    Q_INVOKABLE bool setPortS(QString portS);
    Q_INVOKABLE bool openPort();
    Q_INVOKABLE bool closePort();

    QJsonArray inData;
    bool portOpen;
    QSerialPort* mPort;
    int PortNamed;

    QSerialPort* port()
    {
        return mPort;
    }

    QJsonArray inDatan(){
        return inData;
    }

signals:
    void error(const QString &msg);
    void dataR(const QString &dataR);
    void portChanged(const QString &source);
    void inDatanChanged(const QString &data);
public slots:
    void setPort(QSerialPort* &port){
        mPort = port;
    }
    void setInDatan(const QJsonArray in){
        inData = in;
    }
};

#endif // SERIALCOM_H
