#lang eopl

;REPRESENTACION PROCEDIMIENTOS

;CONSTRUCTORES

(define simple-circuit
  (lambda (in out chip)
    (lambda (signal)
    (cond
      [(= signal 0) 'simple-circuit] ;devuelve el tipo de circuito
      [(= signal 1) in] ; devuelve la entraada
      [(= signal 2) out] ; devuelve la salida
      [(= signal 3) chip]))) ; devuelve el chip
)

(define complex-circuit
  (lambda (circ lcircs in out)
    (lambda (signal)
    (cond
      [(= signal 0) 'complex-circuit] ;devuelve el tipo de circuito
      [(= signal 1) circ] ;devuelve el circuito
      [(= signal 2) lcircs] ;devuelve la lista de circuitos
      [(= signal 3) in] ;devuelve la entrada
      [(= signal 4) out]))) ;devuelve la salida
    )
    

(define prim-chip
  (lambda (chip-prim) 
    (lambda (signal)
    (cond
      [(= signal 0) 'prim-chip] ;devuelve el tipo de chip
      [(= signal 1) chip-prim]))) ;devuelve el chip primitivo
      )

(define comp-chip
  (lambda (in out circ)
    (lambda (signal)
    (cond
      [(= signal 0) 'comp-chip] ;devuelve el tipo de chip 
      [(= signal 1) in] ;devuelve la entrada
      [(= signal 2) out] ;devuelve la salida
      [(= signal 3) circ]))) ;devuelve el circuito
        )
     

(define chip-or
  (lambda (signal)
    (cond
      [(= signal 0) 'chip-or])))

(define chip-and
   (lambda (signal)
    (cond
      [(= signal 0)'chip-and])))

(define chip-not
   (lambda (signal)
    (cond
      [(= signal 0)'chip-not])))

(define chip-xor
   (lambda (signal)
    (cond
      [(= signal 0)'chip-xor])))

(define chip-nor
   (lambda (signal)
    (cond
      [(= signal 0)'chip-nor])))


;OBSERVADORES

;predicados

(define simple-circuit? ;ud es un circuito simple?
  (lambda(n)
    (equal? (n 0) 'simple-circuit)))

(define complex-circuit? ;ud es un circuito complejo?
  (lambda(n)
    (equal? (n 0) 'complex-circuit)))

(define prim-chip? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'prim-chip)))

(define comp-chip? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'comp-chip)))

(define chip-or? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'chip-or)))

(define chip-and? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'chip-and)))

(define chip-not? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'chip-not)))

(define chip-xor? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'chip-xor)))

(define chip-nor? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'chip-nor)))

(define chip-nand? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'chip-nand)))

(define chip-xnor? ;ud es un ...?
  (lambda(n)
    (equal? (n 0) 'chip-xnor)))


;extractores

(define simple-circuit->in
  (lambda(n)
    (n 1))) ; devuelve la entrada del circuito simple
(define simple-circuit->out
  (lambda(n)
    (n 2)))
(define simple-circuit->chip
  (lambda(n)
    (n 3)))
;--------------------------------

(define complex-circuit->circ
  (lambda(n)
     (n 1))) ;devuelve el circuito del circuito complejo
(define complex-circuit->lcirc
  (lambda(n)
     (n 2)))
(define complex-circuit->in
  (lambda(n)
     (n 3)))
(define complex-circuit->out ;;;;;;;;;;punto en tener en cuenta por el cadddr
  (lambda(n)
     (n 4)))
;--------------------------------

(define prim-chip->chip-prim
  (lambda(n)
    (n 1)))
;--------------------------------

(define comp-chip->in
  (lambda(n)
     (n 1)))
(define comp-chip->out
  (lambda(n)
     (n 2)))
(define comp-chip->circ
  (lambda(n)
     (n 3)))
;--------------------------------

(define chip-prim->chip-or
  (lambda(n)
     (n 0)))
(define chip-prim->chip-and
  (lambda(n)
     (n 0)))
(define chip-prim->chip-not
  (lambda(n)
     (n 0)))
(define chip-prim->chip-xor
  (lambda(n)
     (n 0)))
(define chip-prim->chip-nor
  (lambda(n)
     (n 0)))
(define chip-prim->chip-nand
  (lambda(n)
     (n 0)))
(define chip-prim->chip-xnor
  (lambda(n)
     (n 0)))

;EJEMPLOS

;1.
(define a
(comp-chip
  '(INA INB INC IND) 
  '(OUTA) 
   (complex-circuit 
      (complex-circuit
        (simple-circuit '(a b) '(e) '(prim-chip(chip-nand)))
        (list 
          (simple-circuit '(c d) '(f) '(prim-chip (chip-xor)))
        )
        '(a b c d)
        '(e f)
      )
      (list
        (simple-circuit 
          '(e f) 
          '(w) 
           (comp-chip
             '(INE INF)
             '(OUTF)
              (simple-circuit '(e f) '(g) '(prim-chip (chip-and)))
           )
        ) 
      )
      '(a b c d)
      '(w)
   )
))

;2.
(define b
  (complex-circuit (simple-circuit '(a b) '(e) '(prim-chip(chip-and)))
                   (list
                     (simple-circuit '(c d) '(f) '(prim-chip(chip-and))))
                   '(a b c d)
                   '(e f)
))
;3.
(define c
(comp-chip
    '(INA INB INC IND INE INF ING INH)
    '(OUTA OUTC OUTE OUTG)
     (complex-circuit
        (simple-circuit '(a b) '(m) '(prim-chip (chip-and)))
        (list
            (simple-circuit '(c d) '(e) '(prim-chip (chip-or)))
            simple-circuit '(e f) '(r) '(prim-chip (chip-xnor))
            simple-circuit '(g h) '(l) '(prim-chip (chip-nor))
        )
       '(a b c d e f g h)
       '(m e r l))
))
;4.
(define d (simple-circuit '(a) '(b) '(prim-chip (chip-not))))


;5.
(define e
  (complex-circuit '(simple-circuit '(a b) '(c) '(prim-chip (chip-and)))
                   (list (simple-circuit '(c) '(d) '(prim-chip (chip-not))))
                   '(a b)
                   '(d)))

