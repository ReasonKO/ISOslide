clear all
close all
iso_ini_def
global exp3_data field

%%
global iso_par;
iso_par.d0d=5;   %Шарана коридора присоедования
iso_par.error=0.0;    %Ошибка датчика в %
iso_par.d0=15; %приследуемое значение
iso_par.Sgrad=0.7;%1  %Макс.градиент
iso_par.Tspeed=1;   %Ускорение изолинии по времени
iso_par.Nagent=1;%12  %Кол-во агентов
iso_par.smooth=1;   %*гладкий режим*
iso_par.dD=3;
iso_par.smooth_koef=30;

iso_par.ExpName='Dynamic';
iso_par.re_D=@(x,y)exp3_reD(x,y);
iso_par.Dynamic=@exp4_dynamic;
iso_par.AddViz=@exp4_ADDviz;
iso_par.Rule=@(Y)exp3_iso_rule(Y);

iso_par.Vmax=50; %Максимальная линейная скорость [Vmin..100]
iso_par.Vmin=10; %Минимальная линейная скорость  [0..Vmax] 
iso_par.Umax=50; %Максимальная скорость поворота [0..(100-Vmax)]

iso_par.R_vision=10;       %Радиус видимости робота.
iso_par.Fi_vision=0.5*pi/2; %Угол видимости робота
iso_par.Rd_vision=0.9*iso_par.R_vision/iso_par.Nagent; % Радиус ближайших
iso_par.e=(iso_par.Vmax-iso_par.Vmin)/iso_par.Nagent/50;  %коэфициент замедления для ряда ближайших

iso_par.TracksVizual=1; %Демонстрация треков (0 - никогда, 1 - всегда, 2 - до выхода на изолинию)
iso_par.TracksTime=inf; %Затирание трека спустя iso_par.TracksTime отрисовок
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
Modul.Delay=0;  %Задержка
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
Modul.SaveExp=1;
iso_par.DataGraph=1;
%% 
Yellows(1,:)=[1,-20,-195-5*0,0];
exp3_data.C=[-120,150];
exp3_data.Cv=1000;

[X,Y]=meshgrid(-40:40,-40:20);
Z=1*or(abs(X)>30,Y>10);
field.Xm{1}=X;
field.Ym{1}=Y;
field.Zm{1}=Z;

[L,H]=meshgrid(-35:1:35,-5:1:5);
ang=-pi/6+pi/2+pi/10;
field.Xm{2}=+L*cos(ang)+H*cos(ang+pi/2);
field.Ym{2}=L*sin(ang)+H*sin(ang+pi/2);
field.Zm{2}=ones(size(L));

[R,ang]=meshgrid(35:1:40,-pi/4+(-pi:pi/100:pi/2));
field.Xm{3}=R.*cos(ang+pi/4);
field.Ym{3}=R.*sin(ang+pi/4);
field.Zm{3}=ones(size(R));

exp3_data.field_save=field;
field.Ym{3}=field.Ym{3}-120;
field.Ym{2}=field.Ym{2}-20;
field.Ym{1}=field.Ym{1}+90;% load('M2');
% Modul.N=0;
% exp3_data.P_H=[];

%%     

MAP_INI
figure(100)
axis([-200,200,-200,200,0,2]);
hold on
exp4_ADDviz
plot(exp3_data.C(1),exp3_data.C(2),'G*');%,'MarkerSize',25);
plot(exp3_data.C(1),exp3_data.C(2),'Go');%,'MarkerSize',25);
MAP
%exp4_dynamic
%return
%% RUN
%return
MODUL  