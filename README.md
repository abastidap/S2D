# S2D

Secondary structure distance in proteins

Bash scripts have been tested in Ubuntu 22.04.5.

Fortran codes were tested using gfortran (version 4:11.2.0-1ubuntu1)

STRIDE (https://github.com/MDAnalysis/stride) and megacc (https://www.megasoftware.net/) are required.

# CIF Files

Include the cif files that you want to analyze in the /data-dif subfolder (an example is provided).

# Fortran codes

Compile the fortran codes using fortran-v1.sh

 
# Generate pdb, pLDDT, stride and fasta files

generating-files-v1.sh will create those files from the cif ones.

# Alignement

Align protein sequeces using alignement-v1.sh

# Calculate phylogenetic and secondary structure distances

Run phylo-distance-v1.sh and s2d-v1.sh scripts.

# Comments and questions

bastida@um.es

