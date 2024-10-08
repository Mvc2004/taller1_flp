#lang eopl

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
  
  (comp-chip (in list?)
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


;---------------------------------

;EJEMPLOS DE CIRCUITOS CON SINTAXIS CONCRETA

;1.
(define a
  '(simple-circuit 
    (z w) 
    (x) 
    (comp-chip
        (INA INB)
        (OUTA)
         (simple-circuit (a b) (c) (prim-chip (chip-and))))))

;2.
(define b
  '(simple-circuit 
    (s o f i)
    (e f)
    (comp-chip
        (INA INB INC IND)
        (OUTA OUTC)
         (complex-circuit
            (simple-circuit (a b) (e) (prim-chip (chip-or)))
            (list
            (simple-circuit (c d) (f) (prim-chip (chip-or)))
            )
            (a b c d)
            (e f)))))
;3
(define c
  '(comp-chip
    (INA INB)
    (OUTA)
     (simple-circuit (a b) (c) (prim-chip (chip-or)))))

;4.
(define d
  '(comp-chip
   (INA)
   (OUTA)
    (complex-circuit
     (simple-circuit (a) (b) (prim-chip (chip-not)))
     (list
      (simple-circuit (b) (c) (prim-chip (chip-not))))
     (a)
     (c))))
;5
(define e
  '(complex-circuit
   (simple-circuit (a b) (c) (prim-chip (chip-xnor)))
   (list
    (simple-circuit (c) (e) (comp-chip (INA) (OUTA) (simple-circuit (c) (d) (prim-chip (chip-not))))))
   (a b)
   (e)))


;PARSE: de sintaxis concretas a sintaxis abstracta

(define parse
  (lambda (circuito)
    (cond
      [(eqv? (car circuito) 'simple-circuit) 
        (simple-circuit
         (cadr circuito)  
         (caddr circuito)
         (parse (cadddr circuito)))]
      
      [(eqv? (car circuito) 'complex-circuit) 
         (complex-circuit
          (parse (cadr circuito))
          (caddr circuito)
          (cadddr circuito)
          (cddddr circuito))]
      
          [(eqv? (car circuito) 'prim-chip) ;contrcutores y predicados
          (prim-chip
           (parse (cadr circuito)))]
         
         [(eqv? (car circuito) 'comp-chip) ;contrcutores y predicados
          (comp-chip
           (cadr circuito)
           (caddr circuito)
           (parse (cadddr circuito)))]
          
         [(eqv? (car circuito) 'chip-or) (chip-or)]
         [(eqv? (car circuito) 'chip-and) (chip-and)]
         [(eqv? (car circuito) 'chip-not) (chip-not)]
         [(eqv? (car circuito) 'chip-xor) (chip-xor)]
         [(eqv? (car circuito) 'chip-nor) (chip-nor)]
         [(eqv? (car circuito) 'chip-nand) (chip-nand)]
         [(eqv? (car circuito) 'chip-xnor) (chip-xnor)]
        
        
  )
 )
)
(define r (simple-circuit '(a b) '(c) (prim-chip(chip-and))))



;; UNPARSE: de sintaxis abstracta a concreta
(define unparse
  (lambda (value)
    (cases circuito value
      [(simple-circuit in out chip)
       (list 'simple-circuit in out (unparse-chip chip))]
      [(complex-circuit circ lcirc in out)
       (list 'complex-circuit (unparse circ) lcirc in out)]
      ;; Cláusula else debe estar siempre al final
      [else (error "Unparse error: valor inesperado para circuito" value)])))  ;; else al final

(define unparse-chip
  (lambda (chip-value)
    (cases chip chip-value
      [(prim-chip chip-prim)
       (list 'prim-chip (unparse-chip-prim chip-prim))]
      [(comp-chip in out circ)
       (list 'comp-chip in out (unparse circ))]
      ;; Cláusula else debe estar siempre al final
      [else (error "Unparse error: valor inesperado para chip" chip-value)])))  ;; else al final

(define unparse-chip-prim
  (lambda (chip-prim-value)
    (cases chip-prim chip-prim-value
      [(chip-or) 'chip-or]
      [(chip-and) 'chip-and]
      [(chip-not) 'chip-not]
      [(chip-xor) 'chip-xor]
      [(chip-nor) 'chip-nor]
      [(chip-nand) 'chip-nand]
      [(chip-xnor) 'chip-xnor]
      ;; Cláusula else debe estar siempre al final
      [else (error "Unparse error: valor inesperado para chip-prim" chip-prim-value)])))  ;; else al final

















#|
;; Ejemplos
;; Ejemplo de uso
;; Evaluar el parseo y el desparseo
(let ([parsed-circuit (parse e)])
  (display parsed-circuit)
  (newline)
  (display (unparse parsed-circuit)))

;; Ejemplo simple de parseo de sintaxis concreta a abstracta
(define circuito-abstracto (parse e))
(display "Sintaxis abstracta del circuito simple:")
(display circuito-abstracto)
(newline)

;; Ejemplo de parseo inverso (unparse) de sintaxis abstracta a concreta
(define circuito-concreto (unparse circuito-abstracto))
(display "Sintaxis concreta recuperada del circuito simple:")
(display circuito-concreto)
(newline)

;; Ejemplo complejo
(define circuito-complejo-abstracto (parse x))
(display "Sintaxis abstracta del circuito complejo:")
(display circuito-complejo-abstracto)
(newline)

;; Parse inverso del circuito complejo
(define circuito-complejo-concreto (unparse circuito-complejo-abstracto))
(display "Sintaxis concreta recuperada del circuito complejo:")
(display circuito-complejo-concreto)
(newline)
|#