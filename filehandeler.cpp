#include "filehandeler.h"
#include <QObject>
#include <QFile>
#include <QTextStream>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>

FileHandeler::FileHandeler(QObject *parent) : QObject(parent)
{

}

QJsonArray FileHandeler::read()
{
    QFile file(mSource);
    if (mSource.isEmpty()){
        emit error("source is empty");
        return QJsonArray();
    }
    if ( file.open(QFile::ReadOnly | QIODevice::Text) ) {
        //Read file
        QString data = file.readAll();
        //Create JSONDoc from file content
        QJsonDocument doc = QJsonDocument::fromJson(data.toUtf8());
        qDebug() << "Reading file";
        qDebug() << data;
        qDebug() << "JSON Doc content";
        qDebug() << doc.toJson();
        file.close();
        //Create JSONArray
        QJsonArray arr;
        //set JSONArray to content of JSONDoc
        arr = doc.array();
        return arr;
    } else {
        emit error("Unable to open the file");
        return QJsonArray();
    }
}

bool FileHandeler::write(const QJsonObject &object)
{
    //Set input file
    QFile file(mSource);

    //check if there is a source file set and if the file is opened
    if (mSource.isEmpty() || !file.open(QFile::ReadWrite | QIODevice::Text)){
        return false;
    }
    // If everything is ok then start writing to file
    else {
        //Create JSONDoc from file content
        QString input = file.readAll();
        qDebug() << input;
        //Read file
        //Create JSONDoc from file content
        QJsonDocument doc = QJsonDocument::fromJson(input.toUtf8());
        //Create JSONArray and JSONObject
        QJsonArray arr = doc.array();
        //QJsonObject obj;
        //set JSONArray to content of JSONDoc
        qDebug() << "Reading file";
        qDebug() << arr.size();
        //input values into JSONObject
        //obj.insert("name",name);
        //obj.insert("delay",value);
        //Append JSONObject to end of JSONArray
        arr.append(object);
        //Set JSONArray to content of JSONDoc
        doc.setArray(arr);
        //Write data to doc
        QString output = doc.toJson();
        qDebug() << "Output to file";
        qDebug() << output;
        file.seek(0);
        file.write(output.toUtf8());
        file.resize(file.pos());
        //close and return sucessful save
        file.close();
        return true;
    }
}

bool FileHandeler::removeAll()
{
    return false;
}
