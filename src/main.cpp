#include <auroraapp.h>
#include <QtQuick>

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("ru.template"));
    application->setApplicationName(QStringLiteral("NoteDemo"));

    QScopedPointer<QQuickView> view(Aurora::Application::createView());
    view->engine()->setOfflineStoragePath(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation));
    view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/NoteDemo.qml")));
    view->show();

    return application->exec();
}

/*
 * stackowerflow
 * https://stackoverflow.com/questions/37263842/how-can-qml-native-date-type-be-updated
 *
 */
