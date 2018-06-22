#ifndef VISUALIZER_H
#define VISUALIZER_H

//#include <QObject>
#include <windows.h>
#include <array>
#include <conio.h>
#include <assert.h>

extern "C" {
# include <lua.h>
# include <lauxlib.h>
# include <lualib.h>
}


#include "visualobject.h"
#include <string>

std::string wstrtostr(const std::wstring &wstr);
std::wstring utf8_decode(const std::string &str);

using namespace std;



class Visualizer
{
//    Q_OBJECT

    HANDLE firstConsole;

    array<HANDLE, 2> handles;
    std::array<HANDLE, 2> ::iterator handle;

    void setActiveBuffer(HANDLE h);



public:
    explicit Visualizer();
    void changeBuffer();
    void putchar(const char text[], int count, short cdx, short cdy, int bg, int fg);
    void setMainBuffer(int val);
//signals:
    void toPut();//const VisObject & visObject
//public slots:
    //void putchar(wchar_t text[], int count, int cdx, int cdy, int bg, int fg);

//const VisObject & visObject
};

extern Visualizer con;

void put(const char * ch, int cdx, int cdy, int colorBg = 0, int colorFg = 15);

static int l_putCh (lua_State *L) {
    const char * ch = (lua_tostring(L,1));
    int  cdX = lua_tointeger(L,2);
    int  cdY = lua_tointeger(L,3);

    int colorBg = lua_tointeger(L, 4);
    int colorFg = lua_tointeger(L, 5);
    //int count   = lua_tointeger(L, 6);
    int len = strlen(ch);

//    wchar_t  wch[len];

//    for(int i =0; i< len; i++) {
//        wch[i] = (wchar_t)ch[i];
//    }

    //mbstowcs (wch, ch, len);

//    std::string s = wstrtostr(utf8_decode(ch));

    con.putchar(ch, len, cdX, cdY, colorBg, colorFg);

    return 0;
}

static int l_changeBuffer(lua_State *)
{
    con.changeBuffer();

    return 0;
}

static int l_getch(lua_State *L)
{
    int i = getch();
    lua_pushinteger(L, i);
    return 1;
}

static int l_getFirstConsole(lua_State *L)
{
    int  val = lua_tointeger(L,1);
    con.setMainBuffer(val);
    return 0;
}

static int l_printBuffer(lua_State *L)
{
    lua_pushnil(L);
    while(lua_next(L, -2)){
        if(lua_type(L, -1) == LUA_TTABLE) {
            int row = lua_tointeger(L, -2);

            for(int i = 1; ;i++) {
                lua_pushinteger(L, i);
                lua_gettable(L, -2);
                if(lua_type(L, -1) == LUA_TTABLE) {
                    lua_pushstring(L, "ch");
                    lua_gettable(L, -2);
                    assert(lua_type(L, -1) == LUA_TSTRING);

                    const char * ch = lua_tostring(L, -1);
                    lua_pop(L, 1);

                    lua_pushstring(L, "colorFg");
                    lua_gettable(L, -2);
                    assert(lua_type(L, -1) == LUA_TNUMBER);
                    int colorFg = lua_tointeger(L, -1);
                    lua_pop(L, 1);

                    lua_pushstring(L, "colorBg");
                    lua_gettable(L, -2);
                    assert(lua_type(L, -1) == LUA_TNUMBER);
                    int colorBg = lua_tointeger(L, -1);
                    lua_pop(L, 1);

                    lua_pushstring(L, "col");
                    lua_gettable(L, -2);
                    assert(lua_type(L, -1) == LUA_TNUMBER);
                    int col = lua_tointeger(L, -1);
                    lua_pop(L, 1);

                    put(ch, col, row, colorBg,colorFg );

                    lua_pop(L, 1);
                }
                else{
                    lua_pop(L, 1);
                    break;
                }
            }
            lua_pop(L, 1);
        }else {
            lua_pop(L, 1);
            break;
        }

    }
    lua_settop(L, 0);

    return 0;

}

static const struct luaL_Reg conLib [] = {



    {"putCh",           l_putCh}, //text, bg, fg
    {"changeBuffer",    l_changeBuffer},
    {"getch",           l_getch},           //() => intsymb
    {"getFirsConsole",  l_getFirstConsole},
    {"printBuffer",    l_printBuffer},



    {NULL, NULL}
};



#endif // VISUALIZER_H
