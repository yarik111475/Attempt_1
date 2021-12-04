import QtQuick 2.13
//import QtQuick3D 1.15
import QtQuick.Controls 2.1

import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import QtMultimedia 5.14
import Qt.labs.platform 1.1
import com.examples.camera 1.0

Page
{
    width: 1600
    height: 900

    title: qsTr("Camera page")


    Button
    {
        id: cameraStopButton
        x: 1474
        y: 757
        text: qsTr("Stop")
        onClicked: {
            cameraHandler.slotStopCapture();
            cameraItem.slotReset();
        }
    }

    Button
    {
        id: cameraStartButton
        x: 1376
        y: 757
        text: qsTr("Start")
        onClicked: {
            cameraHandler.slotStartCapture();
        }
    }



    Rectangle {
        id : cameraUI

        width: 1024 + 144 + 16
        height: 768

        color: "black"
        state: "PhotoCapture"
        Component.onCompleted: {
            cameraItem.slotReset();
        }

        CameraItem{
            id: cameraItem;
            x: 0
            y: 0
            width: parent.width - stillControls.buttonsPanelWidth
            height: parent.height
        }
        Connections{
            target: cameraHandler;
            onSignalImageCaptured:{
                cameraItem.slotSetImage(preview);
            }
        }

        PhotoCaptureControls {
            id: stillControls
            anchors.fill: parent
            camera: camera
            visible: cameraUI.state == "PhotoCapture"
            onPreviewSelected: cameraUI.state = "PhotoPreview"
            onVideoModeSelected: cameraUI.state = "VideoCapture"

        }

        VideoCaptureControls {
            id: videoControls
            anchors.fill: parent
            camera: camera
            visible: cameraUI.state == "VideoCapture"
            onPreviewSelected: cameraUI.state = "VideoPreview"
            onPhotoModeSelected: cameraUI.state = "PhotoCapture"

        }
        Rectangle {
            id : reports
            x: 270
            y: 712
            width: 500
            height: 40
            color: "black"
        }
    }
}
