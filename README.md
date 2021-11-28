Simple example to build a LISP Qt program.

Steps to build:

    ./build.sh
    mkdir build && cd build
    qmake ../QtUI
    make -j
    cd ..
    ln -s build/libQtUI.so

To Run:

    ./cl-qt-example

Or on Windows

    ./build.sh
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
