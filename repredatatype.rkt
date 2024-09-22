#lang racket

;; Definir chips y circuitos como tipos abstractos de datos (TAD)

;; Chips: primitivos y compuestos
(define-datatype chip
  [chip-prim (type symbol?)]   ; Chip primitivo: AND, OR, tatata.
  [chip-comp (input list?)     ; Chip compuesto: entradas, salidas y subcircuitos
             (output list?)
             (circuits list?)])

;; Circuitos: simples y compuestos
(define-datatype circuito
  [simple-circuit (input list?)
                  (output list?)
                  (chip chip?)]  ; Circuito simple con un chip
  [complex-circuit (circuits list?)] ; Circuito complejo con múltiples subcircuitos
)

;; Ejemplos 


;; Chip primitivo: AND
(define chip-and (chip-prim 'and))

;; Circuito simple con un chip AND
(define circuito-simple
  (simple-circuit '(a b) '(c) chip-and))

;; esto muestra los  ejemplos
(display circuito-simple)
(newline)

