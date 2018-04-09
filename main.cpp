#include "mainwindow.h"
#include <QApplication>
#include <QThread>
#include <iostream>

#include "utils.h"
#include "consolebufferwindows.h"
#include  "visualizer.h"
#include "glwidget.h"
#include <thread>


extern "C" {
# include <lua.h>
# include <lauxlib.h>
# include <lualib.h>
}


VisObject v;

Visualizer con;



QThread thread;

int luaopen_mylib (lua_State *L) {

    // luaL_newlib(L, glLib);

    //luaL_openlibsL, "glib", glLib, 0);


    lua_getglobal(L, "glLib");
    if (lua_isnil(L, -1)) {
        lua_pop(L, 1);
        lua_newtable(L);
    }
    luaL_setfuncs(L, glLib, 0);
    lua_setglobal(L, "glLib");



    lua_getglobal(L, "conLib");
    if (lua_isnil(L, -1)) {
        lua_pop(L, 1);
        lua_newtable(L);
    }
    luaL_setfuncs(L, conLib, 0);
    lua_setglobal(L, "conLib");


    return 1;
}


int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    setlocale(LC_ALL,"Russian");



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

    return a.exec();
}
