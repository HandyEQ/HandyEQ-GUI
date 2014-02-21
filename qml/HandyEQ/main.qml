import QtQuick 2.0

Rectangle {
    id: baseWindow
    width: 800
    height: 500

    Item {
        id: containerTop
        x: 0
        y: 0
        width: parent.width
        height: 100
    }

    Item {
        id: containerRight
        x: 0
        y: containerTop.height
        width: 140
        height: 400

        Item {
            id: menuContainer
            x: 0
            y: 0
            width: parent.width
            height: parent.height-logoContainer.height
        }

        Item {
            id: logoContainer
            x: 0
            y: menuContainer.height
            width: parent.width
            height: 140
        }
    }

    Item {
        id: containerLeft
        x: parent.width-containerLeft.width
        y: containerTop.height
        width: 140
        height: parent.height-containerTop.height
    }

    Item {
        id: contentContainer
        x: containerRight.width
        y: containerTop.height
        width: parent.width-containerLeft.width-containerLeft.width
        height: parent.height-containerTop.height
    }

}
