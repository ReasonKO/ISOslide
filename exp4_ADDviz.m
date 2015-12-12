global exp3_data field iso_par

ln=length(field.Zm);
if ~isfield(exp3_data,'P_H') || isempty(exp3_data.P_H)  
    for i=1:length(field.Zm)
        exp3_data.P_H{i}=surf(field.Xm{i},field.Ym{i},field.Zm{i},'EdgeColor','none');
    end
    mycolor=[0.95,0.95,0.95;
             0.95,0.95,0.95;
             0 0 1;
             0 0 1];
    colormap(mycolor);      
    hold on
else
    for i=1:length(field.Zm)
        setPlotData(exp3_data.P_H{i},field.Xm{i},field.Ym{i},field.Zm{i});  
    end
end