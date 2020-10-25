let plateau_initial (taille : int) : plateau =
  Matrix.init taille (fun (x, y) -> None)
;;

let coup_legal (plateau : plateau) (coup : coup) : bool =
  let x, y = coup.position and size = plateau |> Matrix.size in
  x >= 0 
  && y >= 0 
  && x < size
  && y < size 
  && Matrix.get plateau coup.position = None 
;;

let coup_des_coordonnees_absolues
    (plateau : plateau)
    (dernier_coup : coup option)
    (nb_joueurs : int)
    (x , y : int*int)
  : coup option =
  match dernier_coup with
  | None -> 
      (let res = {joueur = 0; position = (x, y)} in 
       if coup_legal plateau res then Some res else None)
  | Some dernier_coup -> 
      (let res = {joueur = nb_joueurs - dernier_coup.joueur - 1; position = (x, y)} in 
       if coup_legal plateau res then Some res else None)
;;
