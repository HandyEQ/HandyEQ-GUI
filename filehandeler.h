#ifndef FILEHANDELER_H
#define FILEHANDELER_H

#include <QObject>
#include <QFile>
#include <QJsonArray>

class FileHandeler : public QObject
{
    Q_OBJECT

    public:
        Q_PROPERTY(QString source
                   READ source
                   WRITE setSource
                   NOTIFY sourceChanged)
        explicit FileHandeler(QObject *parent = 0);

        //These functions are used to read, write and remove objects from the set source file.
        Q_INVOKABLE QJsonArray read();
        Q_INVOKABLE bool write(const QJsonObject &object);
        Q_INVOKABLE bool remove(int r);
        //This function returns the source.
        QString source()
        {
            return mSource;
        }

    public slots:
        //This function sets the source.
        void setSource(const QString &source)
        {
            mSource = source;
        }

    signals:
        //This signal is not used.
        void sourceChanged(const QString &source);
        //This signal is generated when an error occurs.
        void error(const QString &msg);

    private:
        QString mSource;
};

#endif // FILEHANDELER_H
