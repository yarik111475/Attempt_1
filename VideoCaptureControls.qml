import QtQuick 2.0
import QtMultimedia 5.4

FocusScope {
    property Camera camera
    property bool previewAvailable : false

    signal previewSelected
    signal photoModeSelected
    id : captureControls
}
