#!/bin/bash

# cif files must be in data-cif directory

local=$(pwd)

rm -rf data-stride-ss
rm -rf data-pdb
rm -rf data-pLDDT
rm -rf data-fasta

mkdir -p data-pdb 
mkdir -p data-stride-ss
mkdir -p data-pLDDT
mkdir -p data-fasta

rm -rf borrar
mkdir borrar

# extracting pdb/pLDDT files 

echo "-----------------  Generating pdb/pLDDT/fasta files "

cd $local/data-cif

for entry in *.cif
do

    name="${entry%.*}"

    # echo $entry" "$filename

    cif2pdb $entry > $local/data-pdb/$name.pdb

    cif2csv $entry > $local/borrar/$name.csv

    echo $name >> $local/borrar/listacif.dat
    
done

cd $local/borrar

while IFS= read -r entry; do

    grep CA $entry.csv |grep ATOM | sed 's/,/" "/g' | sed 's/\"/ /g' |awk {'print $15'} | nl > $local/data-pLDDT/$entry.pLDDT

    cat  $local/data-pdb/$entry.pdb | awk '/ATOM/ && $3 == "CA" && $5 == "A" {print $4}' | tr '\n' ' ' | sed 's/ALA/A/g;s/CYS/C/g;s/ASP/D/g;s/GLU/E/g;s/PHE/F/g;s/GLY/G/g;s/HIS/H/g;s/ILE/I/g;s/LYS/K/g;s/LEU/L/g;s/MET/M/g;s/ASN/N/g;s/PRO/P/g;s/GLN/Q/g;s/ARG/R/g;s/SER/S/g;s/THR/T/g;s/VAL/V/g;s/TRP/W/g;s/TYR/Y/g' | sed 's/ //g' | fold -w 60 > $local/data-fasta/$entry.fasta
    cat  $local/data-pdb/$entry.pdb | awk '/ATOM/ && $3 == "CA" && $5 == "A" {print $4}' | tr '\n' ' ' | sed 's/ALA/A/g;s/CYS/C/g;s/ASP/D/g;s/GLU/E/g;s/PHE/F/g;s/GLY/G/g;s/HIS/H/g;s/ILE/I/g;s/LYS/K/g;s/LEU/L/g;s/MET/M/g;s/ASN/N/g;s/PRO/P/g;s/GLN/Q/g;s/ARG/R/g;s/SER/S/g;s/THR/T/g;s/VAL/V/g;s/TRP/W/g;s/TYR/Y/g' | sed 's/ //g' > $local/data-fasta/$entry.fasta2
    echo >> $local/data-fasta/$entry.fasta
    echo >> $local/data-fasta/$entry.fasta2
    sed  -i "1i >$entry"  $local/data-fasta/$entry.fasta
    sed  -i "1i >$entry"  $local/data-fasta/$entry.fasta2
    
done < listacif.dat


# Generating stride-ss files

echo "-------------------- Generating stride-ss files"


 cat <<EOF >aux.in
aux3.dat
aux.pLDDT
EOF

while IFS= read -r entry; do

  cp $local/data-pdb/$entry.pdb aux.pdb
  cp $local/data-pLDDT/$entry.pLDDT aux.pLDDT

  $STRIDE/stride aux.pdb | grep ASG | awk {'print $6'} > aux3.dat

  cp aux3.dat $local/data-stride-ss/$entry.stride-ss0
  
  # $PROGRAMAS/confirmacion_ss/confirmacion_ss.exe < aux.in
  $local/fortran/confirmacion_ss/confirmacion_ss.exe < aux.in
 
  mv fort.50 aux3.dat
  mv fort.60 $local/data-stride-ss/$entry.data
  echo $entry
  
  ss=''
  while IFS= read -r line; do

      ss=$ss$line

      echo $line >>  $local/data-stride-ss/$entry.stride-ss

      if [ "$line" = "H" ]
      then
	  p=1
      fi
      if [ "$line" = "C" ]
      then
	  p=0
      fi
      if [ "$line" = "E" ]
      then
	  p=2
      fi
      if [ "$line" = "G" ]
      then
	  p=3
      fi
      if [ "$line" = "I" ]
      then
	  p=4
      fi
      if [ "$line" = "B" ] || [ "$line" = "b" ]
      then
	  p=5
      fi
      if [ "$line" = "T" ]
      then
	  p=6
      fi

      echo $p >> $local/data-stride-ss/$entry.stride-ss3
      
  done < aux3.dat

  printf '%s\n' "$ss" > $local/data-stride-ss/$entry.stride-ss2

mv $local/data-stride-ss/$entry.stride-ss $local/data-stride-ss/aux.dat
nl $local/data-stride-ss/aux.dat > $local/data-stride-ss/$entry.stride-ss
rm $local/data-stride-ss/aux.dat
 
mv $local/data-stride-ss/$entry.stride-ss0 $local/data-stride-ss/aux.dat
nl $local/data-stride-ss/aux.dat > $local/data-stride-ss/$entry.stride-ss0
rm $local/data-stride-ss/aux.dat
 
mv $local/data-stride-ss/$entry.stride-ss3 $local/data-stride-ss/aux.dat
nl $local/data-stride-ss/aux.dat > $local/data-stride-ss/$entry.stride-ss3
rm $local/data-stride-ss/aux.dat
 
done < listacif.dat



# estadistica

# awk {'print $2'}  $local/data-stride-ss/*.data > length.dat
# awk {'print $4'}  $local/data-stride-ss/*.data > estruc-before.dat
# awk {'print $6'}  $local/data-stride-ss/*.data > estruc-after.dat
# awk {'print $8'}  $local/data-stride-ss/*.data > coil-before.dat
# awk {'print $10'}  $local/data-stride-ss/*.data > coil-after.dat

# $SCRIPT/medias_col.sh length 1 1.
# med=$(awk {'print $2'} fort.45)
# des=$(awk {'print $3'} fort.45)

# echo "Length "$med" +- "$des > $local/data-stride-ss/statistic.dat

# $SCRIPT/medias_col.sh estruc-before 1 1.
# med=$(awk {'print $2'} fort.45)
# des=$(awk {'print $3'} fort.45)

# echo "with-estruct-before "$med" +- "$des >> $local/data-stride-ss/statistic.dat

# $SCRIPT/medias_col.sh estruc-after 1 1.
# med=$(awk {'print $2'} fort.45)
# des=$(awk {'print $3'} fort.45)

# echo "with-estruct-after "$med" +- "$des >> $local/data-stride-ss/statistic.dat

# $SCRIPT/medias_col.sh coil-before 1 1.
# med=$(awk {'print $2'} fort.45)
# des=$(awk {'print $3'} fort.45)

# echo "coil-before "$med" +- "$des >> $local/data-stride-ss/statistic.dat

# $SCRIPT/medias_col.sh coil-after 1 1.
# med=$(awk {'print $2'} fort.45)
# des=$(awk {'print $3'} fort.45)

# echo "coil-after "$med" +- "$des >> $local/data-stride-ss/statistic.dat


cd $local
rm -rf borrar


