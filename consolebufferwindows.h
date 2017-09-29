#ifndef CONSOLEBUFFERWINDOWS_H
#define CONSOLEBUFFERWINDOWS_H

#include <QObject>
#include <windows.h>
#include <array>

#include "visualobject.h"

using namespace std;

static LPDWORD logD = new DWORD;

class ConsoleBufferWindows : public QObject
{
    Q_OBJECT

    HANDLE firstConsole;

    array<HANDLE, 2> handles;
    std::array<HANDLE, 2> ::iterator handle;

    void setActiveBuffer(HANDLE h);
    void changeBuffer();


public:
    ConsoleBufferWindows();

signals:
    void toPut(const VisObject & visObject);
public slots:
    void putchar(const VisObject & visObject);
};

#endif // CONSOLEBUFFERWINDOWS_H
