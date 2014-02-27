#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include <QtQml>
#include "my_fileio.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;
    qmlRegisterType<my_fileio, 1>("my_fileio", 1, 0, "my_fileio");
    viewer.setMainQmlFile(QStringLiteral("qml/HandyEQ/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
