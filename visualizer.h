#ifndef VISUALIZER_H
#define VISUALIZER_H

#include <QObject>
#include <windows.h>
#include <array>

#include "visualobject.h"

using namespace std;



class Visualizer : public QObject
{
    Q_OBJECT

    HANDLE firstConsole;

    array<HANDLE, 2> handles;
    std::array<HANDLE, 2> ::iterator handle;

    void setActiveBuffer(HANDLE h);
    void changeBuffer();

public:
    explicit Visualizer(QObject *parent = nullptr);

signals:
    void toPut();//const VisObject & visObject
public slots:
    void putchar();
//const VisObject & visObject
};

#endif // VISUALIZER_H
