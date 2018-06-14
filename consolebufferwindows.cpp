#include "consolebufferwindows.h"

//void SetColor(HANDLE h, Color text, Color background);


//ConsoleBufferWindows::ConsoleBufferWindows():QObject()
//{
//    for (auto & ihandle : handles)
//            ihandle = CreateConsoleScreenBuffer(GENERIC_READ | GENERIC_WRITE, 0, nullptr, CONSOLE_TEXTMODE_BUFFER, nullptr);;
//        handle = handles.begin();
//        setActiveBuffer(*handle);
//        handle++;

//        connect(this, &ConsoleBufferWindows::toPut, this, &ConsoleBufferWindows::putchar);
//}

//void ConsoleBufferWindows::changeBuffer()
//{
//    setActiveBuffer(*handle);
//    if (handle == handles.begin())
//        ++handle;
//    else
//        --handle;

//    firstConsole = GetStdHandle(STD_OUTPUT_HANDLE);

//}


//void ConsoleBufferWindows::setActiveBuffer(HANDLE h)
//{
//    SetConsoleActiveScreenBuffer(h);
//}

//void ConsoleBufferWindows::putchar(const VisObject & visObject)
//{
//    SetColor(*handle, visObject.objColor , visObject.bgColor);
//    WriteConsoleOutputCharacter(*handle, visObject.ch.c_str(), 1, COORD{1,1}, logD);
//    SetColor(handle, Color::White , Color::Black);
//    changeBuffer();
//}

//void SetColor(HANDLE h, Color text, Color background)
//{
//    SetConsoleTextAttribute(h, (static_cast<WORD>(background) << 4) | static_cast<WORD>(text));
//}
