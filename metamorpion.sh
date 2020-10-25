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
if [ -e 7.3_metamorpion_debut.ml ]; then
    cp -f 7.3_metamorpion_debut.ml metamorpion_debut.ml
fi
if [ -e 7.4_metamorpion_victoire.ml ]; then
    cp -f 7.4_metamorpion_victoire.ml metamorpion_victoire.ml
fi
mkdir -p _build
cp -f *.mli *.ml _build/
cd _build
ocamlc -c matrix.mli matrix.ml morpion_prelude.ml
ocamlc -c -open Morpion_prelude -c morpion_debut.ml morpion_victoire.ml
ocamlc -c metamorpion_prelude.ml
ocamlc -c -open Metamorpion_prelude -c metamorpion_debut.ml metamorpion_victoire.ml
ocamlc $GRAPHICS -c -pp 'tr "a-z%" "n-za-m " <' metamorpion_imperatif.ml
ocamlc $GRAPHICS graphics.cma matrix.cmo morpion_prelude.cmo \
       morpion_debut.cmo morpion_victoire.cmo metamorpion_prelude.cmo \
       metamorpion_debut.cmo metamorpion_victoire.cmo metamorpion_imperatif.cmo \
       -o metamorpion.byte
./metamorpion.byte
