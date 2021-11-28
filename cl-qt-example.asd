;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10; Package: CL-USER -*-
;; Kieran Grant releases this code in the Public Domain
;; File: cl-qt-example.asd
;; Description: System Definition of Qt C++ Library Example

(defsystem "cl-qt-example"
  :author "Kieran Grant"
  :version "1.0.0"
  :depends-on ("cffi")
  :license "Public Domain"
  :serial t
  :components
  ((:file "package")
   (:file "macros")
   (:file "ui")
   (:file "main")))
