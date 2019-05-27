#ifndef VISUALIZER_H
#define VISUALIZER_H

//#include <QObject>
#include <windows.h>
#include <array>
#include <conio.h>
#include <assert.h>
#include <vector>
#include <iostream>

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

enum class Colors : short
{
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    LightGray = 7,
    DarkGray = 8,
    LightBlue = 9,
    LightGreen = 10,
    LightCyan = 11,
    LightRed = 12,
    LightMagenta = 13,
    Yellow = 14,
    White = 15
};


class Visualizer
{
//    Q_OBJECT

    const wstring line = L"##################################################################################################################################";
    const wstring empty = L"                                                                                                                                  ";


    HANDLE firstConsole;

    array<HANDLE, 2> handles;
    std::array<HANDLE, 2> ::iterator handle;

    void setActiveBuffer(HANDLE h);

    HANDLE *getActiveHandler();
    void drawRect(short px, short py, unsigned short w, unsigned short h);

public:
    explicit Visualizer();
    void changeBuffer();

    void putchar(const char ch[], int count, short cdx, short cdy, int bg, int fg);
    void putWarning(const char ch[], short posx, short posy, unsigned short w, unsigned short h);
    int showDialog(const char *replic, std::vector<const char*> answers);
    std::string getText();
    void setMainBuffer(int val);
//signals:
    void toPut();//const VisObject & visObject
//public slots:
    //void putchar(wchar_t text[], int count, int cdx, int cdy, int bg, int fg);

//const VisObject & visObject
    void putText(wstring wreplic, size_t lineNum, short px, short py, unsigned short w, unsigned short h, bool isAnswer, bool isChecked);
};

extern Visualizer con;

void put(const char *ch, short cdx, short cdy, int colorBg = 0, int colorFg = 15);

static int l_putCh (lua_State *L) {
    const char * ch = (lua_tostring(L,1));
    auto  cdX = lua_tointeger(L,2);
    auto cdY = lua_tointeger(L,3);

    auto colorBg = lua_tointeger(L, 4);
    auto colorFg = lua_tointeger(L, 5);
    //int count   = lua_tointeger(L, 6);
    auto len = strlen(ch);




    con.putchar(ch, static_cast<int>(len), static_cast<short>(cdX), static_cast<short>(cdY), static_cast<int>(colorBg), static_cast<int>(colorFg));

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

static int l_get(lua_State *)
{
    return 0;
}

static int l_showWarning(lua_State *L)
{
    const char * ch = (lua_tostring(L,1));
    auto posx       = lua_tointeger(L,2);
    auto posy       = lua_tointeger(L,3);
    auto h          = lua_tointeger(L,4);
    auto w          = lua_tointeger(L,5);

    con.putWarning(ch, static_cast<short>(posx), static_cast<short>(posy), static_cast<unsigned short>(h), static_cast<unsigned short>(w) );

    return 0;
}

static int l_getString(lua_State *L){
    auto s = con.getText();
    return 1;
}

static int l_showDialog(lua_State *L)
{
    std::vector<const char*> answers;
    lua_pushstring(L, "replic");
    lua_gettable(L, -2);
    if(lua_type(L, -1) == LUA_TSTRING) {
        auto replic = lua_tostring(L, -1);
        lua_pop(L, 1);
        lua_pushstring(L, "answers");
        lua_gettable(L, -2);
        lua_pushnil(L);
        while(lua_next(L, -2)){
            if(lua_type(L, -1) == LUA_TTABLE) {
                lua_pushstring(L, "answer");
                lua_gettable(L, -2);
                answers.push_back(lua_tostring(L, -1));
                lua_pop(L, 1);
            }
            lua_pop(L, 1);
        }
        auto choise = con.showDialog(replic, answers);
        lua_pushnumber(L, choise);
    }

    return 1;
}


static int l_getFirstConsole(lua_State *L)
{
    int  val = static_cast<int>(lua_tointeger(L,1));
    con.setMainBuffer(val);
    return 0;
}

static int l_printBuffer(lua_State *L)
{
    lua_pushnil(L);
    while(lua_next(L, -2)){
        if(lua_type(L, -1) == LUA_TTABLE) {
            auto row = static_cast<short>(lua_tointeger(L, -2));

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
                    int colorFg = static_cast<int>(lua_tointeger(L, -1));
                    lua_pop(L, 1);

                    lua_pushstring(L, "colorBg");
                    lua_gettable(L, -2);
                    assert(lua_type(L, -1) == LUA_TNUMBER);
                    int colorBg = static_cast<int>(lua_tointeger(L, -1));
                    lua_pop(L, 1);

                    lua_pushstring(L, "col");
                    lua_gettable(L, -2);
                    assert(lua_type(L, -1) == LUA_TNUMBER);
                    auto col = static_cast<short>(lua_tointeger(L, -1));
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
    {"printBuffer",     l_printBuffer},
    {"get",             l_get},
    {"showWarning",     l_showWarning}, // text,posx, posy, h, w
    {"showDialog",      l_showDialog}, // t
    {"getString",       l_getString}, // => text



    {nullptr, nullptr}
};



#endif // VISUALIZER_H
