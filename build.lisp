(load "~/quicklisp/setup")
(ql:quickload :cl-qt-example)
(save-lisp-and-die
 #-win32 "./cl-qt-example"
 #+win32 "./cl-qt-example.exe"
 #+sb-core-compression :compression #+sb-core-compression 9
 #+win32 :application-type #+win32 :gui
 :executable t :toplevel #'cl-qt-example::entrypoint)
