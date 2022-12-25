;;;
;;; Test compat.sicp
;;;

(use gauche.test)

(test-start "compat.sicp")
(use compat.sicp)
(test-module 'compat.sicp)

(test-end :exit-on-failure #t)
