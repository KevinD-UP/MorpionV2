let matrix_map (f: 'a -> 'b) (m: 'a Matrix.t): 'b Matrix.t =
  Matrix.init (m |> Matrix.size) (fun (i, j) -> f (Matrix.get m (i, j)))
;;

let gagnant_dim_2 (plateau : plateau): int option =
  let res = matrix_map gagnant_dim_1 plateau in
  gagnant_dim_1 res
;;

let termine_dim_2 (plateau : plateau) : bool =
  gagnant_dim_2 plateau <> None 
;;
