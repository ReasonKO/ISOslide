global iso_save Modul exp3_data
if    abs(iso_save.dold(1)-exp3_data.Cv)<10
    Modul.Tsave=Modul.T;
    Modul.T=Modul.Tend;
end


global SAVE_results Yellows
if Modul.PlotPulse
    if isempty(SAVE_results)
        SAVE_results.position=[];
    end
    SAVE_results.position=[SAVE_results.position;Yellows(1,1:4)];
end