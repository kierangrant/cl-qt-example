;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base: 10; Package: CL-QT-EXAMPLE -*-
;; Kieran Grant releases this code in the Public Domain
;; File: ui.lisp
;; Description: Interface with C++ UI

(in-package :cl-qt-example)

(define-foreign-library %qtui
  (:win32 "qtui.dll" :search-path #P"./")
  (:unix "libQtUI.so" :search-path #P"./")
  (t (:default "libQtUI" :search-path #P"./")))

(defcstruct callback-struct
  (name :string)
  (version :string)
  (desc :string)
  (author :string)
  (argv :pointer)
  (argc :int)
  (process :pointer)
  (free :pointer)
  )

(defcfun "call_into_ui" :void (callback-struct (:pointer (:struct callback-struct))))

(defun run-app ()
  (use-foreign-library %qtui)
  ;; Setup Core Structure
  (let ((args (uiop/image:command-line-arguments)) argv-array)
    (if (= (length args) 0)
	(setf args '("cl-qt-example")))
    ;; args will have at least 1 element, so (setf (cdr (last args)) ...) will work
    (setf (cdr (last args)) (cons (null-pointer) nil))
    (setf argv-array (foreign-array-alloc
		      (coerce args 'vector) `(:array :string ,(length args))))
    (sb-int:with-float-traps-masked (:divide-by-zero :invalid)
      (call-into-ui
       (convert-to-foreign
	`(name "Qt++ Example Program"
	       version "1.0.0"
	       desc "Simple program to demonstrate Using Qt from LISP"
	       author "Kieran Grant"
	       argv ,argv-array
	       argc ,(length args)
	       process ,(callback process)
	       ;; Calling code needs to free using the C Runtime that SBCL is linked against
	       ;; SBCL is built with Mingw64 but Qt and UI are built with MSVC.
	       ;; (Even though Mingw uses MSVCRT.DLL, Qt/UI uses a _different_ CRT :/)
	       free ,(foreign-symbol-pointer "free"))
	'(:struct callback-struct))))))
