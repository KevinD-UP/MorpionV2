let plateau_initial (taille : int) : plateau = 
  Matrix.init taille (fun (i, j) -> Matrix.init taille (fun (x, y) -> None))
;;

let sous_morpion_valide
    (plateau : plateau)
    (dernier_coup : coup option)
    ((i,j) : int * int)
  : bool =
  match dernier_coup with
  | None -> true
  | Some coup -> 
      let x, y = coup.position_dim_1 in
      not (termine_dim_1 (Matrix.get plateau (i,j)))
      && i = x
      && j = y
;;

let coup_legal
    (plateau : plateau)
    (dernier_coup : coup option)
    (coup : coup)
  : bool = 
  let x_dim1, y_dim1 = coup.position_dim_1 
  and x_dim2, y_dim2 = coup.position_dim_2 
  and size = Matrix.size plateau in
  if x_dim1 >= 0 && y_dim1 >= 0 
     && x_dim1 < size
     && y_dim1 < size then 
    match dernier_coup with
    | None -> true
    | Some x -> 
        let coup1, coup2 = x.position_dim_1 in
        let sous_plateau = Matrix.get plateau (coup1, coup2) in 
        if Matrix.get sous_plateau (x_dim1, y_dim1) = None 
        && sous_morpion_valide plateau dernier_coup (x_dim2 , y_dim2) then true
        else false
  else false
;;

let coup_des_coordonnees_absolues
    (plateau : plateau)
    (dernier_coup : coup option)
    (nb_joueurs : int)
    ((x,y) : int * int)
  : coup option = 
  let size = Matrix.size plateau * Matrix.size plateau in
  match dernier_coup with
  | None -> 
      (let res = {joueur = 0;
                  position_dim_2 = (size-1, size-1);
                  position_dim_1 = (x, y)} in 
       if x >= 0 && y >= 0 && x < size && y < size
       then Some res else None)
  | Some coup -> 
      ( let x_dim1, y_dim1 = coup.position_dim_1 in
        let res = {joueur = nb_joueurs - coup.joueur - 1;
                   position_dim_2 = (x_dim1, y_dim1);
                   position_dim_1 = (x,y)} in 
        if  x >= 0 && y >= 0 && x < size && y < size
        then Some res else None)
;;

