import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

import "../"

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    Component.onCompleted: {
        myDatabase.create()

        const items = myDatabase.sort()
        for (var i = 0; i < items.rows.length; ++i) {
            const item = items.rows.item(i)
            myDatabaseModel.append({id: item.id, note: item.note, date: item.date})
        }
    }

    property var db: LocalStorage.openDatabaseSync("notes", "1.0", "My notes");

    Dao {id: myDatabase}

    PageHeader {
        id: pageHeader
        objectName: "pageHeader"
        title: qsTr("Заметки")
    }

    SilicaListView {
        anchors.top: pageHeader.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10

        model: ListModel { id: myDatabaseModel }

        delegate: ListItem {
            id: delegateElement
            width: ListView.view.width

            Item {
                id: element
                width: parent.width
                height: childrenRect.height

                Label {
                    id: noteText
                    text: model.note
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }
                    wrapMode: Label.WordWrap
                    font.pixelSize: Theme.fontSizeMedium
                    color: palette.highlightColor
                    font.italic: true
                }

                Label {
                    id: noteDate
                    text: Qt.formatDateTime(model.date, "d MMMM yyyy hh:mm")
                    anchors {
                        top: noteText.bottom
                        right: parent.right
                    }
                    font.pixelSize: Theme.fontSizeSmall
                    color: palette.highlightColor
                }
            }

            menu: ContextMenu {
                id: contextMenu
                closeOnActivation : true

                MenuItem {
                    text: qsTr("Изменить")
                    onClicked: {
                        var dialog = pageStack.push("NoteDialog.qml", {note: model.note})

                        dialog.accepted.connect(function() {
                            myDatabase.update(model.id, dialog.note)

                            const items = myDatabase.find(model.id)
                            if (items.rows.length !== 0) {
                                const item = items.rows.item(0)
                                model.note = item.note
                                model.date = item.date
                            }
                        })
                    }
                }
                MenuItem {
                    text: qsTr("Удалить")
                    onClicked: {
                        myDatabase.deleteNote(model.id)
                        myDatabaseModel.remove(model.index)
                    }
                }
            }
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Добавить заметку")
                onClicked: {
                    var dialog = pageStack.push("NoteDialog.qml")

                    dialog.accepted.connect(function() {
                        const insertId = myDatabase.insertNote(dialog.note)

                        const items = myDatabase.find(insertId)
                        if (items.rows.length !== 0) {
                            const item = items.rows.item(0)
                            myDatabaseModel.append({id: item.id, note: item.note, date: item.date})
                        }
                    })
                }
            }
        }
    }
}
