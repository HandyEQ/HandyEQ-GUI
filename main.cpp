#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QtQml>
#include "filehandeler.h"
#include "serial.h"
#include <QtQuick>

//Main function
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;
    qmlRegisterType<FileHandeler>("HandyEQ",1,0,"FileHandeler");
    qmlRegisterType<Serial>("HandyEQ",1,0,"Serial");
    viewer.setMainQmlFile(QStringLiteral("qml/HandyEQ/main.qml"));
    viewer.showExpanded();
    return app.exec();
}
