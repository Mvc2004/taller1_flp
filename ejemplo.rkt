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

; EJEMPLO 2

(chip-com
    '(INA INB INC IND INE INF ING INH)
    '(OUTA OUTC OUTE OUTG)
     (complex-circuit
        (simple-circuit '(a b) '(m) (chip-prim (chip-and)))
        (list
            (simple-circuit '(c d) '(e) (chip-prim (chip-or)))
            simple-circuit '(e f) '(r) (chip-prim (chip-and))
            simple-circuit '(g h) '(l) (chip-prim (chip-or))
        )
       '(a b c d e f g h)
       '(m e r l))
)
; EJEMPLO 3

(simple-circuit 
    '(z w) 
    '(x) 
    (chip-comp
        '(INA INB)
        '(OUTA)
         (simple-circuit '(a b) '(c) (chip-prim (chip-and)))
    )
)

; EJEMPLO 4


(simple-circuit 
    '(s o f i)
    '(e f)
    (chip-comp
        '(INA INB INC IND)
        '(OUTA OUTC)
         (complex-circuit
            (simple-circuit '(a b) '(e) (chip-prim (chip-or)))
            (list
            (simple-circuit '(c d) '(f) (chip-prim (chip-or)))
            )
            '(a b c d)
            '(e f)
         )
    )
)
    
; EJEMPLO 5
(simple-circuit '(a b) '(c) (chip-prim(chip-and)))

; EJEMPLO 6

(chip-comp
    '(INA INB)
    '(OUTA)
     (simple-circuit '(a b) '(c) (chip-prim (chip-or))))
