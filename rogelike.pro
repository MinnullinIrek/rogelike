#-------------------------------------------------
#
# Project created by QtCreator 2017-09-14T16:33:04
#
#-------------------------------------------------

QT       += core gui opengl

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
CONFIG += c++11 console
CONFIG -= app_bundle
CONFIG -= qt
TARGET = rogelike
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which has been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
#DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
        main.cpp \
        mainwindow.cpp \
    tracer.cpp \
    consolebufferwindows.cpp \
    visualobject.cpp \
    visualizer.cpp \
    glwidget.cpp \
    utils.cpp

HEADERS += \
        mainwindow.h \
    utils.h \
    tracer.h \
    consolebufferwindows.h \
    visualobject.h \
    visualizer.h \
    glwidget.h

FORMS += \
        mainwindow.ui

win32: LIBS += -L$$PWD/../../../lua/ -llua53

INCLUDEPATH += $$PWD/../../../lua
DEPENDPATH += $$PWD/../../../lua

LIBS += -lopengl32

#LIBS += -lglu32
# LuaJIT (c:/LuaJIT)
INCLUDEPATH += c:/Lua/include
LIBS += -Lc:/Lua -llua53
# c:/LuaJIT/lua51.dll
