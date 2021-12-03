import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQml.Models 2.1
import QtQuick.Controls 1.4

Page {
    width: 1600
    height: 900

    title: qsTr("Additional Parameters")

    Rectangle
    {
        x: 50
        y: 50
        width: 1024
        height: 768
        color: "black"
        TableView {
            anchors.fill: parent

            TableViewColumn {
                role: "Id"    // Эти роли совпадают с названиями ролей в C++ модели
                title: "Id"
            }

            TableViewColumn {
                role: "Name"    // Эти роли совпадают с названиями ролей в C++ модели
                title: "Name"
            }

            TableViewColumn {
                role: "LName"  // Эти роли совпадают с названиями ролей в C++ модели
                title: "Last_Name"
            }

            TableViewColumn {
                role: "Phone" // Эти роли совпадают с названиями ролей в C++ модели
                title: "Phone_no"
            }

            // Устанавливаем модель в TableView
            model: myModel
        }
    }

}
