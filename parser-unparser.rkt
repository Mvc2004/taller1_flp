#lang racket

;; Importar los módulos con los TADs y las listas
(require "repredatatype.rkt")
(require "reprelistas.rkt")

;; Parser: Convierte una lista en un datatype de circuito
(define (parse-circuit lista)
  (match (first lista)
    ['simple-circuit
     (simple-circuit (second lista) (third lista) (parse-chip (fourth lista)))]
    ['complex-circuit
     (complex-circuit (map parse-circuit (second lista)))]))

(define (parse-chip chip-list)
  (match (first chip-list)
    ['chip-prim (chip-prim (second chip-list))]
    ['chip-comp (chip-comp (second chip-list) (third chip-list) 
                           (map parse-circuit (fourth chip-list)))]))

;; Unparser: Convierte un datatype de circuito en listas
(define (unparse-circuit circuit)
  (cases circuito circuit
    [(simple-circuit inputs outputs chip)
     `(simple-circuit ,inputs ,outputs ,(unparse-chip chip))]
    [(complex-circuit circuits)
     `(complex-circuit ,(map unparse-circuit circuits))]))

(define (unparse-chip chip)
  (cases chip chip
    [(chip-prim type) `(chip-prim ,type)]
    [(chip-comp inputs outputs circuits)
     `(chip-comp ,inputs ,outputs ,(map unparse-circuit circuits))]))

;; Ejemplosssssss

;; Crear una lista de circuito
(define lista-ejemplo
  (make-simple-circuit '(a b) '(c) '(chip-prim 'and)))

;; Parsear la lista a un TAD de circuito
(define circuito-ejemplo (parse-circuit lista-ejemplo))

;; Unparsear el circuito de vuelta a una lista
(define lista-resultado (unparse-circuit circuito-ejemplo))

(display circuito-ejemplo)
(newline)

(display lista-resultado)



; EJEMPLO 1 

(chip-com 
  '(INA INB INC IND) ;entrada
  '(OUTA) ;salida
   (complex-circuit ;1
      (complex-circuit
        (simple-circuit '(a b) '(e) (chip-prim (chip-or)))
        (list 
          (simple-circuit '(c d) '(f) (chip-prim (chip-or)))
        )
        '(a b c d)
        '(e f)
      )
      (list
        (simple-circuit 
          '(e f) 
          '(w) 
           (chip-comp
             '(INE INF)
             '(OUTF)
              (simple-circuit '(e f) '(g) (chip-prim (chip-and)))
           )
        ) 
      )
      '(a b c d)
      '(w)
   )
)