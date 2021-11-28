//  Kieran Grant releases this code in the Public Domain
#ifndef QTUI_H
#define QTUI_H

#include <string>
#include <QtCore/qglobal.h>
#ifdef _MSC_VER
typedef char _Bool;
#else
#include <stdbool.h>
#endif

namespace QtUI {
  std::string cstr_to_string(char* string);

  extern "C" {
    struct Core_t {
      char *name;
      char *version;
      char *desc;
      char *author;
      char **argv;
      int argc;
      char* (*process)(char*);
      // Need to make sure to use callback to Mingw64 provided "free" for all LISP-side allocated memory
      void (*free)(void* ptr);
    };
  }
}

extern struct QtUI::Core_t* core;

extern "C" Q_DECL_EXPORT void call_into_ui(struct QtUI::Core_t* data);

#endif // QTUI_H
