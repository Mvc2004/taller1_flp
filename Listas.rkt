#lang eopl

;REPRESENTACION LISTAS


;CONSTRUCTORES

(define simple-circuit
  (lambda (in out chip)
    (list 'simple-circuit in out chip)))

(define complex-circuit
  (lambda (circ lcircs in out)
    (list 'complex-circuit circ lcircs in out)))

(define prim-chip
  (lambda (chip-prim)
    (list 'prim-chip chip-prim)))

(define comp-chip
  (lambda (in out circ)
    (list 'comp-chip in out circ)))

(define chip-or
  (list 'chip-or))

(define chip-and
   (list 'chip-and))

(define chip-not
   (list 'chip-not))

(define chip-xor
   (list 'chip-xor))

(define chip-nor
   (list 'chip-nor))



;OBSERVADORES

;predicados
(define simple-circuit? ;ud es un circuito simple?
  (lambda(n)
    (equal? (car n) 'simple-circuit)))

(define complex-circuit? ;ud es un circuito complejo?
  (lambda(n)
    (equal? (car n) 'complex-circuit)))

(define prim-chip? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'prim-chip)))

(define comp-chip? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'comp-chip)))

(define chip-or? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'chip-or)))

(define chip-and? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'chip-and)))

(define chip-not? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'chip-not)))

(define chip-xor? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'chip-xor)))

(define chip-nor? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'chip-nor)))

(define chip-nand? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'chip-nand)))

(define chip-xnor? ;ud es un ...?
  (lambda(n)
    (equal? (car n) 'chip-xnor)))

;extractores

(define simple-circuit->in
  (lambda(n)
    (cadr n)))
(define simple-circuit->out
  (lambda(n)
    (caddr n)))
(define simple-circuit->chip
  (lambda(n)
    (cadddr n)))
;--------------------------------

(define complex-circuit->circ
  (lambda(n)
     (cadr n)))
(define complex-circuit->lcirc
  (lambda(n)
     (caddr n)))
(define complex-circuit->in
  (lambda(n)
     (cadddr n)))
(define complex-circuit->out 
  (lambda(n)
     (cddddr n)))
;--------------------------------

(define prim-chip->chip-prim
  (lambda(n)
    (cadr n)))
;--------------------------------

(define comp-chip->in
  (lambda(n)
     (cadr n)))
(define comp-chip->out
  (lambda(n)
     (caddr n)))
(define comp-chip->circ
  (lambda(n)
     (cadddr n)))
;--------------------------------

(define chip-prim->chip-or
  (lambda(n)
     (car n)))
(define chip-prim->chip-and
  (lambda(n)
     (car n)))
(define chip-prim->chip-not
  (lambda(n)
     (car n)))
(define chip-prim->chip-xor
  (lambda(n)
     (car n)))
(define chip-prim->chip-nor
  (lambda(n)
     (car n)))
(define chip-prim->chip-nand
  (lambda(n)
     (car n)))
(define chip-prim->chip-xnor
  (lambda(n)
     (car n)))


;EJEMPLOS

;1
(define a (simple-circuit '(a b) '(c) '(prim-chip(chip-nand))))

;2.
(define b
  (comp-chip '(INA INB) '(OUTA)
             '(list (prim-chip(chip-and)
                   (prim-chip(chip-xor))))))
;3.
(define c
  (complex-circuit '(simple-circuit '(a b) '(g) '(prim-chip(chip-xor)))
   '(list (simple-circuit '(c d) '(h) '(prim-chip(chip-or)))
         (simple-circuit '(e f) '(i) '(prim-chip(chip-or))))
  '(a b c d e f)
  '(g h i)
  ))


;4.
(define d
  (complex-circuit '(simple-circuit '(a b) '(e) '(prim-chip(chip-and)))
                   '(list
                     (simple-circuit '(c d) '(f) '(prim-chip(chip-and))))
                   '(a b c d)
                   '(e f)
))                                

;5.
(define e
  (comp-chip '(INA INB) '(OUTA) '(simple-circuit '(a b) '(c) '(prim-chip()chip-xor))))