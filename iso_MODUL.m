clear all
close all
clc
%% НАСТРОЙКА ПАРАМЕТРОВ
global Modul iso_par PAR treckcolor MODUL_ON iso_MODUL_ON;
global Pause Rules Balls Blues Yellows Greens;  
iso_ini_def();
%% Пользовательские параметры 
global EXPERIMENT
EXPERIMENT.folder='exp1';
addpath(EXPERIMENT.folder);
EXPERIMENT.param='exp1\param';
EXPERIMENT.Dynamics='exp1\Dynamics';
EXPERIMENT.StartPositionINI='exp1\StartPositionINI';
EXPERIMENT.iso_D=@(x,y)exp1_iso_D(x,y);
run(EXPERIMENT.param);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ---------------------------Задержка-------------------------------------
for i=1:Modul.Delay;
    Modul.Rules_Delay{i}=Rules;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% -----------------------INI начальных позиций----------------------------
if isempty(EXPERIMENT) || ~isfield(EXPERIMENT,'StartPositionINI') || isempty(EXPERIMENT.StartPositionINI)
    StartPositionINI();
else
    run(EXPERIMENT.StartPositionINI);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Цикл
tic();
fprintf('---Start Modul!---\n');
while(Modul.T+Modul.dT<=Modul.Tend )    
    Rules=zeros(30,7);
    %----------------------------------------------------------------------
    Modul.N=Modul.N+1;
    Modul.T=Modul.T+Modul.dT;    
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
    %-----------------------------------Dynamics---------------------------
    if isempty(EXPERIMENT) || ~isfield(EXPERIMENT,'Dynamics') || isempty(EXPERIMENT.Dynamics)
        Dynamics();
    else
        run(EXPERIMENT.Dynamics);
    end
end
%figure(201)
%axis([0,Modul.N,400,1400])
iso_save_param
Modul.T
fprintf('Time: %d \n',toc())