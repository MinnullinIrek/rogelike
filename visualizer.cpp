#include "visualizer.h"



void SetColor(HANDLE h, Color text, Color background);
Visualizer::Visualizer(QObject *parent) : QObject(parent)
{
    for (auto & ihandle : handles)
            ihandle = CreateConsoleScreenBuffer(GENERIC_READ | GENERIC_WRITE, 0, nullptr, CONSOLE_TEXTMODE_BUFFER, nullptr);;
        handle = handles.begin();
        setActiveBuffer(*handle);
        handle++;

        //connect(this, &Visualizer::toPut, this, &Visualizer::putchar);

}


void Visualizer::changeBuffer()
{
    setActiveBuffer(*handle);
    if (handle == handles.begin())
        ++handle;
    else
        --handle;

    firstConsole = GetStdHandle(STD_OUTPUT_HANDLE);

}


void Visualizer::setActiveBuffer(HANDLE h)
{
    SetConsoleActiveScreenBuffer(h);
}
static LPDWORD logD2 = new DWORD;




void Visualizer::putchar(const char text[], int count, int cdx, int cdy, int bg, int fg)//const VisObject & visObject
{
    COORD cd = {cdx, cdy};


    WriteConsoleOutputCharacterA(*handle, text, count, cd, logD2);
    WORD wColors =  (static_cast<WORD>(bg) << 4) | static_cast<WORD>(fg);//(fg | bg);

    for(int i = 0; i < count; i++, cd.X++){

        WriteConsoleOutputAttribute(*handle, &wColors, 1, cd, logD2);
    }

    //changeBuffer();
}

void SetColor(HANDLE h, Color text, Color background)
{
    SetConsoleTextAttribute(h, (static_cast<WORD>(background) << 4) | static_cast<WORD>(text));
}



