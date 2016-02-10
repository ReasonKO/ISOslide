function iso_save_map()
global MAP_PAR iso_par Modul
if (isfield(MAP_PAR,'MAP_H') && ishandle(MAP_PAR.MAP_H) && isequal('on',get(MAP_PAR.MAP_H,'Visible')))
    if (~isempty(Modul) && Modul.SaveExp)
        if (~isfield(MAP_PAR,'SAVEMAP'))
            MAP_PAR.SAVEMAP.tick=0;
            MAP_PAR.SAVEMAP.freq=Modul.save_freq;    
            c=clock;
            MAP_PAR.SAVEMAP.name=sprintf('%s(%d.%02d.%02d-%02d.%02d)',iso_par.ExpName,c(1),c(2),c(3),c(4),c(5));
            mkdir(MAP_PAR.SAVEMAP.name);
        end
        if (mod(MAP_PAR.SAVEMAP.tick,MAP_PAR.SAVEMAP.freq)==0 || Modul.T>=Modul.Tend)
            saveas(MAP_PAR.MAP_H,[MAP_PAR.SAVEMAP.name,'/','map',int2str(MAP_PAR.SAVEMAP.tick),'.png']);
        end
        MAP_PAR.SAVEMAP.tick=MAP_PAR.SAVEMAP.tick+1;
    end
end