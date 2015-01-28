global MAP_PAR;
if (isfield(MAP_PAR,'MAP_H') && ishandle(MAP_PAR.MAP_H) && isequal('on',get(MAP_PAR.MAP_H,'Visible')))
    global Modul
    if (~isempty(Modul) && Modul.SaveExp)
        if (~isfield(MAP_PAR,'SAVEMAP'))
            MAP_PAR.SAVEMAP.tick=0;
            MAP_PAR.SAVEMAP.freq=50;    
            c=clock;
            MAP_PAR.SAVEMAP.name=sprintf('%d.%02d.%02d-%02d.%02d',c(1),c(2),c(3),c(4),c(5));
            mkdir(MAP_PAR.SAVEMAP.name);
        end
        if (mod(MAP_PAR.SAVEMAP.tick,MAP_PAR.SAVEMAP.freq)==0)
            saveas(MAP_PAR.MAP_H,[MAP_PAR.SAVEMAP.name,'/','map',int2str(MAP_PAR.SAVEMAP.tick),'.png']);
        end
        MAP_PAR.SAVEMAP.tick=MAP_PAR.SAVEMAP.tick+1;
    end
end