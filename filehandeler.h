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
                   NOTIFY sourceChanged
                   DESIGNABLE true)
        explicit FileHandeler(QObject *parent = 0);

        Q_INVOKABLE QJsonArray read();
        Q_INVOKABLE bool write(const QString &name, const qint32 &value);

        QString source()
        {
            return mSource;
        }

    signals:
        void sourceChanged(const QString &source);
        void error(const QString &msg);

    public slots:
        void setSource(const QString &source)
        {
            mSource = source;
        }

    private:
        QString mSource;
};

#endif // FILEHANDELER_H
