#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QVideoFilterRunnable>
#include <QQmlContext>
#include "imagehandler.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    //************************
    //create QQmlContext object,
    //create ImageHandler object
    //and set property named 'imageHandler' into QQmlContext
    QQmlContext* pQmlContext=engine.rootContext();
    ImageHandler* pImageHandler=new ImageHandler;
    pQmlContext->setContextProperty("imageHandler", pImageHandler);
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
