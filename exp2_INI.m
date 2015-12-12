clear all
close all
iso_ini_def
NewGroupTime=1000;
global exp2_data
exp2_data.MOD1=2;
%0 - stacionarnii
%1 - ��������� sin
%2 - ��������� ������

exp2_data.MOD2=1;
%0 - �������
%1 - �������
exp2_data.al=0.3;

exp2_data.MOD3=1;
%0- ��������� ��������
%1- ����

exp2_data.MOD4=1;
%0- ���������
%1- ����

%%
global iso_par;
iso_par.d0d=6;   %������ �������� �������������
iso_par.error=0.1;    %������ ������� � %
iso_par.d0=10; %������������ ��������
iso_par.Sgrad=0.7;%1  %����.��������
iso_par.Tspeed=1;   %��������� �������� �� �������
iso_par.Nagent=1;%12  %���-�� �������
iso_par.smooth=1;   %*������� �����*

iso_par.re_D=@(x,y)exp2_reD(x,y);
iso_par.Dynamic=@exp2_dyn;
iso_par.AddViz=@exp2_viz;

iso_par.Vmax=0.50; %������������ �������� �������� [Vmin..100]
iso_par.Vmin=10; %����������� �������� ��������  [0..Vmax] 
iso_par.Umax=50; %������������ �������� �������� [0..(100-Vmax)]

iso_par.R_vision=10;       %������ ��������� ������.
iso_par.Fi_vision=0.5*pi/2; %���� ��������� ������
iso_par.Rd_vision=0.9*iso_par.R_vision/iso_par.Nagent; % ������ ���������
iso_par.e=(iso_par.Vmax-iso_par.Vmin)/iso_par.Nagent/50;  %���������� ���������� ��� ���� ���������

iso_par.TracksVizual=1; %������������ ������ (0 - �������, 1 - ������, 2 - �� ������ �� ��������)
iso_par.TracksTime=100; %��������� ����� ������ iso_par.TracksTime ���������
iso_par.TracksColor=[1,0,0];

iso_par.TripleIsoline=false;
global treckcolor;
treckcolor=[0.8,0.1,0.1];

global Pause; Pause=0;

global PAR;
if (exp2_data.MOD1==0)
    PAR.MAP_X=150;
    PAR.MAP_Y=150;
else
    PAR.MAP_X=300*2;
    PAR.MAP_Y=150*2;
end
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
Modul.dT=0.5;     %��� �������������
Modul.freq=5;
Modul.Delay=0;  %��������
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
Modul.SaveExp=1;

Modul.isoMAPviz=false;
%% 
if exp2_data.MOD4
    Blues=zeros(8,4);
    Blues(1,:)=[1,0,0,pi];    
    for i=2:7
        Blues(i,:)=[1,10*sin(i/6*pi*2+pi/6),10*cos(i/6*pi*2+pi/6),pi];
    end
    Blues(8,:)=[1,0,15,pi];    
else
    for i=1:7
        Blues(i,:)=[1,-40+i*10,0,pi];
    end
    for i=8:12
        Blues(i,:)=[1,-30+(i-7)*10,10,pi];
    end
    for i=13:15
        Blues(i,:)=[1,-10+(i-13)*10,20,pi];
    end
    Blues(16,:)=[1,0,30,pi];
    for i=1:12
        Blues(16+i,:)=[1,rem(i,3)*10-10,-round((i+1)/3)*10,pi];
    end
end
Yellows(1,:)=[1,50,50,0];
exp2_data.BluesSave=Blues;
if (exp2_data.MOD1==1)
    Blues(:,2)=Blues(:,2)-200;
    Blues(:,3)=Blues(:,3);
end
%% 
%iso_MAP_INI
%iso_MAP
MAP_INI
exp2_viz 
MAP
%% RUN
MODUL