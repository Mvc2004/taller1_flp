#lang racket

;; Representación de circuitos en listas

;; Constructor para un circuito simple
(define (make-simple-circuit inputs outputs chip)
  `(simple-circuit ,inputs ,outputs ,chip))

;; Constructor para un circuito compuesto
(define (make-complex-circuit circuits)
  `(complex-circuit ,circuits))

;; Observadores para listas

(define (get-inputs circuit)
  (second circuit))

(define (get-outputs circuit)
  (third circuit))

(define (get-chip circuit)
  (fourth circuit))

;;este ejemplo me lo dio chat para ponerlo en los test jiji
(define lista-circuito-simple
  (make-simple-circuit '(a b) '(c) '(chip-prim 'and)))

(display lista-circuito-simple)
(newline)
