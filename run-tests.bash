#!/bin/bash

if [[ -n "$COVERALLS" ]]; then
    cl -l unix-opts -l unix-opts/tests -l cl-coveralls \
        -e '(setf fiveam:*debug-on-error* t
                 fiveam:*debug-on-failure* t)' \
        -e '(setf *debugger-hook*
                 (lambda (c h)
                   (declare (ignore c h))
                   (uiop:quit -1)))' \
        -e '(coveralls:with-coveralls (:exclude "./unix-opts-test.lisp")
             (ql:quickload :unix-opts/tests)
             (unix-opts/tests:run))'

else
    cl -l unix-opts -l unix-opts/tests \
        -e '(setf fiveam:*debug-on-error* t
                 fiveam:*debug-on-failure* t)' \
        -e '(setf *debugger-hook*
                 (lambda (c h)
                   (declare (ignore c h))
                   (uiop:quit -1)))' \
        -e '(progn
             (ql:quickload :unix-opts/tests)
             (uiop:quit (if (unix-opts/tests:run) 0 1)))'

fi
