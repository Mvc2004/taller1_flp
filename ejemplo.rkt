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