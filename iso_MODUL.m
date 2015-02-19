clear all
close all
pcode main.m
clc
%%

global iso_par;
iso_par.Type=19; %тип изолинии
iso_par.d0d=400;   %Шарана коридора присоедования
iso_par.error=0.00;    %Ошибка датчика в %
iso_par.d0=1000; %приследуемое значение
iso_par.Sgrad=0.7;%1  %Макс.градиент
iso_par.Tspeed=0.3;   %Ускорение изолинии по времени
iso_par.Nagent=10;%8  %Кол-во агентов
iso_par.Nagent2=0;%8  %Кол-во агентов
iso_par.smooth=0;   %*гладкий режим*
iso_par.d02=iso_par.d0; %приследуемое значение
iso_par.d0d2=iso_par.d0d; %приследуемое значение

iso_par.mooved=false; % Движение поля NEW!!!!!!!!
iso_par.mix=false; % Движение поля NEW!!!!!!!!
iso_par.dopisofieldMap=false;

iso_par.CloudyField=true; %Делает поле НЕ прозрачным NEW!!!!!!!!

iso_par.TracksVizual=0; %Демонстрация треков (0 - никогда, 1 - всегда, 2 - до выхода на изолинию)
iso_par.TracksTime=500; %Затирание трека спустя iso_par.TracksTime отрисовок

iso_par.Vmax=50; %Максимальная линейная скорость [Vmin..100]
iso_par.Vmin=10; %Минимальная линейная скорость  [0..Vmax] 
iso_par.Umax=50; %Максимальная скорость поворота [0..(100-Vmax)]

iso_par.R_vision=800;       %Радиус видимости робота.
iso_par.Fi_vision=0.5*pi/2; %Угол видимости робота
iso_par.Rd_vision=0.9*iso_par.R_vision/iso_par.Nagent; % Радиус ближайших
iso_par.e=(iso_par.Vmax-iso_par.Vmin)/iso_par.Nagent/50;  %коэфициент замедления для ряда ближайших

iso_par.VidVisible=true;
iso_par.SectorVisual=true;%Визуализация сектора видимости

global PAR;
PAR.MAP_X=7500;
PAR.MAP_Y=7500;
PAR.KICK_DIST=150;

if (iso_par.Type==3 || iso_par.Type==4)
    iso_par.Nagent=12;
    iso_par.d0d=500;
    iso_par.R_vision=1300;
    iso_par.Sgrad=0.6;
end
if (iso_par.Type==5 || iso_par.Type==6)
    iso_par.Nagent=10;
    iso_par.d0=1800;
    iso_par.d0d=600;
    iso_par.R_vision=1200;
end
iso_par.TripleIsoline=false;
iso_par.TrackViz=ones(1,iso_par.Nagent);

global treckcolor;
treckcolor=[0.8,0.1,0.1];

if (iso_par.Type==7)
    iso_par.d0=258000;
    iso_par.d0d=5000;
    iso_par.Sgrad=3;
    iso_par.dop.Wmod=1;
end
if (iso_par.Type==8)
    iso_par.d0=250000;
    iso_par.d0d=200000;
    
    iso_par.Sgrad=100;
    iso_par.dop.Wmod=2;
end
if (iso_par.Type==9)
    iso_par.d0=250;
    iso_par.d0d=200;
    
    iso_par.Sgrad=1;
    iso_par.mix=false;
    iso_par.mooved=false; 
    
end
if (iso_par.Type==10)
    iso_par.d0=550;
    iso_par.d0d=300;    
    iso_par.Sgrad=1.8;
    
    iso_par.mix=false;
    iso_par.mooved=false; 
end

%% БЛОК НАСТРОЙКИ ДЛЯ 7 Этапа
if (iso_par.Type>10 && iso_par.Type<16)
    iso_par.R_vision=1000;
    iso_par.Fi_vision=0.7*pi/2;    
    iso_par.d0=300;
    iso_par.d0d=100;    
    iso_par.Sgrad=0.9;  
end
%% БЛОК НАСТРОЙКИ ДЛЯ 8 Этапа
if (iso_par.Type==16)
    iso_par.R_vision=1500;
    iso_par.Fi_vision=0.7*pi/2;    
    iso_par.d0=300;
    iso_par.d0d=100;    
    iso_par.Sgrad=0.9;  
end

if (iso_par.Type==18)
    iso_par.Type=15;
    iso_par.R_vision=1000;
    iso_par.Fi_vision=0.7*pi/2;    
    iso_par.d0=300;
    iso_par.d0d=100;    
    iso_par.d02=800;
    iso_par.d0d2=200;    
    iso_par.Sgrad=0.9;  
    iso_par.Nagent2=5;
end

if (iso_par.Type==19)
    iso_par.Nagent2=5;            
    iso_par.Nagent=15;
    iso_par.R_vision=1000;
    iso_par.Fi_vision=0.7*pi/2;    
    iso_par.d0=300;
    iso_par.d0d=100;    
    iso_par.d02=500;
    iso_par.d0d2=100;    
    iso_par.Sgrad=0.8;  
end
% if (iso_par.Type>=17 && iso_par.Type<16)
%     iso_par.R_vision=1000;
%     iso_par.Fi_vision=0.7*pi/2;    
%     iso_par.d0=300;
%     iso_par.d0d=100;    
%     iso_par.Sgrad=0.9;  
% end

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
Modul.Tend=1000; %Время работы
Modul.dT=0.1;     %Щаг дискретизации
Modul.Delay=0;  %Задержка
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
Modul.SaveExp=1;
%% Задержка
for i=1:Modul.Delay;
    Modul.Rules_Delay{i}=Rules;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INI начальных позиций
StartPositionINI();
BluesSTART=Blues;
%% Balls
    global MOD_Kick;
    MOD_Kick=[0,0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Цикл
tic();
fprintf('---Start Modul!---\n');
while(Modul.T+Modul.dT<=Modul.Tend )    
    Rules=zeros(30,7);
    %----------------------------------------------------------------------
    Modul.N=Modul.N+1;    Modul.T=Modul.T+Modul.dT;    
    iso_main;     
    iso_save_map
    if (Modul.N==1)  
        iso_MAP_INI        

    end
    %----------------------------------------------------------------------
    Rules_Delay_S=Rules;
    if (Modul.Delay>0)
        Rules=Modul.Rules_Delay{1};
        for i=1:Modul.Delay-1
            Modul.Rules_Delay{i}=Modul.Rules_Delay{i+1};        
        end
        Modul.Rules_Delay{Modul.Delay}=Rules_Delay_S;
    end
    %---------------------------------------------------------------------- 
    for i=1:iso_par.Nagent+iso_par.Nagent2
        MOD_NGO(i,i,'Y',1);    
    end   
    %----------------------------------------------------------------------
    if (iso_par.mooved)
        FieldSpeed=5;        
        Period=600;
        Ct=mod(Modul.T*iso_par.Tspeed+Period/4,Period);
        if (Ct>Period/2)
            Blues(1:23,[2,3])=Blues(1:23,[2,3])+FieldSpeed*ones(23,2)*Modul.dT;
            BluesSTART(1:23,[2,3])=BluesSTART(1:23,[2,3])+FieldSpeed*ones(23,2)*Modul.dT;
        else
            Blues(1:23,[2,3])=Blues(1:23,[2,3])-FieldSpeed*ones(23,2)*Modul.dT;
            BluesSTART(1:23,[2,3])=BluesSTART(1:23,[2,3])+FieldSpeed*ones(23,2)*Modul.dT;
        end
    end
    KopashatSpeed=100;
    if (iso_par.mix)
        for i=1:23
            Blues(i,[2,3])=BluesSTART(i,[2,3])+[sin(i*10+Modul.T/(2+mod(i,5)*2)),cos(i*30+Modul.T/(3+mod(i,5)*3))]*KopashatSpeed;
        end
    end
    %-----------------------------------
    Dynamics();
end
%figure(201)
%axis([0,Modul.N,400,1400])
iso_save_param
Modul.T
%fprintf('Time: %d \n',toc())
iso_load