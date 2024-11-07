This is a program to find the band-centers and integrated density of states in any particular energy-range using density of states (DOS)

Requirements: File containing DOS, Python libraries : pandas, numpy, scipy, csv and sys.

The program uses Simpson's rule to integrate the density.

For the expression of the band center you may refer to the [vaspkit webpage](https://vaspkit.com/tutorials.html).

Steps:
1. Input the file containing DOS with energy in the 1st column and dxy, dyz, dz2 , dxz and dx2-y2 as the 6th ,7th ,8th ,9th ,10th ,11th.
   The reason for such odd column number is because that's how it is printed in vaspkit files. The 2nd-5th columns are skipped to avoid s and p orbital calculations.
   You may choose to keep them.

2. Enter the energy range in which your band lies.
