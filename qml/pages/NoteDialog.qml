import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: root

    property alias note: noteArea.text

    DialogHeader {
        acceptText: qsTr("Сохранить")
        cancelText: qsTr("Отменить")
    }
    TextArea {
        id: noteArea
        anchors.centerIn: parent
        placeholderText: qsTr("Заметка")
        label: qsTr("Заметка")
    }
}
