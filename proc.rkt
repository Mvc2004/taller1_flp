#lang racket

;; Procedimientos de manipulación para circuitos en listas

;; Procedimiento para invertir las entradas de un circuito
(define (invertir-inputs circuit)
  (let ([inputs (get-inputs circuit)])
    (make-simple-circuit (reverse inputs) (get-outputs circuit) (get-chip circuit))))

;; Procedimiento para duplicar las salidas de un circuito
(define (duplicar-outputs circuit)
  (let ([outputs (get-outputs circuit)])
    (make-simple-circuit (get-inputs circuit) (append outputs outputs) (get-chip circuit))))

;; tambien me lo dio chat para ponerlo en los test jijijiji
(define circuito-invertido (invertir-inputs '(simple-circuit (a b) (c) (chip-prim 'and))))
(display circuito-invertido)
(newline)

(define circuito-duplicado (duplicar-outputs '(simple-circuit (a b) (c) (chip-prim 'and))))
(display circuito-duplicado)
(newline)
