#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QtQml>
#include "filehandeler.h"
#include "serialcom.h"
#include <QtQuick>
#include <QFuture>
#include <QtConcurrent/QtConcurrent>
#include <QDebug>

/*SerialCom *serial;
QObject *object;
void readCom();
*/

//Main function
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;

    qmlRegisterType<FileHandeler>("HandyEQ",1,0,"FileHandeler");
    qmlRegisterType<SerialCom>("HandyEQ",1,0,"SerialCom");

    viewer.setMainQmlFile(QStringLiteral("qml/HandyEQ/main.qml"));
    viewer.showExpanded();
    /*QQuickView view;
    view.setSource(QUrl::fromLocalFile("main.qml"));
    object = view.rootObject();
    QFuture<void> future = QtConcurrent::run(readCom);
    */
    int temp = app.exec();

    return temp;
}

/*void readCom(){
    while(true){
        serial = object->findChild<SerialCom*>("serialC");
        qDebug() << &serial;
        qDebug() << serial->hej;
        if(serial->portOpen)
        {
            serial->readData();
        }
        qDebug() <<"hej";
    }
}*/
