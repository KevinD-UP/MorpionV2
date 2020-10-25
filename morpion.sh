#!/bin/sh

if [ -e $(ocamlc -where)/graphics.cma ]; then
    GRAPHICS=""
else
    GRAPHICS="-I $(ocamlfind query graphics)"
fi
    
set -e
if [ -e 7.1_morpion_debut.ml ]; then
    cp -f 7.1_morpion_debut.ml morpion_debut.ml
fi
if [ -e 7.2_morpion_victoire.ml ]; then
    cp -f 7.2_morpion_victoire.ml morpion_victoire.ml
fi
mkdir -p _build
cp -f *.mli *.ml _build/
cd _build
ocamlc -c matrix.mli matrix.ml morpion_prelude.ml
ocamlc -c -open Morpion_prelude morpion_debut.ml morpion_victoire.ml
ocamlc $GRAPHICS -c -pp 'tr "a-z%" "n-za-m " <' morpion_imperatif.ml
ocamlc $GRAPHICS graphics.cma matrix.cmo morpion_prelude.cmo \
  morpion_debut.cmo morpion_victoire.cmo morpion_imperatif.cmo -o morpion.byte
./morpion.byte
