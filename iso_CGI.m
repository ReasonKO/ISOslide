%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FROM CGI
%Nagent
clc
format short;

if (~exist('Tspeed'))
    Tspeed=1;
end
if (~exist('iso_error'))
    iso_error=0;
end
if (~exist('iso_d0'))
    iso_d0=500;
end
if (~exist('iso_Type')||(iso_Type<1)||(iso_Type>4))
    iso_Type=1;
end
if (~exist('Nagent')||(Nagent<0))
    Nagent=1;
end
if ~exist('Tend')
    Tend=100;
end

global iso_par;
iso_par.d0d=200;
iso_par.error=iso_error;
iso_par.d0=iso_d0;
iso_par.Type=iso_Type;
%iso_par.Nagent=Nagent;
iso_par.Sgrad=0.3;
iso_par.Tspeed=Tspeed;
iso_par.Nagent=Nagent;
iso_par.smooth=0;

global Pause; Pause=0;

global PAR;
PAR.MAP_X=6000;
PAR.MAP_Y=4000;
PAR.KICK_DIST=150;
%% Global INI
global MODUL_ON; MODUL_ON=1;
global iso_MODUL_ON; iso_MODUL_ON=1; 

global Rules;    Rules=zeros(12,7);
global Balls;    Balls=zeros(1,3);
global Blues;    Blues=zeros(12,4);
global Yellows;  Yellows=zeros(12,4);

global Modul;
Modul.Tend=Tend;
Modul.dT=0.1;
Modul.Delay=0;
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
%% Задержка
for i=1:iso_par.Tspeed;
    Modul.Rules_Delay{i}=Rules;
end
%% INI начальных позиций
%Yellows(5,:)=[1,-200,600,pi];
for i=1:iso_par.Nagent
    Yellows(i,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
end
%% Balls
    global MOD_Kick;
    MOD_Kick=[0,0];
%% Цикл
tic();
while(Modul.T+Modul.dT<=Modul.Tend )    
    Rules=zeros(12,7);
    %----------------------------------------------------------------------
    Modul.N=Modul.N+1;
    Modul.T=Modul.T+Modul.dT;    
    iso_main; 
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
    for i=1:iso_par.Nagent
        MOD_NGO(i,i,'Y',1);    
    end
    %----------------------------------------------------------------------
end
Modul.T
%fprintf('Time: %d \n',toc())
iso_load

