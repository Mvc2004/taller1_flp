#lang eopl

;REPRESENTACION DATATYPE

(define-datatype circuito circuito?
  (simple-circuit (in list?)
                  (out list?)
                  (chip chip? ))
  
  (complex-circuit (circ circuito?)
                   (lcirc list?)
                   (in list?)
                   (out list?)))

(define-datatype chip chip?
  
  (prim-chip(chip-prim chip-prim?))
  
  (comp-chip(in list?)
             (out list?)
             (circ circuito?)))

(define-datatype chip-prim chip-prim?
  (chip-or)
  (chip-and)
  (chip-not)
  (chip-xor)
  (chip-nor)
  (chip-nand)
  (chip-xnor))


;EJEMPLOS

;1.
(define a
  (simple-circuit 
    '(z w) 
    '(x) 
    (comp-chip
        '(INA INB)
        '(OUTA)
         (simple-circuit '(a b) '(c) (prim-chip (chip-and))))))
;2.
(define b
  (simple-circuit 
    '(s o f i)
    '(e f)
    (comp-chip
        '(INA INB INC IND)
        '(OUTA OUTC)
         (complex-circuit
            (simple-circuit '(a b) '(e) (prim-chip (chip-or)))
            (list
            (simple-circuit '(c d) '(f) (prim-chip (chip-or)))
            )
            '(a b c d)
            '(e f)))))

;3
(define c
  (comp-chip
    '(INA INB)
    '(OUTA)
     (simple-circuit '(a b) '(c) (prim-chip (chip-or)))))

;4.
(define d
  (comp-chip
   '(INA)
   '(OUTA)
    (complex-circuit
     (simple-circuit '(a) '(b) (prim-chip (chip-not)))
     (list
      (simple-circuit '(b) '(c) (prim-chip (chip-not))))
     '(a)
     '(c))))
;5
(define e
  (complex-circuit
   (simple-circuit '(a b) '(c) (prim-chip (chip-xnor)))
   (list
    (simple-circuit '(c) '(e) (comp-chip '(INA) '(OUTA) (simple-circuit '(c) '(d) (prim-chip (chip-not))))))
   '(a b)
   '(e)))