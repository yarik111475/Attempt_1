#include "camerahandler.h"

void CameraHandler::slotTimeout()
{
    m_pImageCapture->capture();
}



void CameraHandler::slotStartCapture()
{
    if(m_pCamera){
        m_pCamera->start();
        m_pTimer->start();
    }
}

void CameraHandler::slotStopCapture()
{
    if(m_pCamera){
        m_pCamera->stop();
        m_pTimer->stop();
    }
}

//in this slot we can get our image and operate with it
void CameraHandler::slotImageCaptured(int id, const QImage &preview)
{
    if(!preview.isNull()){
        qDebug()<<"image captured";
        qDebug()<<"image size: " <<preview.size();
    }
}

CameraHandler::CameraHandler(QObject *parent) : QObject(parent)
{
    m_pCamera=new QCamera(QCamera::FrontFace, this);
    m_pCamera->setCaptureMode(QCamera::CaptureVideo);


    m_pImageCapture=new QCameraImageCapture(m_pCamera);
    m_pImageCapture->setCaptureDestination(QCameraImageCapture::CaptureToBuffer);

    QObject::connect(m_pImageCapture, SIGNAL(imageCaptured(int,QImage)),
                     this, SIGNAL(signalImageCaptured(int,QImage)));
    QObject::connect(m_pImageCapture, SIGNAL(imageCaptured(int,QImage)),
                     this, SLOT(slotImageCaptured(int,QImage)));

    m_pTimer=new QTimer(this);
    m_pTimer->setInterval(30);
    QObject::connect(m_pTimer, SIGNAL(timeout()),
                     this, SLOT(slotTimeout()));
}
