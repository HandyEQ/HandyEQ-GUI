#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QtQml>
#include "filehandeler.h"

//Main function
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;
    qmlRegisterType<FileHandeler>("HandyEQ",1,0,"FileHandeler");
    viewer.setMainQmlFile(QStringLiteral("qml/HandyEQ/main.qml"));
    viewer.showExpanded();
    return app.exec();
}
