#ifndef MY_FILEIO_H
#define MY_FILEIO_H
#include <QObject>

class My_fileio : public QObject
{
    Q_OBJECT

public:
    Q_PROPERTY(QString fileS
               READ fileS
               WRITE setFileS
               NOTIFY fileSChanged)
    explicit My_fileio(QObject *parent = 0);

    Q_INVOKABLE QString read();
    Q_INVOKABLE bool write(const QString& data);

    QString fileS(){
        return mfileS;
    };

public slots:
    void setFileS(const QString& fileS){
        mfileS = fileS;
    };

signals:
    void fileSChanged(const QString& fileS);
    void error(const QString& msg);

private:
    QString mfileS;
};

#endif // MY_FILEIO_H
