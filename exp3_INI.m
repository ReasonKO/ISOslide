clear all
close all
iso_ini_def

global exp3_data field
exp3_data.error=0.1;    %Ошибка датчика в %


%%
global iso_par;
iso_par.d0d=5;   %Шарана коридора присоедования
iso_par.error=0.00;%/0.15;    %Ошибка датчика в %
iso_par.d0=15; %приследуемое значение
iso_par.Sgrad=0.7;%1  %Макс.градиент
iso_par.Tspeed=1;   %Ускорение изолинии по времени
iso_par.Nagent=1;%12  %Кол-во агентов
iso_par.smooth=1;   %*гладкий режим*
iso_par.dD=3;
iso_par.smooth_koef=30;

iso_par.ExpName='Mnojestva';
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
Yellows(1,:)=[1,-250,-150,0];
exp3_data.C=[70,70];
exp3_data.Cv=1000;

[X,Y]=meshgrid(-60:0.1:60,-40:0.1:20);
Z=1*or(abs(X)>40,Y>0);
field.Xm{1}=X;
field.Ym{1}=Y-20;
field.Zm{1}=Z;

[R,ang]=meshgrid(0:1:20,-pi:pi/1000:pi);
field.Xm{2}=-130+2*R.*cos(ang);
field.Ym{2}=-130+R.*sin(ang);
field.Zm{2}=ones(size(R));

[L,H]=meshgrid(0:1:150,-10:10:10);
field.Xm{3}=-220+L-H-L/10;
field.Ym{3}=-100+L+H;
field.Zm{3}=ones(size(L));

% [L,H]=meshgrid(0:2:50,-10:2:10);
% field.Xm{4}=-60+L;
% field.Ym{4}=-100+H-10;
% field.Zm{4}=ones(size(L));

% [L,H]=meshgrid(-10:2:10,-10:2:10);
% field.Xm{6}=0+L;
% field.Ym{6}=-90-H;
% field.Zm{6}=ones(size(L));

% [R,ang]=meshgrid(0:10:20,-pi:pi/10:pi);
% field.Xm{5}=0+R.*cos(ang+pi/4);
% field.Ym{5}=50+R.*sin(ang+pi/4)-R.*cos(ang+pi/4);
% field.Zm{5}=ones(size(R));

[R,ang]=meshgrid(35:1:40,-pi/4+(-pi:pi/500:pi/2));
field.Xm{5}=0+R.*cos(ang+pi/4);
field.Ym{5}=50+R.*sin(ang+pi/4);
field.Zm{5}=ones(size(R));

% [L,H]=meshgrid(-10:10:10,-10:10:10);
% field.Xm{7}=0+L;
% field.Ym{7}=-110-H;
% field.Zm{7}=ones(size(L));

[R,ang]=meshgrid(55:1:60,0.9425+(-pi/2:pi/80:pi*3/5));
field.Xm{8}=-180+R.*cos(ang+pi/4);
field.Ym{8}=30+R.*sin(ang+pi/4);
field.Zm{8}=ones(size(R));

[L,H]=meshgrid(0:1:70,-5:1:5);
ang=-pi/6+pi/2+pi/10;
field.Xm{4}=-20+L*cos(ang)+H*cos(ang+pi/2);
field.Ym{4}=-150+L*sin(ang)+H*sin(ang+pi/2);
field.Zm{4}=ones(size(L));

[L,H]=meshgrid(-4:1:4,0:0.1:40);
field.Xm{6}=-20-H-L;
field.Ym{6}=-150-L+H;
field.Zm{6}=ones(size(L));
%%     
% load('M');
% Modul.N=0;
% exp3_data.P_H=[];

MAP_INI
figure(100)
axis([-300,100,-200,150,0,2]);
hold on
exp3_ADDviz
plot(exp3_data.C(1),exp3_data.C(2),'G*');%,'MarkerSize',25);
plot(exp3_data.C(1),exp3_data.C(2),'Go');%,'MarkerSize',25);
MAP
%% RUN
%return
MODUL