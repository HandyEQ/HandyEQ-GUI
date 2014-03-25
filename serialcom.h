#ifndef SERIALCOM_H
#define SERIAlCOM_H

#include <QObject>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>

class SerialCom : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(const char* data READ data WRITE setData NOTIFY dataChanged)
    explicit SerialCom(QObject *parent = 0);

    Q_INVOKABLE void sendData(const char * intData);

    const char* data(){
        return intData;
    }

signals:
    void dataChanged(){

    }


public slots:
    void setData(const char* inpData){
        intData = inpData;
    }

private:
    const char* intData;
};

#endif // SERIALCOM_H
