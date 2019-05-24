#include "visualizer.h"
#include <iostream>
#define STD_OUTPUT_HANDLE2 (static_cast<DWORD>(-11))
enum class Actions : int
{
    enter = 13,
    esc   = 27,
    space = 32,
    home  = 71,
    up    = 72,
    pgup  = 73,
    left  = 75,
    right = 77,
    end   = 79,
    down  = 80,
    pgdn  = 81
};

/* Standard error macro for reporting API errors */
#define PERR(bSuccess, api){if(!(bSuccess)) printf("%s:Error %d from %s on line %d\n", __FILE__, static_cast<int>(GetLastError()), api, __LINE__);}

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
   dwConSize = static_cast<DWORD>(csbi.dwSize.X * csbi.dwSize.Y);

   /* fill the entire screen with blanks */

   bSuccess = FillConsoleOutputCharacter( hConsole, static_cast<TCHAR> (' '),
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
    WideCharToMultiByte(CP_ACP, 0, wstr.c_str(), -1, szTo, static_cast<int>(wstr.length()), nullptr, nullptr);
    strTo = szTo;
    delete[] szTo;
    return strTo;
}


void SetColor(HANDLE h, Color text, Color background);
Visualizer::Visualizer()
{
    setlocale(LC_ALL,"Russian");

     firstConsole = GetStdHandle(STD_OUTPUT_HANDLE2);
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

HANDLE *Visualizer::getActiveHandler()
{
    return handle + ((handle == handles.begin())?1:-1);
}

void Visualizer::changeBuffer()
{

    setActiveBuffer(*handle);
    if (handle == handles.begin())
        ++handle;
    else
        --handle;
    cls(*handle);

}


void Visualizer::setActiveBuffer(HANDLE h)
{
    SetConsoleActiveScreenBuffer(h);
}



// Convert an UTF8 string to a wide Unicode String
std::wstring utf8_decode(const std::string &str)
{
    if( str.empty() ) return std::wstring();
    auto size_needed = MultiByteToWideChar(CP_UTF8, 0, &str[0], static_cast<int>(str.size()), nullptr, 0);
    std::wstring wstrTo( static_cast<size_t>(size_needed), 0 );
    MultiByteToWideChar                  (CP_UTF8, 0, &str[0], static_cast<int>(str.size()), &wstrTo[0], size_needed);
    return wstrTo;
}

void Visualizer::putchar(const char ch[], int count, short cdx, short cdy, int bg, int fg)//const VisObject & visObject
{
    COORD cd = {cdx, cdy};
    auto wch = utf8_decode(ch);

    WriteConsoleOutputCharacterW(*handle, wch.c_str(), wch.length(), cd, logD2);
    WORD wColors =  static_cast<WORD>((static_cast<WORD>(bg) << 4) | static_cast<WORD>(fg));//(fg | bg);

    for(int i = 0; i < count; i++, cd.X++){
        WriteConsoleOutputAttribute(*handle, &wColors, 1, cd, logD2);
    }

    //changeBuffer();
}

void Visualizer::drawRect(short px, short py, unsigned short w, unsigned short h)
{
    COORD cd1 = {static_cast<short>(px-1), static_cast<short>(py-1)};
    auto curHandle = getActiveHandler();

    WriteConsoleOutputCharacterW(*curHandle, line.c_str(), w+2, cd1, logD2);
    cd1.Y = py+h;

    WriteConsoleOutputCharacterW(*curHandle, line.c_str(), w+2, cd1, logD2);
    cd1.Y = py-1;

    for(int i = 0; i < h; i++) {
        cd1.X = px - 1;
        cd1.Y += 1;
        WriteConsoleOutputCharacterW(*curHandle, line.c_str(), 1, cd1, logD2);
        cd1.X += w + 1;
//        WriteConsoleOutputCharacterW(*curHandle, line.c_str(), 1, cd1, logD2);
    }
}

void Visualizer::putWarning(const char ch[], short posx, short posy, unsigned short w, unsigned short h)
{
    COORD cd = {posx, posy};
    //COORD cd1 = {static_cast<short>(posx-1), static_cast<short>(posy-1)};

    auto wch = utf8_decode(ch);
    auto maximumHeight = static_cast<unsigned int>((wch.length()/w - h )*1.1);
    auto len = wch.length();
    auto curHandle = getActiveHandler();

    drawRect(posx, posy, w, h);
    auto key = 0;
    size_t lineNum = 0;
    do {
        auto tempCd = cd;
        size_t start = 0;
        size_t iter = 0;
        size_t currentPos = static_cast<size_t>(h*lineNum/maximumHeight) ;
        do {
            auto sub = wch.substr(start+lineNum*w, min(len - start+lineNum*w, static_cast<size_t>(w)));

            WriteConsoleOutputCharacterW(*curHandle, empty.c_str(), w, tempCd, logD2);
            WriteConsoleOutputCharacterW(*curHandle, sub.c_str(), sub.length(), tempCd, logD2);

            auto tmpCd = tempCd;
            tmpCd.X += w;
            if(currentPos == iter) {
                WORD wColors =  (static_cast<WORD>(Color::Black) << 4) | static_cast<WORD>(Color::LightRed);//(fg | bg);
                WriteConsoleOutputAttribute(*curHandle, &wColors, 1, tmpCd, logD2);
                WriteConsoleOutputCharacterW(*curHandle, L"@", 1, tmpCd, logD2);
            } else {
                WORD wColors =  (static_cast<WORD>(Color::Black) << 4) | static_cast<WORD>(Color::White);
                WriteConsoleOutputAttribute(*curHandle, &wColors, 1, tmpCd, logD2);
                WriteConsoleOutputCharacterW(*curHandle, L"#", 1, tmpCd, logD2);
            }

            tempCd.Y += 1;
            start += w;
            iter++;
        }
        while (start < wch.length() && iter < h);

        key = getch();
        if(key == 224 || key == 0){
            key = getch();
        }

        switch (key) {
            case static_cast<int>(Actions::down):
            lineNum += (lineNum*w +w*h+1 < wch.length())?1:0;
            break;
            case static_cast<int>(Actions::up):
                lineNum -= (lineNum>0)?1:0;
            break;
            case static_cast<int>(Actions::home):
                lineNum = 0;
            break;
            default:
                break;

        }
    } while (key != 13 && key != 27);
}

void SetColor(HANDLE h, Color text, Color background)
{
    SetConsoleTextAttribute(h, static_cast<WORD>((static_cast<WORD>(background) << 4) | static_cast<WORD>(text)));
}

void put(const char *ch, short cdx, short cdy, int colorBg , int colorFg )
{
    con.putchar(ch, static_cast<int>(strlen(ch)), cdx, cdy, colorBg, colorFg);
}

void putWarning(const char *ch, int posx, int posy, int h, int w )
{
    con.putWarning(ch, static_cast<short>(posx), static_cast<short>(posy), static_cast<unsigned short>(h), static_cast<unsigned short>(w));
}
