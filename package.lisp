;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base: 10 -*-
;; Kieran Grant releases this code in the Public Domain
;; File: package.lisp
;; Description: Core Package File

(defpackage :cl-qt-example
  (:use :cl :cffi)
  (:export #:run-app))
