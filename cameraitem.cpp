#include "cameraitem.h"

CameraItem::CameraItem(QQuickItem *parent)
    :QQuickPaintedItem(parent), m_active{false}
{
    update();
}

void CameraItem::paint(QPainter *painter)
{
    if(!m_active){
        painter->fillRect(0,0,width(),height(),QBrush(Qt::black));
    }
    else{
        QImage scaledImage=m_image.scaled(width(), height(), Qt::KeepAspectRatio);
        painter->drawPixmap((width()-scaledImage.width())/2,
                            (height()-scaledImage.height())/2,
                            scaledImage.width(),scaledImage.height(),QPixmap::fromImage(m_image));
    }

}

void CameraItem::slotSetImage(const QImage &image)
{
    m_active=true;
    m_image=image;
    update();
}

void CameraItem::slotReset()
{
    m_active=false;
    update();
}

