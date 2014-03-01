#include "my_fileio.h"
#include <QFile>
#include <QTextStream>

My_fileio::My_fileio(QObject *parent) :
    QObject(parent)
{
}

QString My_fileio::read()
{
    if(mfileS.isEmpty()){
        emit error("The file is empty!");
        return QString();
    }
    QFile file(mfileS);
    QString fileContent;
    if ( file.open(QIODevice::ReadOnly) ) {
        QString line;
        QTextStream t( &file);
        do {
            line = t.readLine();
            fileContent += line;
        } while (!line.isNull());
    } else {
        emit error("Not possible to read!");
        return QString();
    }
    return fileContent;
}

bool My_fileio::write(const QString& data)
{
    if (mfileS.isEmpty())
        return false;

    QFile file(mfileS);
    if (!file.open(QFile::WriteOnly | QFile::Truncate))
        return false;

    QTextStream out(&file);
    out << data;

    file.close();

    return true;
}
