#include "visualizer.h"
#include <iostream>

/* Standard error macro for reporting API errors */
#define PERR(bSuccess, api){if(!(bSuccess)) printf("%s:Error %d from %s \
   on line %d\n", __FILE__, GetLastError(), api, __LINE__);}

void cls( HANDLE hConsole )
{
   COORD coordScreen = { 0, 0 };    /* here's where we'll home the
                                       cursor */
   BOOL bSuccess;
   DWORD cCharsWritten;
   CONSOLE_SCREEN_BUFFER_INFO csbi; /* to get buffer info */
   DWORD dwConSize;                 /* number of character cells in
                                       the current buffer */

   /* get the number of character cells in the current buffer */

   bSuccess = GetConsoleScreenBufferInfo( hConsole, &csbi );
   PERR( bSuccess, "GetConsoleScreenBufferInfo" );
   dwConSize = csbi.dwSize.X * csbi.dwSize.Y;

   /* fill the entire screen with blanks */

   bSuccess = FillConsoleOutputCharacter( hConsole, (TCHAR) ' ',
      dwConSize, coordScreen, &cCharsWritten );
   PERR( bSuccess, "FillConsoleOutputCharacter" );

   /* get the current text attribute */

   bSuccess = GetConsoleScreenBufferInfo( hConsole, &csbi );
   PERR( bSuccess, "ConsoleScreenBufferInfo" );

   /* now set the buffer's attributes accordingly */

   bSuccess = FillConsoleOutputAttribute( hConsole, csbi.wAttributes,
      dwConSize, coordScreen, &cCharsWritten );
   PERR( bSuccess, "FillConsoleOutputAttribute" );

   /* put the cursor at (0, 0) */

   bSuccess = SetConsoleCursorPosition( hConsole, coordScreen );
   PERR( bSuccess, "SetConsoleCursorPosition" );
   return;
}


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
    setlocale(LC_ALL,"Russian");

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
    cls(*handle);


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



// Convert an UTF8 string to a wide Unicode String
std::wstring utf8_decode(const std::string &str)
{
    if( str.empty() ) return std::wstring();
    auto size_needed = MultiByteToWideChar(CP_UTF8, 0, &str[0], (int)str.size(), NULL, 0);
    std::wstring wstrTo( size_needed, 0 );
    MultiByteToWideChar                  (CP_UTF8, 0, &str[0], (int)str.size(), &wstrTo[0], size_needed);
    return wstrTo;
}

void Visualizer::putchar(const char ch[], int count, short cdx, short cdy, int bg, int fg)//const VisObject & visObject
{
//    wchar_t  wch[count];

//    for(int i =0; i< count; i++) {
//        wch[i] = (wchar_t)ch[i];
//    }

//    mbstowcs (wch, ch, count);

//    std::string s = wstrtostr(utf8_decode(ch));
    COORD cd = {cdx, cdy};
    auto wch = utf8_decode(ch);

    WriteConsoleOutputCharacterW(*handle, wch.c_str(), wch.length(), cd, logD2);
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

void put(const char *ch, int cdx, int cdy, int colorBg , int colorFg )
{
    auto len = strlen(ch);
//    wchar_t  wch[len];

//    for(int i =0; i< len; i++) {
//        wch[i] = (wchar_t)ch[i];
//    }

    //mbstowcs (wch, ch, len);

    //std::string s = wstrtostr(utf8_decode(ch));
    con.putchar(ch, len, cdx, cdy, colorBg, colorFg);
}

