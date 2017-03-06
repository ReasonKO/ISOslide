%% ��������� ����������
close all 
%clear all
clc
addpath('tools');
global iso_par;
iso_par.error_P=0;
iso_par.error_U=0;

iso_par.re_D=@(x,y)NAN;
iso_par.Dynamic=[];
iso_par.Rule=[];
iso_par.AddViz=[];
iso_par.ExpName='NoName';

iso_par.Type2=0;
iso_par.Type=7; %��� ��������
iso_par.d0d=400;   %������ �������� �������������
iso_par.error=0.00;    %������ ������� � %
iso_par.d0=1000; %������������ ��������
iso_par.Sgrad=0.7;%1  %����.��������
iso_par.Tspeed=0.3;   %��������� �������� �� �������
iso_par.Nagent=1;%8  %���-�� �������
iso_par.Nagent2=0;%8  %���-�� �������
iso_par.smooth=0;   %*������� �����*
iso_par.d02=iso_par.d0; %������������ ��������
iso_par.d0d2=NaN; %������������ ��������
iso_par.d0d2ison=false; %������������ ��������
iso_par.mooved=false; % �������� ���� NEW!!!!!!!!
iso_par.mix=false; % �������� ���� NEW!!!!!!!!
iso_par.dopisofieldMap=false;
iso_par.CloudyField=false; %������ ���� �� ���������� NEW!!!!!!!!
iso_par.TracksVizual=0; %������������ ������ (0 - �������, 1 - ������, 2 - �� ������ �� ��������)
iso_par.TracksTime=100; %��������� ����� ������ iso_par.TracksTime ���������
iso_par.TracksColor=[1,0,0];
% ��������� ������
iso_par.Vmax=50; %������������ �������� �������� [Vmin..100]
iso_par.Vmin=10; %����������� �������� ��������  [0..Vmax] 
iso_par.Umax=50; %������������ �������� �������� [0..(100-Vmax)]
% ��������� ������
iso_par.R_vision=1000;       %������ ��������� ������.
iso_par.Fi_vision=0.5*pi/2; %���� ��������� ������
iso_par.Rd_vision=0.9*iso_par.R_vision/iso_par.Nagent; % ������ ���������
iso_par.e=(iso_par.Vmax-iso_par.Vmin)/iso_par.Nagent/50;  %���������� ���������� ��� ���� ���������
% ???
iso_par.DataGraph=0;
iso_par.outsidespawn=NaN;
iso_par.VidVisible=true;
iso_par.SectorVisual=0;%������������ ������� ���������
iso_par.trackDepth=0;

global PAR;
PAR.MAP_X=7500;
PAR.MAP_Y=7500;
PAR.KICK_DIST=150;

iso_par.TripleIsoline=false;
iso_par.TrackViz=0*ones(1,iso_par.Nagent);
iso_par.RobotFormat=0;

global treckcolor;
treckcolor=[0.8,0.1,0.1];

if (iso_par.d0d2ison==false)
    iso_par.d02=iso_par.d0;
    iso_par.d0d2=iso_par.d0d;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Global MODUL INI

global MODUL_ON; MODUL_ON=1;
global iso_MODUL_ON; iso_MODUL_ON=1; 

global Pause; Pause=0;

global Rules;    Rules=zeros(30,7);
global Balls;    Balls=zeros(1,3);
global Blues;    Blues=zeros(100,4);
global Yellows;  Yellows=zeros(12,4);
global Greens;   Greens=zeros(12,4);

global Modul;
Modul.Tend=2500; %����� ������
Modul.dT=0.1;     %��� �������������
Modul.freq=1;
Modul.save_freq=1;
Modul.Delay=0;  %��������
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
Modul.SaveExp=true;
Modul.MAPviz=true;
Modul.isoMAPviz=true;
