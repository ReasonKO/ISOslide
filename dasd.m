%clear all
%iso_ini_def
exp3_2_INI

MAP_INI
figure(998)
%clf
axis([-300,100,-200,150]);
hold on
%exp3_ADDviz
%plot(exp3_data.C(1),exp3_data.C(2),'G*');%,'MarkerSize',25);
%plot(exp3_data.C(1),exp3_data.C(2),'Go');%,'MarkerSize',25);
%MAP
%if ~isfield(exp3_data,'P_H') || isempty(exp3_data.P_H)  
    for i=1:length(field.Zm)
        exp3_data.P_H{i}=surf(field.Xm{i},field.Ym{i},field.Zm{i},'EdgeColor','none');
    end
    mycolor=[0.95,0.95,0.95;
             0.95,0.95,0.95;
             0 0 1;
             0 0 1];
    colormap(mycolor);      
    hold on
    if 1
        [X,Y]=meshgrid(-300:10:300,-300:10:300);
        Z=ones(size(X));
        for i=1:size(X,1)
            for j=1:size(X,1)
                Z(i,j)=exp3_re_P([X(i,j),Y(i,j),0]);
            end
        end
        [~,exp3_data.HP]=contour(X,Y,Z-iso_par.d0+1,[1,1,1],'R--');
    end