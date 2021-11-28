#include <about-dialog.h>
#include "ui_about-dialog.h"
#include <qtui.h>

AboutDialog::AboutDialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::AboutDialog)
{
    ui->setupUi(this);
    ui->lblAppName->setText(QString::fromUtf8(core->name));
    ui->lblAppVersion->setText(QString::fromUtf8(core->version));
    ui->lblAppDescription->setText(QString::fromUtf8(core->desc));
    ui->lblAppAuthors->setText(QString::fromUtf8(core->author));
}

AboutDialog::~AboutDialog()
{
    delete ui;
}
