#include "visualizer.h"
std::string wstrtostr(const std::wstring &wstr)
{
    // Convert a Unicode string to an ASCII string
    std::string strTo;
    char *szTo = new char[wstr.length() + 1];
    szTo[wstr.size()] = '\0';
    WideCharToMultiByte(CP_ACP, 0, wstr.c_str(), -1, szTo, (int)wstr.length(), NULL, NULL);
    strTo = szTo;
    delete[] szTo;
    return strTo;
}


void SetColor(HANDLE h, Color text, Color background);
Visualizer::Visualizer()
{
     firstConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    for (auto & ihandle : handles)
            ihandle = CreateConsoleScreenBuffer(GENERIC_READ | GENERIC_WRITE, 0, nullptr, CONSOLE_TEXTMODE_BUFFER, nullptr);;
        handle = handles.begin();
        setActiveBuffer(*handle);
        handle++;

        //connect(this, &Visualizer::toPut, this, &Visualizer::putchar);

}
static LPDWORD logD2 = new DWORD;

void Visualizer::setMainBuffer(int val)
{
    if(val)
        setActiveBuffer(firstConsole);
    else
            if (handle == handles.begin())
                setActiveBuffer(handle[1]);
            else
                setActiveBuffer(handle[0]);

}

void Visualizer::changeBuffer()
{
    setActiveBuffer(*handle);
    if (handle == handles.begin())
        ++handle;
    else
        --handle;

//    firstConsole = GetStdHandle(STD_OUTPUT_HANDLE);

//    for(short i = 0; i < 101; i++)
//    {
//        COORD cd = {0, i};
//        static char text[] = "                                                                                                    \0";
//        WriteConsoleOutputCharacterA(*handle, text, strlen(text), cd, logD2);
//    }
}


void Visualizer::setActiveBuffer(HANDLE h)
{
    SetConsoleActiveScreenBuffer(h);
}





void Visualizer::putchar(const char text[], int count, short cdx, short cdy, int bg, int fg)//const VisObject & visObject
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



