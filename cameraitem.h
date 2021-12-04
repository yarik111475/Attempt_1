#ifndef CAMERAITEM_H
#define CAMERAITEM_H

#include <QObject>
#include <QPainter>
#include <QQuickPaintedItem>

class CameraItem : public QQuickPaintedItem
{
    Q_OBJECT
private:
    QImage m_image;
    bool m_active;
public:
    CameraItem(QQuickItem *parent = Q_NULLPTR);
    virtual void paint(QPainter *painter)override;
public slots:
    void slotSetImage(const QImage& image);
    void slotReset();
};

#endif // CAMERAITEM_H
