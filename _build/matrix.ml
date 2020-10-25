type 'a t = 'a array array

let init taille f =
    if taille = 0 then [||] else
      let m = Array.make_matrix taille taille (f (0,0)) in
      for i = 0 to taille - 1 do
        for j = 0 to taille - 1 do
          if i > 0 || j > 0 then
            m.(i).(j) <- f (i,j)
        done
      done;
      m

let get m (i, j) = m.(i).(j)

let size m = Array.length m

let set m (i,j) v = m.(i).(j) <- v
