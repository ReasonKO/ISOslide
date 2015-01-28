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

% global PAR;
% PAR.MAP_X=5000;
% PAR.MAP_Y=5000;
% 
% global iso_par;
% iso_par.d0d=200;   %Шарана коридора присоедования
% iso_par.error=0.00;    %Ошибка датчика в %
% iso_par.d0=600; %приследуемое значение
% iso_par.Type=6; %тип изолинии
% iso_par.Sgrad=0.3;  %Макс.градиент
% iso_par.Tspeed=0;   %Ускорение изолинии по времени
% iso_par.Nagent=3;  %Кол-во агентов
% iso_par.smooth=1;   %*гладкий режим*


%iso_D=@(r)+0.4*norm(r-iso_C,2)+(2+sin(5*angV(0.2*r-0.2*iso_C+pi/2)+T/40))*sqrt(sqrt(0.2*norm(r-iso_C,2)))*(cos(T/10)/4+3)*10;
 %iso_D=@(r)+0.4*norm(r-iso_C,2)+(2+sin(5*angV(0.2*r-0.2*iso_C+pi/2)+T/40))*sqrt(sqrt(0.2*norm(r-iso_C,2)))*(cos(T/10)/4+3)*10;
 %iso_D=@(r)+0.4*sqrt((r(1)-iso_C(1)).^2+(r(2)-iso_C(2)).^2);

% if (iso_par.Type==1)
%     iso_par.D=@(x,y)+sqrt(x.^2+y.^2);
% end
% if (iso_par.Type==2)
%     Ct=mod(Modul.T*iso_par.Tspeed,1000);
%     if (Ct>500)
%         iso_par.C=[2000,2000]-8*[Ct-500,Ct-500];
%     else
%         iso_par.C=-[2000,2000]+8*[Ct,Ct];
%     end
%     iso_par.D=@(x,y)+sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2);
% end
% if (iso_par.Type==3)
%     iso_par.C=[0,0];
%     iso_par.D=@(x,y)+1/1.5*(1.5+sin(pi*3/2+2*angVr(x,y))).*sqrt((x).^2+(y).^2);
% end
% if (iso_par.Type==4)
%     iso_par.C=[0,0];
%     iso_par.D=@(x,y)+1/1.5*(1.5+sin(4+iso_par.Tspeed*Modul.T/200+2*angVr(x,y))).*sqrt((x).^2+(y).^2);
% end
% 
% 
% 
% if (iso_par.Type==5)
%     iso_par.C=[0,0];
%     iso_par.D=@(x,y)+(4+sin(5*angVr(x,y)))/4.*sqrt((x).^2+(y).^2);
% end
% if (iso_par.Type==6)
%     iso_par.C=[0,0];
%     iso_par.D=@(x,y)+(4+sin(iso_par.Tspeed*Modul.T/30+5*angVr(x,y)))/4.*sqrt((x).^2+(y).^2)*(9+cos(iso_par.Tspeed*Modul.T/150))/9;
% end
% if (iso_par.Type==7 || iso_par.Type==8 || iso_par.Type==9 || iso_par.Type==10)
%     iso_par.D=@(x,y)iso_D(x,y);
% end

% if (iso_par.Type==11)
%     iso_par.C=[0,1200];
%     iso_par.D=@(x,y)+sqrt(x.^2+y.^2)+sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2)/2;
% end
% % 
% if (iso_par.Type>10 && iso_par.Type<16)    
%     iso_par.D=0;%@(x,y)iso_D(x,y);
% end

% if (iso_par.Type==14)
%     iso_par.D=@(x,y)+(600^2)./sqrt((x/2).^2+y.^2);
% end

% if (iso_par.Type==40)
%     iso_par.C=[0,0];
%     iso_par.C2=2000*[cos(iso_par.Tspeed*Modul.T/150),sin(iso_par.Tspeed*Modul.T/150)];
%     iso_par.D=@(x,y)-2750+200*(((x-iso_par.C2(1)/2).^2+(y-iso_par.C2(2)/2).^2).^(1/7)+((x+iso_par.C2(1)).^2+(y+iso_par.C2(2)).^2).^(1/7));
% end
% if (iso_par.Type==12)
%     iso_par.C=[0,0];
%     iso_par.C2=1500*[1,0];
%     iso_par.D=@(x,y)-2750+200*(((x-iso_par.C2(1)).^2+(y-iso_par.C2(2)).^2).^(1/7)+((x+iso_par.C2(1)).^2+(y+iso_par.C2(2)).^2).^(1/7));
% end
% if (iso_par.Type==6)
%     NB=9;
%     iso_par.C=Blues(NB,2:3);
%     iso_par.ANG=Blues(NB,4);
% %    iso_par.C=400*[cos(iso_par.Tspeed*Modul.T/30),sin(iso_par.Tspeed*Modul.T/30)];
%     %dop=@(x,y)0*sin(20*angVr(x,y));
%     iso_par.D=@(x,y)+0.4*sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2)+...
%        200*abs(( (x-iso_par.C(1))*sin(iso_par.ANG)+(y-iso_par.C(2))*cos(iso_par.ANG))./...
%        ((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2).^(1/2));
% end
% if (iso_par.Type==7)
%     NBm=8;
%     if (MOD1==1)
%         NBm=7;
%     end
%     iso_par.C=[0,0];
%     Dq=0;
%     Dq2=0;
%     for i=1:NBm
%         iso_par.C=iso_par.C+Blues(i,2:3);
%         for j=1:NBm
%             Dq=Dq+((Blues(i,2)-Blues(j,2))^2+(Blues(i,3)-Blues(j,3))^2);
%         end
%     end
%     iso_par.C=iso_par.C/NBm;
%     Dq=Dq/2/NBm/NBm;
%     k=2;
%     for i=1:NBm
%             Dq2=Dq2+((Blues(i,2)-iso_par.C(1))^2+(Blues(i,3)-iso_par.C(2))^2)^(k/2);
%     end
%     Dq2=(Dq2/NBm)^(2/k);
%     Dq3=0;
%     for i=1:NBm
%             Dq3=max(Dq3,((Blues(i,2)-iso_par.C(1))^2+(Blues(i,3)-iso_par.C(2))^2));
%     end
%     %iso_par.ANG=Blues(NB,4);
% %    iso_par.C=400*[cos(iso_par.Tspeed*Modul.T/30),sin(iso_par.Tspeed*Modul.T/30)];
%     %dop=@(x,y)0*sin(20*angVr(x,y));
%     %if (get(0,'CurrentFigure')==100)
%     %    iplot(iso_par.C(1),iso_par.C(2),'*');
%     %end
%     iso_par.D=@(x,y)+(((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2))%+Dq2);
% end

if (Modul.N==1)
    iso_info
end
%% iso
iso_rules=iso_rule(Yellows);

%Rule(1,80,100,0,0,0);

%Rule(3,100,80,0,0,0);
for i=1:iso_par.Nagent
    Rule(i,iso_rules(i,1),iso_rules(i,2),0,0,0);
end
iso_save();
%toc()
%% MAP
iso_MAP
MAP
%toc()