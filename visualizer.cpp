#include "visualizer.h"

void SetColor(HANDLE h, Color text, Color background);
Visualizer::Visualizer(QObject *parent) : QObject(parent)
{
    for (auto & ihandle : handles)
            ihandle = CreateConsoleScreenBuffer(GENERIC_READ | GENERIC_WRITE, 0, nullptr, CONSOLE_TEXTMODE_BUFFER, nullptr);;
        handle = handles.begin();
        setActiveBuffer(*handle);
        handle++;

        connect(this, &Visualizer::toPut, this, &Visualizer::putchar);

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

VisObject visObject;
void Visualizer::putchar()//const VisObject & visObject
{

//    HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);

//    SetConsoleTextAttribute(handle, FOREGROUND_RED);
//    printf("%s", "asdfg");

//    HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);


//    SetConsoleTextAttribute(handle, FOREGROUND_RED);

    visObject.bgColor = Color::Blue;
    visObject.objColor = Color::Green;
    visObject.ch = L"D";
    //setActiveBuffer(*handle);
//SetColor(handle, Color::DarkGray , Color::Black);

    SetConsoleTextAttribute(*handle, FOREGROUND_RED | BACKGROUND_BLUE);
    WriteConsoleOutputCharacter(*handle, visObject.ch.c_str(), 1, COORD{1,1}, logD2);

 //   SetColor(*handle, visObject.objColor , visObject.bgColor);
    WriteConsoleOutputCharacter(*handle, visObject.ch.c_str(), 1, COORD{2,1}, logD2);

    changeBuffer();
}

void SetColor(HANDLE h, Color text, Color background)
{
    SetConsoleTextAttribute(h, (static_cast<WORD>(background) << 4) | static_cast<WORD>(text));
}

