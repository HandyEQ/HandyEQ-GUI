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

        Q_INVOKABLE QJsonArray read();
        Q_INVOKABLE bool write(const QJsonObject &object);
        Q_INVOKABLE bool removeAll();

        QString source()
        {
            return mSource;
        }

    public slots:
        void setSource(const QString &source)
        {
            mSource = source;
        }

    signals:
        void sourceChanged(const QString &source);
        void error(const QString &msg);

    private:
        QString mSource;
};

#endif // FILEHANDELER_H
