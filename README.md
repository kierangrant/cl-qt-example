Simple example to build a LISP Qt program.

Steps to build:

    mkdir build && cd build
    qmake ../QtUI
    make -j
    cd ..
    ln -s build/libQtUI.so
    ./build.sh

To Run:

    ./cl-qt-example

Or on Windows

    mkdir build && cd build
    /path/to/Qt/qmake.exe ../QtUI
    make -j
    cd ..
    mkdir ouput && cd output
    cp ../build/release/QtUI.dll .
    cp ../cl-qt-example.exe .
    /path/to/Qt/windeployqt.exe QtUI.dll

Then to Run:

    ./cl-qt-example.exe
