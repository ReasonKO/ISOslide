iso_ini_def
global exp3_data field

%%
global iso_par;
iso_par.d0d=10;   %Шарана коридора присоедования
iso_par.error=0.0;    %Ошибка датчика в %
iso_par.d0=15; %приследуемое значение
iso_par.Sgrad=0.7;%1  %Макс.градиент
iso_par.Tspeed=1;   %Ускорение изолинии по времени
iso_par.Nagent=1;%12  %Кол-во агентов
iso_par.smooth=0;   %*гладкий режим*
iso_par.ExpName='Bublic';

iso_par.re_D=@(x,y)exp3_reD(x,y);
iso_par.Dynamic=@exp3_dynamic;
iso_par.AddViz=[];
iso_par.Rule=@(Y)exp3_iso_rule(Y);

iso_par.Vmax=50; %Максимальная линейная скорость [Vmin..100]
iso_par.Vmin=10; %Минимальная линейная скорость  [0..Vmax] 
iso_par.Umax=50; %Максимальная скорость поворота [0..(100-Vmax)]

iso_par.R_vision=10;       %Радиус видимости робота.
iso_par.Fi_vision=0.5*pi/2; %Угол видимости робота
iso_par.Rd_vision=0.9*iso_par.R_vision/iso_par.Nagent; % Радиус ближайших
iso_par.e=(iso_par.Vmax-iso_par.Vmin)/iso_par.Nagent/50;  %коэфициент замедления для ряда ближайших

iso_par.TracksVizual=1; %Демонстрация треков (0 - никогда, 1 - всегда, 2 - до выхода на изолинию)
iso_par.TracksTime=200; %Затирание трека спустя iso_par.TracksTime отрисовок
iso_par.TracksColor=[1,0,0];

iso_par.TripleIsoline=false;
global treckcolor;
treckcolor=[0.8,0.1,0.1];

global Pause; Pause=0;

global PAR;
PAR.MAP_X=300;
PAR.MAP_Y=300;
PAR.KICK_DIST=150;
%% Global INI
global MODUL_ON; MODUL_ON=1;
global iso_MODUL_ON; iso_MODUL_ON=1; 

global Rules;    Rules=zeros(12,7);
global Balls;    Balls=zeros(1,3);
global Blues;    Blues=zeros(12,4);
global Yellows;  Yellows=zeros(12,4);

global Modul;

Modul.Tend=10000; %Время работы
Modul.dT=0.1;     %Щаг дискретизации
Modul.freq=10;
Modul.save_freq=5; 
Modul.Delay=0;  %Задержка
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
Modul.SaveExp=1;
%% 
Yellows(1,:)=[1,150,-150,0];
exp3_data.C=[-90,-5];
exp3_data.Cv=1000;

[ang,h]=meshgrid([-2.45*pi:pi/30:-pi/3,-pi/3:pi/100:pi/3,pi/3:pi/30:(2.45*pi)],-3:3);
%field.Xm{1}=max(23.2276,exp(1/ang)/1000).*sin(ang+pi/4)+h;
%field.Ym{1}=max(23.2276,exp(1/ang)/1000).*cos(ang+pi/4)+h;
field.Xm{1}=7*exp(15./(abs(ang)+1.55*pi)).*sin(sign(ang)*1.8*pi+ang)+3*cos(h)+90*sign(ang);
field.Ym{1}=7*exp(15./(abs(ang)+1.55*pi)).*cos(sign(ang)*1.8*pi+ang)+3*sin(h);
field.Zm{1}=ones(size(ang));

%%     
MAP_INI
figure(100)
axis([-200,200,-200,200]);
hold on
exp3_ADDviz
plot(exp3_data.C(1),exp3_data.C(2),'G*');%,'MarkerSize',25);
plot(exp3_data.C(1),exp3_data.C(2),'Go');%,'MarkerSize',25);
MAP
%% RUN
MODUL