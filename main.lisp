;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base: 10; Package: CL-QT-EXAMPLE -*-
;; Kieran Grant releases this code in the Public Domain
;; File: main.lisp
;; Description: Entrypoint for main program

(in-package :cl-qt-example)

;; Do any early actions that need to be done before UI is initiated
(defun early-runtime-fixups ()
  )

;; Do any processing that needs to be done before program termination after UI is shutdown
(defun late-runtime-teardowns ()
  )

;; Need to setup Console on Windows if --debug is used ant not already running in a terminal
#+win32 (cffi:defcfun (%allocate-console "AllocConsole") :boolean)
#+win32 (cffi:defcfun (%get-std-handle "GetStdHandle") :int64 (handle :int32))
#+win32 (defun setup-console ()
	  (when (%allocate-console)
	    (let* ((stdin (sb-sys:make-fd-stream
			   (%get-std-handle -10)
			   :input t
			   :external-format :ucs-2
			   :buffering :line))
		   (stdout (sb-sys:make-fd-stream
			    (%get-std-handle -11)
			    :output t
			    :external-format :ucs-2
			    :buffering :line))
		     (stderr (sb-sys:make-fd-stream
			      (%get-std-handle -12)
			      :output t
			      :external-format :ucs-2
			      :buffering :none))
		   (terminal (make-two-way-stream stdin stdout)))
	      (setf *standard-output* stdout
		    *standard-input* stdin
		    *error-output* stderr
		    *terminal-io* terminal))))

(defun entrypoint ()
  (when (member "--debug" (uiop/image:command-line-arguments) :test #'string=)
    #+win32 (setup-console)
    (sb-thread:release-foreground)
    (sb-ext:enable-debugger))
  (early-runtime-fixups)
  (run-app)
  (late-runtime-teardowns)
  (when (member "--debug" (uiop/image:command-line-arguments) :test #'string=)
    (format t "Press Enter to exit the program~%")
    (force-output)
    (read-line))
  (uiop/image:quit))

(define-callback process :string ((input :string))
  (foreign-string-alloc
   (with-output-to-string (o)
     (ignore-errors
       (format o "~S" (eval (read-from-string input)))))))
