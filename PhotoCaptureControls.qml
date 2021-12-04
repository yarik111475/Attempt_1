import QtQuick 2.0
import QtMultimedia 5.4

FocusScope {
    property Camera camera
    property bool previewAvailable : false

    property int buttonsPanelWidth: buttonPaneShadow.width

    signal previewSelected
    signal videoModeSelected
    id : captureControls

    Rectangle {
        id: buttonPaneShadow
        width: bottomColumn.width + 16
        height: parent.height
        anchors.top: parent.top
        anchors.right: parent.right
        color: Qt.rgba(0.08, 0.08, 0.08, 1)

        Column {
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: 8
            }

            id: bottomColumn
            spacing: 8

            CameraListButton {
                model: QtMultimedia.availableCameras
                onValueChanged: captureControls.camera.deviceId = value
            }

            CameraButton {
                id: quitButton
                text: "Quit"
                onClicked: Qt.quit()
            }
        }
    }


    ZoomControl {
        x : 0
        y : 0
        width : 100
        height: parent.height
    }
}
