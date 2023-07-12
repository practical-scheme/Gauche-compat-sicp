;;;
;;;  compat.sicp - some compatibility routines for those learning SICP
;;;

(define-module compat.sicp
  (use srfi.27)
  (use control.pmap)
  (use gauche.threads)
  (export nil runtime true random false get put get-coercion put-coercion
          parallel-execute test-and-set!
          cons-stream the-empty-stream stream-null?
          user-initial-environment extend))
(select-module compat.sicp)

;; This doesn't make nil as a boolean false, but in SICP nil is exclusively
;; used to denote an empty list, so it's ok.
(define nil '())

;; Exercise 1.22
(define (runtime)
  (round->exact (* (expt 10 6)
                   (time->seconds (current-time)))))

;; Section 1.2
;; random returns inexact number when the arg is inexact (per SRFI-216)
(define true #t)
(define (random n)
  (assume-type n <real>)
  (assume (> n 0))
  (if (exact-integer? n)
    (random-integer n)
    (inexact (random-integer (ceiling->exact n)))))

;; Section 2.3
;; Boolean false
(define false #f)

;; Section 2.4
;; Symbol properties - a naive implementation
(define *properties* (make-hash-table 'eq?))

(define (put op type item)
  (hash-table-update! *properties* op (^p (assoc-set! p type item)) '()))
(define (get op type)
  (assoc-ref (hash-table-get *properties* op '()) type #f))

;; Section 2.5

(define *coercions* (make-hash-table 'equal?))

(define (put-coercion from to proc)
  (hash-table-put! *coercions* (cons from to) proc))
(define (get-coercion from to)
  (hash-table-get *coercions* (cons from to) #f))

;; Section 3.4.2
(define (parallel-execute thunk1 . thunks)
  (pmap (^p (p)) (cons thunk1 thunks) (make-fully-concurrent-mapper))
  (undefined))

(define *global-lock* (make-mutex))     ;for test-and-set!

(define (test-and-set! cell)
  (assume cell <pair>)
  (with-locking-mutex *global-lock*
    (^[] (if (car cell)
           #t
           (begin (set! (car cell) #t) #f)))))

;; Section 3.5.1

(define-syntax cons-stream
  (syntax-rules ()
    [(_ a d) (cons a (delay d))]))

(define the-empty-stream '#:the-empty-stream)
(define (stream-null? obj) (eq? obj the-empty-stream))

;; Section 4.1.5
(define user-initial-environment (interaction-environment))

;; Section 4.4.4
;; 'Extend' is bound to a syntax in Gauche's default environment, which
;; may interfere with extend-if-consistent code; unless the user defines
;; their own extend first, the compiler refers to the Gauche's extend and
;; raises an error.   We export a dummy 'extend' binding so that
;; the user won't be confused.
(define extend list)
