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
    Q_PROPERTY(QString inDataStringn
               READ inDataStringn
               WRITE setInDataStringn
               NOTIFY inDataStringnChanged)

    explicit SerialCom(QObject *parent = 0);

    //These send funcions will be used to send data on the serial port
    //either as a Json object or as a string.
    Q_INVOKABLE bool sendData(const QJsonObject &object);
    //This is the send function used in the QML file, since Json format is not being used.
    Q_INVOKABLE bool sendDataDe(const QString outData);
    //These functions are used to chose what port to use, to set it up and to open/close it.
    Q_INVOKABLE QJsonArray getPortList();
    Q_INVOKABLE bool setPortS(QString portS);
    Q_INVOKABLE bool openPort();
    Q_INVOKABLE bool closePort();
    //The functions below will not be used and can be removed when everything works as intended.
    /*void readData();
    Q_INVOKABLE QString readDataDe();*/

    //Used to store the data read from the serial port as either Json or a string the string cannot contain [ or ]
    //if it does it will be interpeted as a Json object.
    QJsonArray inData;
    //This variable is not bing used.
    QString inDataString;
    //Contains the information of the port, this is needed to open a port and to read write to it.
    QSerialPort* mPort;
    //This variable is used to see if a port is chosen.
    bool PortNamed;

    //The variables below might be used later.
    //bool portOpen;


    //These functions allows the values mPort and inDatan to be read into the QML file.
    QSerialPort* port()
    {
        return mPort;
    }
    QJsonArray inDatan(){
        return inData;
    }
    //This is currently not used, was ment to be used for the debug window
    QString inDataStringn(){
        return inDataString;
    }

signals:
    void error(const QString &msg);
    void portChanged(const QString &source);
    //This signal is emmited when data in JSon format is ready to be read.
    void inDatanChanged(const QString &data);
    //This signal is emmited when data in a string is ready to be read.
    void inDataStringnChanged(const QString &dataString);

public slots:
    //This function will be used to convert an int value into a 6 char string with the sign on the left.
    Q_INVOKABLE QString valToChar(int val);
    //Thse functions are not currently being used.
    void setPort(QSerialPort* &port){
        mPort = port;
    }
    void setInDatan(const QJsonArray inJson){
        inData = inJson;
    }
    void setInDataStringn(const QString inStr){
        inDataString = inStr;
    }

private slots:
    //This function will be used to read the data from the serial port when a readReady signal is emmited from the port.
    void read();
};

#endif // SERIALCOM_H
