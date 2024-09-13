TARGET = ru.template.NoteDemo

CONFIG += \
    auroraapp

PKGCONFIG += \

SOURCES += \
    src/main.cpp \

HEADERS += \

DISTFILES += \
    qml/Dao.qml \
    rpm/ru.template.NoteDemo.spec \

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172

CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/ru.template.NoteDemo.ts \
    translations/ru.template.NoteDemo-ru.ts \
