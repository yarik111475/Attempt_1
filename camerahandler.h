#ifndef CAMERAHANDLER_H
#define CAMERAHANDLER_H

#include <QtCore>
#include <QObject>
#include <QtMultimedia>
#include <QtMultimediaWidgets>

class CameraHandler : public QObject
{
    Q_OBJECT
private:
    QTimer* m_pTimer;
    QCamera* m_pCamera;
    QCameraImageCapture* m_pImageCapture;
    QCameraViewfinder* m_pViewFinder;
private slots:
    void slotTimeout();
public slots:
    void slotStartCapture();
    void slotStopCapture();
    void slotImageCaptured(int id, const QImage& preview);
public:
    explicit CameraHandler(QObject *parent = nullptr);
    ~CameraHandler(){}

signals:
    void signalImageCaptured(int id, const QImage& preview);

};

#endif // CAMERAHANDLER_H
