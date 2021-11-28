//  Kieran Grant releases this code in the Public Domain
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(char* (*lisp_handler)(char*), QWidget *parent = nullptr);
    ~MainWindow();
    void ShowAbout();
    void callLisp();

private:
    Ui::MainWindow *ui;
    char* (*lisp_handler)(char *);
};

#endif // MAINWINDOW_H
