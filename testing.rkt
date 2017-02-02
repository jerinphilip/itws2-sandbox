#lang racket
(require "main.rkt")
(require "scoring.rkt")

(define binary-and 
  (lambda (x y)
    (and x y)))

(define (all-satisfy predicate ls) 
  (reduce binary-and #t (map predicate ls)))


(run-testcase  (thunk (all-satisfy even? '(2 3 4))) (thunk #f) "All-even-test #f" 1)
(run-testcase  (thunk (all-satisfy even? '(2 4 6))) (thunk #t) "All-even-test #t" 1)
(run-testcase  (thunk (all-satisfy boolean? '(#t #f 6))) (thunk #f) "All-boolean-test #f" 1)
(run-testcase  (thunk (all-satisfy boolean? '(#t #f #t))) (thunk #t) "All-boolean-test #t" 1)



(define next-even? (compose even? add1))
(run-testcase (next-even? 4) (thunk #f) "compose-t1" 1)
(run-testcase (next-even? 5) (thunk #t) "compose-t2" 1)
(define mul2
  (lambda (x) (* x 2)))

(define f (compose* add1 mul2 sub1))
(run-testcase (thunk (f 4)) (thunk 7) "f 4" 1)
(run-testcase (thunk (f 7)) (thunk 13) "f 7" 1)
(run-testcase (thunk (reverse '(a b c))) (thunk '(c b a)) "Reverse (a b c)" 1)
(run-testcase (thunk (reverse '(1 2 3 4))) (thunk '(4 3 2 1)) "Reverse (1 2 3 4)" 1)
(run-testcase (thunk (list-length '(a b c))) (thunk 3) "List Length (a b c)" 1)
(run-testcase (thunk (list-length '(1 2 3 4))) (thunk 4) "List Length (1 2 3 4)" 1)
;(define sum (reduce-curried + 0))
;(define product (reduce-curried * 1))
;(run-testcase (sum '(1 2 3 4 5 6)) 21 "Reduce-curried: sum-test")
;(run-testcase (product '(4 5 6)) 120 "Reduce-curried: product-test")
(run-testcase (thunk (list-map) add1 '(1 2 3 4)) (thunk '(2 3 4 5)) "test 1" 1)
(run-testcase (thunk (list-map boolean? '(1 #t #f 4))) (thunk '(#f #t #t #f)) "test 2" 1)
(define equilateral-triangle-area
  (lambda (side)
    (* (/ (sqrt 3) 4) side side)))

(define square-area
  (lambda (side)
    (* side side)))

(define circle-area
  (lambda (radius)
    (* pi radius radius)))


(define square-perimeter
  (lambda (side)
    (* 4 side)))

(define equilateral-triangle-perimeter
  (lambda (side)
    (* 3 side)))

(define circle-perimeter
  (lambda (radius)
    (* 2 pi radius)))


(run-testcase (thunk (area (triangle 3))) (thunk (equilateral-triangle-area 3)) "Triangle
              area test" 1)

(run-testcase (thunk (area (square 4))) (thunk (square-area 4)) "Square area test" 1)
(run-testcase (thunk (area (circle 4))) (thunk (circle-area 4)) "Circle atrea test" 1)

(run-testcase (thunk (perimeter (triangle 3))) (thunk (equilateral-triangle-perimeter 3)) "Triangle
              perimeter test" 1)

(run-testcase (thunk (perimeter (square 4))) (thunk (square-perimeter 4)) "Square perimeter test" 1)
(run-testcase (thunk (perimeter (circle 4))) (thunk (circle-perimeter 4)) "Circle perimeter test" 1)
(define test-point (rectangular 3.0 4.0))
(run-testcase (thunk (get-x test-point)) (thunk 3.0) "get-x test" 1)
(run-testcase (thunk (get-y test-point)) (thunk 4.0) "get-y test" 1)
(run-testcase
  (thunk (point-equal?
    (polar-to-rectangular (rectangular-to-polar test-point))
    test-point))
  (thunk #t)
  "conversion-equality test" 1)

(define polar-test-point (polar 5.0 2.0))
(run-testcase (thunk (get-r polar-test-point)) (thunk 5.0) "get-r test" 1)
(run-testcase (thunk (get-t polar-test-point)) (thunk 2.0) "get-t test" 1)
(run-testcase
  (thunk (point-equal?
    (rectangular-to-polar (polar-to-rectangular polar-test-point))
    polar-test-point))
  (thunk #t)
  "polar conversion-equality test" 1)

(define scores-final (map second q-list))

; TO-DO Write out.
(define output (open-output-file "final.score" #:exists 'replace))
(require "csv-write.rkt")
(write-row scores-final output)
(close-output-port output)

