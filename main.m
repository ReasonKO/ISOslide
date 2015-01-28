%Внутреннее
%% Data
%от SSL
global Yellows;
global Blues;
%для BT
global Rules;
if isempty(Rules)
    Rules=zeros(12,7);
end
global Modul;
%% isoMAP

global PAR;
PAR.MAP_X=10000;
PAR.MAP_Y=5000;

global iso_par;
iso_par.d0d=100;   %Шарана коридора присоедования
iso_par.error=0.00;    %Ошибка датчика в %
iso_par.d0=250; %приследуемое значение
iso_par.Type=6; %тип изолинии
iso_par.Sgrad=0.4;  %Макс.градиент
iso_par.Tspeed=0;   %Ускорение изолинии по времени
iso_par.Nagent=12;  %Кол-во агентов
iso_par.smooth=1;   %*гладкий режим*


%iso_D=@(r)+0.4*norm(r-iso_C,2)+(2+sin(5*angV(0.2*r-0.2*iso_C+pi/2)+T/40))*sqrt(sqrt(0.2*norm(r-iso_C,2)))*(cos(T/10)/4+3)*10;
 %iso_D=@(r)+0.4*norm(r-iso_C,2)+(2+sin(5*angV(0.2*r-0.2*iso_C+pi/2)+T/40))*sqrt(sqrt(0.2*norm(r-iso_C,2)))*(cos(T/10)/4+3)*10;
 %iso_D=@(r)+0.4*sqrt((r(1)-iso_C(1)).^2+(r(2)-iso_C(2)).^2);

if (iso_par.Type==1)
    iso_par.C=[0,0];
%    iso_par.C=400*[cos(iso_par.Tspeed*Modul.T/30),sin(iso_par.Tspeed*Modul.T/30)];
    dop=@(x,y)0*sin(20*angVr(x,y));
    iso_par.D=@(x,y)+0.4*sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2)+dop(x,y);

end
if (iso_par.Type==2)
    dop=@(x,y)0*sin(x/10).*cos(y/10);    
    iso_par.C=[0,0];
    iso_par.D=@(x,y)+dop(x,y)+0.1*(4+sin(iso_par.Tspeed*Modul.T/30+5*angVr(x,y))).*sqrt((x).^2+(y).^2)*(9+cos(iso_par.Tspeed*Modul.T/150))/9;
end
if (iso_par.Type==3)
    iso_par.C=[0,0];
    iso_par.D=@(x,y)+0.6*(1.5+sin(4+iso_par.Tspeed*Modul.T/200+2*angVr(x,y))).*sqrt((x).^2+(y).^2);
end
if (iso_par.Type==4)
    iso_par.C=[0,0];
    iso_par.C2=2000*[cos(iso_par.Tspeed*Modul.T/150),sin(iso_par.Tspeed*Modul.T/150)];
    iso_par.D=@(x,y)-2750+200*(((x-iso_par.C2(1)/2).^2+(y-iso_par.C2(2)/2).^2).^(1/7)+((x+iso_par.C2(1)).^2+(y+iso_par.C2(2)).^2).^(1/7));
end
if (iso_par.Type==5)
    iso_par.C=[0,0];
    iso_par.C2=1500*[1,0];
    iso_par.D=@(x,y)-2750+200*(((x-iso_par.C2(1)).^2+(y-iso_par.C2(2)).^2).^(1/7)+((x+iso_par.C2(1)).^2+(y+iso_par.C2(2)).^2).^(1/7));
end
if (iso_par.Type==6)
    NB=10;
    iso_par.C=Blues(NB,2:3);
    iso_par.ANG=Blues(NB,4);
%    iso_par.C=400*[cos(iso_par.Tspeed*Modul.T/30),sin(iso_par.Tspeed*Modul.T/30)];
    %dop=@(x,y)0*sin(20*angVr(x,y));
    %iso_par.D=@(x,y)+0.4*sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2)+...
    %   00*abs(( (x-iso_par.C(1))*sin(iso_par.ANG)+(y-iso_par.C(2))*cos(iso_par.ANG))./...
    %   ((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2).^(1/2));
end

%if (Modul.N==1)
%    Iso_info
%end
%% iso
iso_rules=iso_rule(Yellows);
Rule(1,iso_rules(4,1),iso_rules(4,2),0,0,0);
Rule(4,iso_rules(5,1),iso_rules(5,2),0,0,0);
Rule(2,iso_rules(6,1),iso_rules(6,2),0,0,0);

%for i=1:iso_par.Nagent
%    Rule(i,iso_rules(i,1),iso_rules(i,2),0,0,0);
%end
%iso_save();
%toc()
%% MAP
%iso_MAP
%MAP
%end_main=1
%toc()