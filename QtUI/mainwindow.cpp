//  Kieran Grant releases this code in the Public Domain
#include <string>
#include <qtui.h>
#include <about-dialog.h>
#include "mainwindow.h"
#include "ui_mainwindow.h"

using namespace std;
using namespace QtUI;

MainWindow::MainWindow(char* (*lisp_handler)(char *), QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow),
    lisp_handler(lisp_handler)
{
    ui->setupUi(this);

    // create Help menu
    QMenu *helpMenu = new QMenu(tr("&Help"));
    // Add About
    QAction *about = new QAction(tr("&About"));
    about->setStatusTip(tr("About Commission Payment Tracker"));
    connect(about, &QAction::triggered, this, &MainWindow::ShowAbout);
    helpMenu->addAction(about);

    // Add About QT
    QAction *aboutQtAct = helpMenu->addAction(tr("About &Qt"), qApp, &QApplication::aboutQt);
    aboutQtAct->setStatusTip(tr("Show the Qt library's About box"));

    // add help menu to menubar
    ui->menubar->addMenu(helpMenu);

    connect(ui->btnCallLisp, &QPushButton::clicked, this, &MainWindow::callLisp);
}

void MainWindow::ShowAbout()
{
  AboutDialog().exec();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::callLisp() {
    string input = ui->lneInput->text().toStdString();
    char* c_str = new char[input.size() + 1];
    strcpy(c_str, input.c_str());
    string result = QtUI::cstr_to_string(lisp_handler(c_str));
    delete[] c_str;
    ui->lblOutput->setText(QString::fromStdString(result));
}
