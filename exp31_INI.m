clear all
close all
iso_ini_def

global exp3_data field
exp3_data.error=0.1;    %������ ������� � %


%%
global iso_par;
iso_par.d0d=5;   %������ �������� �������������
iso_par.error=0.00;%/0.15;    %������ ������� � %
iso_par.d0=15; %������������ ��������
iso_par.Sgrad=0.7;%1  %����.��������
iso_par.Tspeed=1;   %��������� �������� �� �������
iso_par.Nagent=1;%12  %���-�� �������
iso_par.smooth=0;   %*������� �����*

iso_par.ExpName='Mnojestva_2';
iso_par.re_D=@(x,y)exp3_reD(x,y);
iso_par.Dynamic=@exp3_dynamic;
iso_par.AddViz=[];
iso_par.Rule=@(Y)exp3_iso_rule(Y);

iso_par.Vmax=50; %������������ �������� �������� [Vmin..100]
iso_par.Vmin=10; %����������� �������� ��������  [0..Vmax] 
iso_par.Umax=50; %������������ �������� �������� [0..(100-Vmax)]

iso_par.R_vision=10;       %������ ��������� ������.
iso_par.Fi_vision=0.5*pi/2; %���� ��������� ������
iso_par.Rd_vision=0.9*iso_par.R_vision/iso_par.Nagent; % ������ ���������
iso_par.e=(iso_par.Vmax-iso_par.Vmin)/iso_par.Nagent/50;  %���������� ���������� ��� ���� ���������

iso_par.TracksVizual=1; %������������ ������ (0 - �������, 1 - ������, 2 - �� ������ �� ��������)
iso_par.TracksTime=inf; %��������� ����� ������ iso_par.TracksTime ���������
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

Modul.Tend=10000; %����� ������
Modul.dT=0.1;     %��� �������������
Modul.freq=10;
Modul.Delay=0;  %��������
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
Modul.SaveExp=1;
%% 
Yellows(1,:)=[1,-150,-210,0];
exp3_data.C=[70,140];
exp3_data.Cv=1000;

[X,Y]=meshgrid(-100:100,-40:10);
Z=1*or(abs(X)>90,Y>0);
field.Ym{1}=Y+100;
field.Xm{1}=X;
field.Zm{1}=Z;
% 
[R,ang]=meshgrid(0:10:25,-pi:pi/30:pi);
field.Xm{2}=0+R.*cos(ang);
field.Ym{2}=-40+R.*sin(ang);
field.Zm{2}=ones(size(R));
% 
% [L,H]=meshgrid(0:2:150,-10:10:10);
% field.Xm{3}=-220+L-H-L/10;
% field.Ym{3}=-100+L+H;
% field.Zm{3}=ones(size(L));
% 
% [R,ang]=meshgrid(35:1:40,-pi/4+(-pi:pi/50:pi/2));
% field.Xm{5}=0+R.*cos(ang+pi/4);
% field.Ym{5}=50+R.*sin(ang+pi/4);
% field.Zm{5}=ones(size(R));
% 
[R,ang]=meshgrid(65:5:70,-0.3+0.9425+(-1.5*pi/2:pi/20:pi*3/5));
field.Xm{8}=0+R.*cos(ang+pi/4);
field.Ym{8}=-25+R.*sin(ang+pi/4);
field.Zm{8}=ones(size(R));
% 
[L,H]=meshgrid(40:1:70,-5:1:5);
ang=-pi/6+pi/2+pi/10;
field.Xm{4}=-160+L*cos(ang)+H*cos(ang+pi/2);
field.Ym{4}=-215+L*sin(ang)+H*sin(ang+pi/2);
field.Zm{4}=ones(size(L));
% 
[L,H]=meshgrid(-4:1:4,-30:1:40);
field.Xm{6}=-70-H*2-L;
field.Ym{6}=-170-L+0.5*H;
field.Zm{6}=ones(size(L));
%
[L,H]=meshgrid(-100:1:75,-5:1:5);
field.Xm{5}=-90+L;
field.Ym{5}=-105+H;
field.Zm{5}=ones(size(L));
%
[L,H]=meshgrid(-5:1:30,-5:1:5);
field.Xm{3}=-190+H;
field.Ym{3}=-105+L;
field.Zm{3}=ones(size(L));
%
[L,H]=meshgrid(-5:1:30,-5:1:5);
field.Xm{7}=-220+H+L;
field.Ym{7}=-135+L-H;
field.Zm{7}=ones(size(L));
%
[ang,R]=meshgrid(-pi:pi/10:pi,0:10:20);
field.Xm{9}=-190+3*sin(ang).*R;
field.Ym{9}=-05+cos(ang).*R;
field.Zm{9}=ones(size(R));

%%     
% load('M');
% Modul.N=0;
% exp3_data.P_H=[];

MAP_INI
figure(100)
axis([-300,130,-230,160]);
hold on
exp3_ADDviz
plot(exp3_data.C(1),exp3_data.C(2),'G*');%,'MarkerSize',25);
plot(exp3_data.C(1),exp3_data.C(2),'Go');%,'MarkerSize',25);
MAP
%% RUN
%return
MODUL