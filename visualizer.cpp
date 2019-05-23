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

void Visualizer::putWarning(const char ch[], short posx, short posy, unsigned short w, unsigned short h)
{

    static wstring line = L"##################################################################################################################################";
    static wstring empty = L"                                                                                                                                  ";

    COORD cd = {posx, posy};
    COORD cd1 = {(short)(posx-1), (short)(posy-1)};

    auto wch = utf8_decode(ch);
    auto maximumHeight = wch.length()/w - h;
    auto len = wch.length();
    auto curHandle = getActiveHandler();

    WriteConsoleOutputCharacterW(*curHandle, line.c_str(), w+2, cd1, logD2);
    cd1.Y = posy+h;

    WriteConsoleOutputCharacterW(*curHandle, line.c_str(), w+2, cd1, logD2);
    cd1.Y = posy-1;

    for(int i = 0; i < h; i++) {
        cd1.X = posx - 1;
        cd1.Y += 1;
        WriteConsoleOutputCharacterW(*curHandle, line.c_str(), 1, cd1, logD2);
        cd1.X += w + 1;
//        WriteConsoleOutputCharacterW(*curHandle, line.c_str(), 1, cd1, logD2);
    }

    auto key = 0;
    size_t lineNum = 0;
    do {
        auto tempCd = cd;
        size_t start = 0;
        size_t iter = 0;
        size_t currentPos = static_cast<size_t>(h*lineNum/maximumHeight);
        do {
            auto sub = wch.substr(start+lineNum*w, min(len - start+lineNum*w, static_cast<size_t>(w)));

            WriteConsoleOutputCharacterW(*curHandle, sub.c_str(), sub.length(), tempCd, logD2);

            auto tmpCd = tempCd;
            tmpCd.X += w;
            if(currentPos == iter)
            {
                WORD wColors =  (static_cast<WORD>(Color::Black) << 4) | static_cast<WORD>(Color::LightRed);//(fg | bg);
                WriteConsoleOutputAttribute(*curHandle, &wColors, 1, tmpCd, logD2);
                WriteConsoleOutputCharacterW(*curHandle, L"@", 1, tmpCd, logD2);
            } else
            {
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
            case 80: //down
            lineNum += (lineNum*w +w*h+1 < wch.length())?1:0;
            break;
            case 75://left
//                lineNum -= (w*h)*((lineNum - w*h > 0)?1:0);
            break;
            case 72: //up
                lineNum -= (lineNum>0)?1:0;
            break;
            case 77://right
//                lineNum += (w*h)*((lineNum + 2*w*h < static_cast<int>(wch.length()))?1:0);
            break;
            case 73: //pgup
//                lineNum -= (lineNum>0)?1:0;
            break;
            case 81: //pgdn
//                lineNum += (w*h)*((lineNum + 2*w*h < static_cast<int>(wch.length()))?1:0);
            break;
            case 71://home
                lineNum = 0;
            break;

            case 79: //end
            break;
            case 13: //enter
            break;
            case 27: //esc
            break;
            case 32: //space
//                lineNum += (w*h)*(lineNum + 2*w*h < wch.length()?1:0);
            break;

            default:
                break;

        }
    } while (key != 13 && key != 27);



}

void SetColor(HANDLE h, Color text, Color background)
{
    SetConsoleTextAttribute(h, (static_cast<WORD>(background) << 4) | static_cast<WORD>(text));
}

void put(const char *ch, short cdx, short cdy, int colorBg , int colorFg )
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

void putWarning(const char *ch, int posx, int posy, int h, int w )
{
    con.putWarning(ch, posx, posy, h, w);
}
