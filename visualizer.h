#ifndef VISUALIZER_H
#define VISUALIZER_H

#include <QObject>
#include <windows.h>
#include <array>

extern "C" {
# include <lua.h>
# include <lauxlib.h>
# include <lualib.h>
}


#include "visualobject.h"
#include <string>


using namespace std;



class Visualizer : public QObject
{
    Q_OBJECT

    HANDLE firstConsole;

    array<HANDLE, 2> handles;
    std::array<HANDLE, 2> ::iterator handle;

    void setActiveBuffer(HANDLE h);



public:
    explicit Visualizer(QObject *parent = nullptr);
    void changeBuffer();
    void putchar(wchar_t text[], int count, int cdx, int cdy, int bg, int fg);
signals:
    void toPut();//const VisObject & visObject
public slots:
    //void putchar(wchar_t text[], int count, int cdx, int cdy, int bg, int fg);

//const VisObject & visObject
};

extern Visualizer con;

static int l_putCh (lua_State *L) {
    const char * ch = (lua_tostring(L,1));
    int  cdX = lua_tointeger(L,2);
    int  cdY = lua_tointeger(L,3);

    int colorBg = lua_tointeger(L, 4);
    int colorFg = lua_tointeger(L, 5);
    //int count   = lua_tointeger(L, 6);
    int len = strlen(ch);

    wchar_t  wch[len];

    for(int i =0; i< len; i++) {
        wch[i] = (wchar_t)ch[i];
    }

    con.putchar(wch, len, cdX, cdY, colorBg, colorFg);

    return 0;
}

static int l_changeBuffer(lua_State *L)
{
    con.changeBuffer();
}

static const struct luaL_Reg conLib [] = {



    {"putCh",           l_putCh}, //text, bg, fg
    {"changeBuffer",    l_changeBuffer},



    {NULL, NULL}
};



#endif // VISUALIZER_H
