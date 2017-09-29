#include <QHBoxLayout>
#include "tracer.h"


Tracer::Tracer(QWidget *parent) : QWidget(parent)
{
    QHBoxLayout *layout = new QHBoxLayout;
    this->setLayout(layout);
    layout->addWidget(&edit);

    this->show();

}

void Tracer::Trace(QString text)
{
//    edit.setPlainText(text);
    edit.append(text+"\n");
}
