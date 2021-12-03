import QtQuick 2.13
//import QtQuick3D 1.15
import QtQuick.Controls 2.1

import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import QtMultimedia 5.14
import Qt.labs.platform 1.1

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
            camera.stop();
            viewfinder.visible=false;
        }
    }

    Button
    {
        id: cameraStartButton
        x: 1376
        y: 757
        text: qsTr("Start")
        onClicked: {
            camera.start();
            viewfinder.visible=true;
        }
    }



    Rectangle {
        id : cameraUI

        width: 1024 + 144 + 16
        height: 768

        color: "black"
        state: "PhotoCapture"

        Camera {
            id: camera
            captureMode: Camera.CaptureStillImage
            videoRecorder {
                 resolution: "1024x768"
                 frameRate: 30
            }
            imageCapture.onImageCaptured: {
                imageHandler.slotSetImage(preview);
            }
            Component.onCompleted: {
                camera.stop();
            }
        }
        Timer{
            id: captureTimer;
            interval: 100;
            repeat: true;
            running: (camera.cameraStatus===Camera.ActiveStatus) ? true : false;
            onTriggered: {
                if(camera.imageCapture.ready){
                    camera.imageCapture.capture();
                }

            }
        }

        VideoOutput {
            id: viewfinder
            x: 0
            y: 0
            width: parent.width - stillControls.buttonsPanelWidth
            height: parent.height
            source: camera
            autoOrientation: true
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
