# Add more folders to ship with the application, here
folder_01.source = qml/HandyEQ
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =
    QT += serialport

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    filehandeler.cpp \
    serialcom.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/HandyEQ/GenericSlider.qml \
    qml/HandyEQ/GenericGainSlider.qml \
    qml/HandyEQ/Delay.qml \
    qml/HandyEQ/Chorus.qml \
    qml/HandyEQ/GenericHorizontalSlider.qml \
    qml/HandyEQ/NoEffect.qml \
    qml/HandyEQ/Equalizer.qml \
    qml/HandyEQ/SerialCom.qml \
    qml/HandyEQ/Timern.qml

HEADERS += \
    serialcom.h \
    filehandeler.h
