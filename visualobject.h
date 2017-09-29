#ifndef VISUALOBJECT_H
#define VISUALOBJECT_H
#include "string"


using namespace std;

enum class Color {
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

struct VisObject
{
    Color       objColor;
    Color       bgColor;
    wstring        ch;
    wstring type;
};



#endif // VISUALOBJECT_H
