global MAP_PAR
global iso_par
global PAR
global Modul
if isfield(MAP_PAR,'SAVEMAP')
    saveas(1001,[MAP_PAR.SAVEMAP.name,'/','GroupState','.png']);
    saveas(201,[MAP_PAR.SAVEMAP.name,'/','UnitState','.png']);
    saveas(204,[MAP_PAR.SAVEMAP.name,'/','vLen','.png']);

    fid=fopen([MAP_PAR.SAVEMAP.name,'/','param.txt'],'wb');
    fwrite(fid,sprintf('iso_experiment : %s \n',MAP_PAR.SAVEMAP.name),'int16');    
    fwrite(fid,sprintf('---iso_par---\n'),'int16');
    fldnms=fieldnames(iso_par);
    for i=1:length(fldnms)
        field=getfield(iso_par,fldnms{i});
        if (isnumeric(field)==1 && numel(field)==1)
            fwrite(fid,sprintf('\t%s = %d \n',fldnms{i},field),'int16');
        end
    end
    
    fwrite(fid,sprintf('---Modul---\n'),'int16');
    fldnms=fieldnames(Modul);
    for i=1:length(fldnms)
        field=getfield(Modul,fldnms{i});
        if (isnumeric(field)==1 && numel(field)==1)
            fwrite(fid,sprintf('\t%s = %d \n',fldnms{i},field),'int16');
        end
    end
    
    fwrite(fid,sprintf('---PAR---\n'),'int16');
    fldnms=fieldnames(PAR);
    for i=1:length(fldnms)
        field=getfield(PAR,fldnms{i});
        if (isnumeric(field)==1 && numel(field)==1)
            fwrite(fid,sprintf('\t%s = %d \n',fldnms{i},field),'int16');
        end
    end
    fclose(fid);
end
