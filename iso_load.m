global iso_par;
global Modul;

sX=size(iso_save_d.Z{1},2);
sY=size(iso_save_d.Z{1},1);
sZ=Modul.N;
Zt=zeros(N,M,Modul.N);
unity=zeros(iso_par.Nagent,3,Modul.N);
for i=1:Modul.N
    Zt(:,:,i)=iso_save_d.Z{i};
    unity(:,:,i)=iso_save_d.R{i}(1:iso_par.Nagent,2:4);    
end
iso_d0=iso_par.d0;
iso_d0d=iso_par.d0d;
Nagent=iso_par.Nagent;
MAP_X=PAR.MAP_X;
MAP_Y=PAR.MAP_Y;
iso_max=max(max(iso_save_d.Z{1}));
iso_min=min(min(iso_save_d.Z{1}));