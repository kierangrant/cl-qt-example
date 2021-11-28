;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base: 10; Package: CL-QT-EXAMPLE -*-
;; Kieran Grant releases this code in the Public Domain
;; File: macros.lisp
;; Description: Macros for QT Interface

(in-package :cl-qt-example)

(defmacro define-callback (name-and-options return-type args &body body)
  "A simple wrapper around DEFCALLBACK that creates a new function with the callback name first and then creates a callback that calls that function. This is to facilitate the use of TRACE on callbacks."
  (let ((callback-name (if (listp name-and-options) (car name-and-options) name-and-options))
	(arg-syms (mapcar #'car args)))
    `(progn
       (defun ,callback-name ,arg-syms ,@body)
       (defcallback ,name-and-options ,return-type ,args (,callback-name ,@arg-syms)))))
