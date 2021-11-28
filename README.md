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
