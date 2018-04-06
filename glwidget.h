#ifndef GLWIDGET_H
#define GLWIDGET_H

#include <QGLWidget>
#include <QtOpenGL>
#include <QTimer>
#include <vector>

#include "tracer.h"


extern "C" {
# include <lua.h>
# include <lauxlib.h>
# include <lualib.h>
}


enum class WidgetMode
{
    map = 0,
    text = 1
};


class GLWidget : public QGLWidget
{
    Q_OBJECT
public:
    float h = 40;
    float mapStart   = 10;
    float mapEnd     = 500;

    lua_State *L = nullptr;
    WidgetMode mode = WidgetMode::map;

public:
    GLWidget( lua_State *L, QWidget *parent = 0);

    void drawMap();

protected:
    int geese_size; // Размер гуся))
    int point; // набранные очки
    int gdx, gdy; // Координаты объектов (гусей)
    int cax, cay, cbx, cby; // Координаты курсора
    int wax ,way; // Размеры окна
    bool singling; // Для выделение области
    void self_cursor(); // метод для рисования своего курсора
    void initializeGL(); // Метод для инициализирования opengl
    void resizeGL(int nWidth, int nHeight); // Метод вызываемый после каждого изменения размера окна
    void paintGL(); // Метод для вывода изображения на экран
    void keyPressEvent(QKeyEvent *ke); // Для перехвата нажатия клавиш на клавиатуре
    void mouseMoveEvent(QMouseEvent *me); // Метод реагирует на перемещение указателя, но по умолчанию setMouseTracking(false)
    void mousePressEvent(QMouseEvent *me); // Реагирует на нажатие кнопок мыши
    void mouseReleaseEvent(QMouseEvent *me); // Метод реагирует на "отжатие" кнопки мыши
    void singling_lb(); // Рисуем рамку выделенной области
    void geese(); // Рисуем объекты (будущих гусей :) )


protected slots:
    void geese_coord(); // Определяем координаты объектов

    void slSjowEx();

signals:
    void showex();
};

static GLWidget *wgl;

static Tracer *tarcer;

static int l_show (lua_State *L) {
    wgl = new GLWidget(L);
    const char* c = lua_tostring(L, 1);
    //emit wgl->showex();
    printf("%s", "l_show");
    tarcer = new Tracer;
    tarcer->Trace("l_show");
    return 0;
}

static int l_update(lua_State *)
{
    wgl->updateGL();
    return 0;
}

static int l_print(lua_State *L)
{
    size_t len;
    tarcer->Trace(luaL_tolstring(L, -1, &len));
    return 0;
}

static const struct luaL_Reg glLib [] = {
    {"show", l_show}, //
    {"update", l_update},
    {"print", l_print},
    //{"setMode", l_setMode},


    {NULL, NULL}
};



#endif // GLWIDGET_H
