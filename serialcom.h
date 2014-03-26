#ifndef SERIALCOM_H
#define SERIAlCOM_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QList>

class SerialCom : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(QString data
               READ data
               WRITE setData
               NOTIFY dataChanged)
    explicit SerialCom(QObject *parent = 0);

    Q_INVOKABLE void sendData();
    Q_INVOKABLE void recieveData();
    Q_INVOKABLE QList<QSerialPortInfo> listPorts();

    QString data(){
        return intData;
    }

signals:
    void dataChanged(const QString &data);

public slots:
    void setData(QString inpData){
        intData = inpData;
    }
    void setPort(QSerialPort* newPort){
        port = newPort;
    }

private:
    QString intData;
    QString outData;
    QSerialPort* port;
};

#endif // SERIALCOM_H
