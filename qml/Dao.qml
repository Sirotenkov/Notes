import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Sailfish.Silica 1.0

QtObject {
    id: root
    property var db: LocalStorage.openDatabaseSync("notes", "1.0", "My notes")

    function create() {
        db.transaction(function(tx) {
//            tx.executeSql("DROP TABLE notes")
            tx.executeSql("CREATE TABLE IF NOT EXISTS notes (
                id INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT,
                date DATETIME)")
        })
    }

    // INFO: вставка заметки
    function insertNote(note, date) {
        console.log("MyDatabase", "note", note)
        const result
        db.transaction(function(tx) {
            result = tx.executeSql("INSERT INTO notes (note, date) VALUES (?, ?)", [note, new Date()])
        })
        return result.insertId
    }

    // INFO: поиск заметки по id
    function find(id) {
        const result
        db.transaction(function(tx) {
            result = tx.executeSql("SELECT * FROM notes WHERE id = ?", [id])
        })
        return result
    }

    // INFO: сортировка заметок по дате и времени
    function sort() {
        const result
        db.transaction(function(tx) {
            result = tx.executeSql("SELECT * FROM notes ORDER BY date DESC")
        })
        return result
    }

    // INFO: изменение конкретной заметки по id
    function update(id, note, date) {
        db.transaction(function(tx) {
            tx.executeSql("UPDATE notes SET note = ?, date = ? WHERE id = ?", [note, new Date(), id])
        })
    }

    // INFO: удаление конкретной заметки (по id)
    function deleteNote(id) {
        db.transaction(function(tx) {
            tx.executeSql("DELETE FROM notes WHERE id = ?", [id])
        })
    }
}
