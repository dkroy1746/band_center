#!/bin/bash

read -p " Enter filename: " filenamee
#filenamee="PDOS_Ru_SOC.dat"
read -p " Enter lower energy limit: " lower_E
read -p " Enter upper energy limit: " upper_E
#lower_E=-0.94
#upper_E=0

cp $filenamee temp11.dat
awk -v lower_e="$lower_E" -v upper_e="$upper_E" 'NR==2{for(i=1;i<=7;i++) printf "%2.6f ", 0.0;print " "}; NR>2{ if($1 >= lower_e && $1 <= upper_e) print $1,$6,$7,$8,$9,$10,$11} ' temp11.dat > temp22.dat
## I took one dummy row as inital extra because pandas treats 1st row as column headings and skips it when converted to np.arrays
rm temp11.dat
python <<END_OF_PYTHON
import sys
import pandas as pd
import csv
import numpy as np
import scipy.integrate as integrate
## Sys because it can pass variables from outside of python to here and to use sysexit

df = pd.read_csv('temp22.dat',delim_whitespace=True)
dg = df.to_numpy()
#print(df.head())
#print(dg[:,0])


## WARNING : IN SIMPSON f(x) is 1st variable, x is 2nd variable and it is a keyword arguement so write x=your_x_variable

print("dxy-center",        integrate.simpson(np.multiply(dg[:,0],dg[:,1]),x=dg[:,0])/integrate.simpson(dg[:,1],x=dg[:,0]),"dxy Integrated Density Pho[E]dE",integrate.simpson(dg[:,1],x=dg[:,0]))
print("dyz-center",        integrate.simpson(np.multiply(dg[:,0],dg[:,2]),x=dg[:,0])/integrate.simpson(dg[:,2],x=dg[:,0]),"dyz Integrated Density Pho[E]dE",integrate.simpson(dg[:,2],x=dg[:,0]))
print("dz2-center",        integrate.simpson(np.multiply(dg[:,0],dg[:,3]),x=dg[:,0])/integrate.simpson(dg[:,3],x=dg[:,0]),"dz2 Integrated Density Pho[E]dE",integrate.simpson(dg[:,3],x=dg[:,0]))
print("dxz-center",        integrate.simpson(np.multiply(dg[:,0],dg[:,4]),x=dg[:,0])/integrate.simpson(dg[:,4],x=dg[:,0]),"dxz Integrated Density Pho[E]dE",integrate.simpson(dg[:,4],x=dg[:,0]))
print("dx2-y2-center",     integrate.simpson(np.multiply(dg[:,0],dg[:,5]),x=dg[:,0])/integrate.simpson(dg[:,5],x=dg[:,0]),"dx2-y2 Integrated Density Pho[E]dE",integrate.simpson(dg[:,5],x=dg[:,0]))
print("Total d-center",    integrate.simpson(np.multiply(dg[:,0],dg[:,1]+dg[:,2]+dg[:,3]+dg[:,4]+dg[:,5]),x=dg[:,0])/integrate.simpson(dg[:,1]+dg[:,2]+dg[:,3]+dg[:,4]+dg[:,5],x=dg[:,0]))
print("Total band-center", integrate.simpson(np.multiply(dg[:,0],dg[:,6]),x=dg[:,0])/integrate.simpson(dg[:,6],x=dg[:,0]))

sys.exit(0)
END_OF_PYTHON

#rm temp22.dat
