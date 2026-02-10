# S2D

Secondary structure distance in proteins

Bash scripts have been tested in Ubuntu 22.04.5.

Fortran codes were tested using _gfortran_ (version 4:11.2.0-1ubuntu1)

STRIDE (https://github.com/MDAnalysis/stride) and _megacc_ (https://www.megasoftware.net/) are required.

## CIF Files

Include the cif files that you want to analyze in the _/data-cif_ subfolder (an example is provided).

## Fortran codes

Compile the fortran codes using _fortran-v1.sh_

 
## Generate pdb, pLDDT, stride and fasta files

_generating-files-v1.sh_ will create those files from the cif ones.

## Alignement

Align protein sequeces using _alignement-v1.sh_

## Calculate phylogenetic and secondary structure distances

Run _phylo-distance-v1.sh_ and _s2d-v1.sh_ scripts.

## Comments and questions

Adolfo Bastida 

Department of Physical Chemistry

Universidad de Murcia

bastida@um.es

