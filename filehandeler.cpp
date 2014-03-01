#include "filehandeler.h"
#include <QFile>
#include <QTextStream>
#include <QJsonObject>

FileHandeler::FileHandeler(QObject *parent) : QObject(parent)
{

}

QString FileHandeler::read()
{
    if (mSource.isEmpty()){
        emit error("source is empty");
        return QString();
    }

    QFile file(mSource);
    QString fileContent;
    if ( file.open(QIODevice::ReadOnly) ) {
        QString line;
        QTextStream t( &file );
        do {
            line = t.readLine();
            fileContent += line;
         } while (!line.isNull());

        file.close();
    } else {
        emit error("Unable to open the file");
        return QString();
    }
    return fileContent;
}

bool FileHandeler::write(const QString &data)
{
    //Set input file
    QFile file(mSource);
    //Make it a text stream
    QTextStream out(&file);

    //check if there is a source file set and if the file is opened
    if (mSource.isEmpty() || !file.open(QFile::ReadWrite)){
        return false;
    }
    // If everything is ok then start writing to file
    else {
        //find end of file
        file.seek(file.size());
        //append new data
        out << data;
        //close and return sucessful save
        file.close();
        return true;
    }
}
