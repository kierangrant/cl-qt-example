;; -*- Mode: Lisp; Syntax: COMMON-LISP; Base: 10 -*-
;; © Copyright Kieran Grant 2021
;; File: package.lisp
;; Description: Core Package File

(defpackage :cl-qt-example
  (:use :cl :cffi)
  (:export #:run-app))
