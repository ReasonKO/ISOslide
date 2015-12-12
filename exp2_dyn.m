global Modul Blues exp2_data
if exp2_data.MOD3==1
    exp2_data.BluesSave(:,2:3)=exp2_data.BluesSave(:,2:3)...
        +randn(size(exp2_data.BluesSave,1),2)*0.1;
    Blues=exp2_data.BluesSave;
end

if (exp2_data.MOD1==1)
    angf=@(t)abs(azi(t/1000))+pi/4;   
    ang=angf(Modul.T);
    CX=1/12*integral(@(t)sin(angf(t)-pi/4),0,Modul.T)-200;
    CY=1/12*integral(@(t)cos(angf(t)-pi/4),0,Modul.T);
    ang=ang-pi/4;
    Blues(:,2)=cos(ang)* exp2_data.BluesSave(:,2)+...
               sin(ang)*exp2_data.BluesSave(:,3)+CX;
    Blues(:,3)=cos(ang)* exp2_data.BluesSave(:,3)-...
               sin(ang)*exp2_data.BluesSave(:,2)+CY;
end
if (exp2_data.MOD1==2)
    angf=@(t)t/1000;   
    ang=angf(Modul.T);
    CX=2*1/12*integral(@(t)sin(angf(t)),0,Modul.T)-200;
    CY=1*1/12*integral(@(t)cos(angf(t)),0,Modul.T);
    Blues(:,2)=cos(ang)* exp2_data.BluesSave(:,2)+...
               sin(ang)*exp2_data.BluesSave(:,3)+CX;
    Blues(:,3)=cos(ang)* exp2_data.BluesSave(:,3)-...
               sin(ang)*exp2_data.BluesSave(:,2)+CY;
end