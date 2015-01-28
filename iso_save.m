global Modul
% Modul.N -> floor(1+T/dT)
iso_save_d.R{Modul.N}=Yellows;
N=40;
M=60;
global PAR;
[X,Y] = meshgrid(PAR.MAP_X/2*(-1:2/(M-1):1),PAR.MAP_Y/2*(-1:2/(N-1):1));
Z=iso_D(X,Y);
iso_save_d.Z{Modul.N}=Z;