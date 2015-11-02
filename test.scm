;;;
;;; Test compat.sicp
;;;

(use gauche.test)

(test-start "compat.sicp")
(use compat.sicp)
(test-module 'compat.sicp)

;; The following is a dummy test code.
;; Replace it for your tests.
(test* "test-compat_sicp" "compat_sicp is working"
       (test-compat_sicp))

;; If you don't want `gosh' to exit with nonzero status even if
;; the test fails, pass #f to :exit-on-failure.
(test-end :exit-on-failure #t)




