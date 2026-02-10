#!/bin/bash

local=$(pwd)

rm -rf s2d
mkdir -p s2d
outputdir=$local/s2d

rm -fr borrar
mkdir -p borrar

cd borrar

fasta=all-aligned
cp $local/alignement/$fasta.fasta2 .

format=stride-ss

nprot=$(ls -1q $local/data-$format/*.$format | wc -l)

echo "Number of proteins = "$nprot


cat <<EOF > input.in
$fasta.fasta2
$format
EOF


cp $local/data-$format/* .


$local/fortran/distancias_pLDDT_aligned/distancias_pLDDT_aligned.exe < input.in > output.log

mv distancias.meg $outputdir/distancias-$fasta-$format.meg
# cp distancias.dat $outputdir/distancias-$fasta-$format.dat
awk {'print $1'} distancias.dat > c1.dat
awk {'print $2'} distancias.dat > c2.dat
awk {'print $3'} distancias.dat > c3.dat

paste -d" " c1.dat c2.dat c3.dat > $outputdir/distancias-$fasta-$format.dat


# mv distancias-2.meg $outputdir/distancias-$fasta-$format-2.meg
# cp distancias-2.dat $outputdir/distancias-$fasta-$format-2.dat
# mv comparaciones.dat $outputdir
# mv distancias-phylo-poisson.dat $outputdir
# mv s2.dat $outputdir

mkdir -p $outputdir/aligned
mv *aligned $outputdir/aligned

# Datos estadisticos

# mv fort.60 borrar.dat

# $SCRIPT/medias_col.sh borrar 1 1.

# media=$(awk {'print $1'} fort.100)
# des=$(awk {'print $1'} fort.110)
# echo "Numero de residuos = "$media" +- "$des > $outputdir/info.dat

# awk {'print $3" "$6" "$7" "$8" "$9" "'} distancias.dat > datos.dat

# $SCRIPT/medias_col.sh datos 5 1.

# media=$(awk {'print $2'} fort.100)
# des=$(awk {'print $2'} fort.110)
# echo "Num. residuos alineados = "$media" +- "$des >> $outputdir/info.dat

# media=$(awk {'print $1'} fort.100)
# des=$(awk {'print $1'} fort.110)
# echo "Diferencia ss (%) = "$media" +- "$des >> $outputdir/info.dat

# media=$(awk {'print $3'} fort.100)
# des=$(awk {'print $3'} fort.110)
# echo "Num. residuos coincidentes con ss C(oil) = "$media" +- "$des >> $outputdir/info.dat

# media=$(awk {'print $4'} fort.100)
# des=$(awk {'print $4'} fort.110)
# echo "Num. residuos coincidentes con ss no C(oil) = "$media" +- "$des >> $outputdir/info.dat

# media=$(awk {'print $5'} fort.100)
# des=$(awk {'print $5'} fort.110)
# echo "Num. residuos con ss diferente = "$media" +- "$des >> $outputdir/info.dat





cd ..

rm -r borrar



