//  Kieran Grant releases this code in the Public Domain
#include <qtui.h>
#include <QApplication>
#include <mainwindow.h>

using namespace std;
using namespace QtUI;

struct QtUI::Core_t* core;

string QtUI::cstr_to_string(char* str)
{
    if (str != nullptr) {
        string retval(str);
        core->free(str);
        return retval;
    } else {
      return string();
    }
}

void call_into_ui(struct QtUI::Core_t* data) {
  core = data;
  QApplication app(core->argc, core->argv);

  app.setApplicationName(QString::fromUtf8(core->name));
  app.setApplicationVersion(QString::fromUtf8(core->version));
  app.setApplicationDisplayName(app.applicationName());
  
  MainWindow w(core->process);
  w.show();
  
  app.exec();
}
