open Ast

let continuous lo hi = TReal (Continuous (Some lo, Some hi))
let discrete lo hi = TReal (Discrete (Some lo, Some hi))
let real = TReal (Continuous (None,None))
let bool = TBool None
let int = TReal (Discrete (None,None))
let real' = TReal (Continuous (Some 0.0, None))
let int' = TReal (Discrete (Some 0, None))

let boolT = EConst (Bool true)
let boolF = EConst (Bool false)
let litB b = EConst (Bool b)
let litR r = EConst (Real r)
let litI n = EConst (Int n)
let zero = litI 0
let one = litI 1
let neg e = EUnaryOp (Neg,e)
let not e = EUnaryOp (Not,e)
let ( + ) e1 e2 = EBinaryOp (Plus,e1,e2)
let ( - ) e1 e2 = EBinaryOp (Minus,e1,e2)
let ( * ) e1 e2 = EBinaryOp (Mult,e1,e2)
let ( || ) e1 e2 = EBinaryOp (Or,e1,e2)
let ( && ) e1 e2 = EBinaryOp (And,e1,e2)

let propT = CBoolVal true
let propF = CBoolVal false
let isTrue e = CIsTrue e
let ( == ) e1 e2 = CNumRel (Equal,e1,e2)
let ( <= ) e1 e2 = CNumRel (Lte,e1,e2)
let ( >= ) e1 e2 = CNumRel (Gte,e1,e2)
let disj cs = CPropOp (Disj,cs)
let conj cs = CPropOp (Conj,cs)
let exists (x',t) c = match x' with (EVar x) -> CQuant (Exists,x,t,c) | _ -> assert false

let where = 0
let subject_to = 0

let optimize d e ctxt c = 
  let ctxt' = List.map (function (EVar x,t) -> (x,t) | _ -> assert false) ctxt in
    PMain (d,ctxt',e,c)

let minimize e _ ets _ c = optimize Min e ets c
let maximize e _ ets _ c = optimize Max e ets c

let name x = EVar (Id.make x)

let sum = function (x::xs) -> List.fold_left (+) x xs | _ -> assert false
let ( <*> ) xs ys = List.map2 ( * ) xs ys
