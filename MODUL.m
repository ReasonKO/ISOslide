%% НАСТРОЙКА ПАРАМЕТРОВ
global Modul iso_par PAR treckcolor MODUL_ON iso_MODUL_ON;
global Pause Rules Balls Blues Yellows Greens;  
%% Пользовательские параметры 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ---------------------------Задержка-------------------------------------
for i=1:Modul.Delay;
    Modul.Rules_Delay{i}=Rules;
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
    Modul.PlotPulse=mod(Modul.N,floor(Modul.freq/Modul.dT))==0;

    iso_main; 
    if Modul.PlotPulse
        if Modul.isoMAPviz
                iso_MAP();
        end
        iso_par.AddViz();
        if Modul.MAPviz
            MAP();
        end
        drawnow();
        iso_save_map();        
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
    iso_par.Dynamic();
end
iso_save_param
Modul.T
fprintf('Time: %d \n',toc())