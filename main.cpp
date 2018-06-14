#include "mainwindow.h"
//#include <QApplication>
//#include <QThread>
#include <iostream>

#include "utils.h"
#include "consolebufferwindows.h"
#include  "visualizer.h"
#include "glwidget.h"
#include <thread>
#include <iostream>
#include <io.h>
#include <fcntl.h>

extern "C" {
# include <lua.h>
# include <lauxlib.h>
# include <lualib.h>
}

#include <clocale>
VisObject v;

Visualizer con;



//QThread thread;

int luaopen_mylib (lua_State *L) {

    // luaL_newlib(L, glLib);

    //luaL_openlibsL, "glib", glLib, 0);


    lua_getglobal(L, "glLib");
    if (lua_isnil(L, -1)) {
        lua_pop(L, 1);
        lua_newtable(L);
    }
//    luaL_setfuncs(L, glLib, 0);
//    lua_setglobal(L, "glLib");



    lua_getglobal(L, "conLib");
    if (lua_isnil(L, -1)) {
        lua_pop(L, 1);
        lua_newtable(L);
    }
    luaL_setfuncs(L, conLib, 0);
    lua_setglobal(L, "conLib");


    return 1;
}


// Convert a wide Unicode string to an UTF8 string
std::string utf8_encode(const std::wstring &wstr)
{
    if( wstr.empty() ) return std::string();
    int size_needed = WideCharToMultiByte(CP_UTF8, 0, &wstr[0], (int)wstr.size(), NULL, 0, NULL, NULL);
    std::string strTo( size_needed, 0 );
    WideCharToMultiByte                  (CP_UTF8, 0, &wstr[0], (int)wstr.size(), &strTo[0], size_needed, NULL, NULL);
    return strTo;
}

// Convert an UTF8 string to a wide Unicode String
std::wstring utf8_decode(const std::string &str)
{
    if( str.empty() ) return std::wstring();
    int size_needed = MultiByteToWideChar(CP_UTF8, 0, &str[0], (int)str.size(), NULL, 0);
    std::wstring wstrTo( size_needed, 0 );
    MultiByteToWideChar                  (CP_UTF8, 0, &str[0], (int)str.size(), &wstrTo[0], size_needed);
    return wstrTo;
}



int main(int argc, char *argv[])
{
//    QApplication a(argc, argv);
    SetConsoleCP(1251);// установка кодовой страницы win-cp 1251 в поток ввода
    SetConsoleOutputCP(1251);


//    wgl = new GLWidget;

    //printf("%s", "sdfddf");
    lua_State *L = luaL_newstate();

    luaopen_mylib (L);
    luaL_openlibs(L);

    //luaL_dofile(L, "C:/books/roge/rogelike/scripts/script.lua");
    luaL_dofile(L, "C:/books/roge/rogelike/scripts/script.lua");
    //std::thread thr([=](){luaL_dofile(L, "C:/books/roge/rogelike/scripts/script.lua");});

    //thr.join();



//    tracer = new Tracer;

    //Trace("asdadsda");




    v.bgColor = Color::Blue;
    v.objColor = Color::Green;
    v.ch = L"D";




    //wgl->show();


    //    thread.start();

    //    con.moveToThread(&thread);

    //    con.toPut();

    return 0;
}
