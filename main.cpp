#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QVideoFilterRunnable>
#include <QQmlContext>
#include "cameraitem.h"
#include "camerahandler.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<CameraItem>("com.examples.camera",1,0,"CameraItem");

    //************************
    //create QQmlContext object,
    //create CameraHandler object
    //and set property named 'cameraHandler' into QQmlContext
    QQmlContext* pQmlContext=engine.rootContext();
    CameraHandler* pCameHandler=new CameraHandler;
    pQmlContext->setContextProperty("cameraHandler", pCameHandler);
    //*************************

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
