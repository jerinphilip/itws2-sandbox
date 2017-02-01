#lang racket
(require rackunit)
(provide (all-defined-out))

(define q-list '())

(define compute-score
  (lambda (actual-thunk expected-thunk label score)
    (with-handlers ([exn:fail? (lambda (exn) 0)])
        (if (check-equal? (actual-thunk) (expected-thunk) label)
          score
          0))))


(define run-testcase
  (lambda (actual-thunk expected-thunk label score)
    (let [(value (compute-score actual-thunk expected-thunk label score))]
      (set! q-list (cons (list label value) q-list)))))
