#!/bin/bash

# compiling fortran codes

local=$(pwd)

cd $local/fortran/confirmacion_ss

gfortran -O -fno-align-commons confirmacion_ss_3.f -o confirmacion_ss.exe

cd $local/fortran/distancias_pLDDT_aligned

gfortran -O -fno-align-commons distancias_pLDDT_aligned_10.f -o distancias_pLDDT_aligned.exe

cd $local
