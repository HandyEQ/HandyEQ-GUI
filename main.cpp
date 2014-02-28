#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

//Main function
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    viewer.setMainQmlFile(QStringLiteral("qml/HandyEQ/main.qml"));
    viewer.showExpanded();
    //Content here

    //Last line in main is always return
    return app.exec();
}
