;;
;; Gauche-compat-sicp package description
;;

(define-gauche-package "Gauche-compat-sicp"
  :repository "https://github.com/practical-scheme/Gauche-compat-sicp.git"
  :version "1.1"
  :description "Compatibility module to run SICP exercises\n\
                This packages adds several primitives assumed by SICP\n\
                excercises."
  :require (("Gauche" (>= "0.9.12")))
  :providing-modules (compat.sicp)
  :authors ("Shiro Kawai <shiro@acm.org>")
  :maintainers ()
  :licenses ("BSD")
  :homepage "https://practical-scheme.net/gauche"
  )
