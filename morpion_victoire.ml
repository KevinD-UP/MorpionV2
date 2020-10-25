let ligne (m : 'a Matrix.t) (i : int) : 'a list =
  let size = Matrix.size m in
  let rec ligne_aux acc currJ =
    if currJ = size then acc
    else ligne_aux (Matrix.get m (i,currJ)::acc) (currJ+1)
  in 
  ligne_aux [] 0 |> List.rev
;;

let colonne (m : 'a Matrix.t) (j : int) : 'a list =
  let size = Matrix.size m in
  let rec ligne_aux acc currI =
    if currI = size then acc
    else ligne_aux (Matrix.get m (currI,j)::acc) (currI+1)
  in 
  ligne_aux [] 0 |> List.rev 
;;

let diagonale (m : 'a Matrix.t) (k : int) : 'a list =
  let size = Matrix.size m in 
  let rec diagonal_aux_1 acc currI currJ = 
    if currI = size then acc
    else diagonal_aux_1 (Matrix.get m (currI, currJ)::acc) (currI+1) (currJ+1) in
  let rec diagonal_aux_2 acc currI currJ =
    if currI = size then acc
    else diagonal_aux_2 (Matrix.get m (currI, currJ)::acc) (currI+1) (currJ-1) in 
  if k = 0 then diagonal_aux_1 [] 0 0 |> List.rev
  else diagonal_aux_2 [] 0 (size-1) |> List.rev
;;

let rec valeur_constante (l : 'a option list) : 'a option =
  match l with 
  | [] -> None 
  | [a] -> a
  | x::y::t -> if x = y then valeur_constante (y::t) else None
;;

let gagnant_lignes (m : 'a option Matrix.t) : 'a option =
  let size = Matrix.size m in
  let rec gagnant_ligne_aux currI =
    if currI = size then None
    else 
      let res = ligne m currI |> valeur_constante in 
      if res <> None then res
      else gagnant_ligne_aux (currI+1) 
  in
  gagnant_ligne_aux 0
;;

let gagnant_colonnes (m : 'a option Matrix.t) : 'a option =
  let size = Matrix.size m in
  let rec gagnant_colonnes_aux currJ =
    if currJ = size then None
    else 
      let res = colonne m currJ |> valeur_constante in 
      if res <> None then res
      else gagnant_colonnes_aux (currJ+1) 
  in
  gagnant_colonnes_aux 0
;;

let gagnant_diagonales (m : 'a option Matrix.t) : 'a option =
  let res = diagonale m 0 |> valeur_constante in
  if res <> None then res 
  else diagonale m 1 |> valeur_constante
;;

let gagnant (m : 'a option Matrix.t) : 'a option =
  let win_line = gagnant_lignes m in
  let win_column = gagnant_colonnes m in
  let win_diag = gagnant_diagonales m in
  if win_line <> None then win_line
  else if win_column <> None then win_column
  else win_diag 
;;

let termine (m : 'a option Matrix.t) : bool = 
  let winner = gagnant m in
  if winner <> None then true
  else false
;;
