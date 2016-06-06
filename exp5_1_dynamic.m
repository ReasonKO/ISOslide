global iso_save Modul exp3_data
if    abs(iso_save.dold(1)-exp3_data.Cv)<10
    Modul.Tsave=Modul.T;
    Modul.T=Modul.Tend;
end

global SNOS
if isempty(SNOS)
    SNOS.ang=rand(1)*2*pi;
    SNOS.angC=rand(1)*2*pi;
end
ddd=0.01;
SNOS.ang=SNOS.ang+ddd*sign(azi(SNOS.angC-SNOS.ang));
if abs(azi(SNOS.ang-SNOS.angC))<ddd
    SNOS.angC=rand(1)*2*pi;
end
ddv=0.03;
Yellows(1,2)=Yellows(1,2)+ddv*sin(SNOS.ang);
Yellows(1,3)=Yellows(1,3)+ddv*cos(SNOS.ang);