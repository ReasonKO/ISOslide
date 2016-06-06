global Yellows
clear all
%[X____,Y____]=meshgrid([-300:5:100],[-200:5:150]);
[X____,Y____]=meshgrid([50:5:100],[50:5:100]);

N____=size(X____,1)*size(X____,2);
for countexp3=50:N____
global Modul exp3_data Save_iso ISO_VISION iso_save iso_par MAP_PAR field PAR
Modul=[]
exp3_data=[] 
Save_iso=[] 
ISO_VISION=[] 
iso_save=[] 
iso_par=[] 
MAP_PAR=[] 
field=[] 
PAR=[]
exp3_data=[]
field=[]
iso_par=[]
close all
iso_ini_def
    countexp3
%Yellows(1,:)=[1,rand(1)*400-300,rand(1)*350-200,rand(1)*2*pi];
%Yellows(1,:)=[1,X____(countexp3),Y____(countexp3),rand(1)*2*pi];
%StartCoor=%Yellows(1,:);
exp3_data.C=[X____(countexp3),Y____(countexp3)];
StartCoor=exp3_data.C;
exp3_2_2_INI
MODUL
save(sprintf('exp3FULL4\\exp3_r_%d',countexp3));
end

for countexp3=1:N____
    S{countexp3}=load(sprintf('exp3FULL3\\exp3_r_%d',countexp3));
end

figure(999)
hold on
for countexp3=1:N____
    SS=S{countexp3};
    plot(SS.StartCoor(2),SS.StartCoor(3))
end