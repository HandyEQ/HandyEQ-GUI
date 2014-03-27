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
    //Datain will be used for the data that is to be sent.
    Q_PROPERTY(QString datain
               READ datain
               WRITE setDatain
               NOTIFY datainChanged)
    //Dataout will be used for the data the is to be recieved.
    Q_PROPERTY(QString dataout
               READ dataout
               WRITE setDataout
               NOTIFY dataoutChanged)
    //
    /*Q_PROPERTY(QList<QSerialPortInfo> list
               READ list
               WRITE setList
               NOTIFY listChanged)*/
    explicit SerialCom(QObject *parent = 0);

    Q_INVOKABLE void sendDatain();
    Q_INVOKABLE void recieveDataout();

    QString datain(){
        return intData;
    }
    QString dataout(){
        return outData;
    }

   /* QList<QSerialPortInfo> list(){
        return portList;
    }*/

signals:
    void datainChanged(const QString &datain);
    void dataoutChanged(const QString &dataout);
    void error(const QString &msg);

public slots:
    void setDatain(QString inpData){
        intData = inpData;
    }

    void setDataout(QString outpData){
        outData = outpData;
    }

    void setPort(QSerialPort* newPort){
        port = newPort;
    }

private:
    QString intData;
    QString outData;
    QSerialPort* port;
  //  QList<QSerialPortInfo> portList;
};

#endif // SERIALCOM_H
