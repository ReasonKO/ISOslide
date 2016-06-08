%clear all
%iso_ini_def
exp3_2_INI

%MAP_INI
%Инициализация структуры MAP и создание figure(100)
%для быстрой последовательной отрисовки кадров.
%%
global Blues
global Yellows
clear MAP_PAR; 
global MAP_PAR;
MAP_PAR.MAP_H=figure(100);
clf
hold on;grid off;
xlabel('metres');
ylabel('metres');
global PAR;
if (isempty(PAR))
    fprintf('PAR is not initialized/f');
    return;
end
axis equal
axis([-PAR.MAP_X/2,PAR.MAP_X/2,-PAR.MAP_Y/2,PAR.MAP_Y/2,0,1]);
%plot(C(1)+300*sin(0:0.1:2*pi),C(2)+300*cos(0:0.1:2*pi));
set(gca,'Color',[0.95 0.95 0.95]);

MAP_PAR.viz_Balls=[];

for i=1:size(Blues,1)
    MAP_PAR.viz_Blues{i}=[];
end
for i=1:size(Yellows,1)
    MAP_PAR.viz_Yellows{i}=[];
end


%% 
figure(998)
%clf
axis([-300,100,-200,150]);
hold on
%exp3_ADDviz
%plot(exp3_data.C(1),exp3_data.C(2),'G*');%,'MarkerSize',25);
%plot(exp3_data.C(1),exp3_data.C(2),'Go');%,'MarkerSize',25);
%MAP
%if ~isfield(exp3_data,'P_H') || isempty(exp3_data.P_H)  
Z=field.Zm{1};
Z(Z==0)=NaN;
field.Zm{1}=Z;
    for i=1:length(field.Zm)
        exp3_data.P_H{i}=surf(field.Xm{i},field.Ym{i},field.Zm{i},'EdgeColor','none');
        set(exp3_data.P_H{i},'FaceColor',[1,1,1])
    end
%     mycolor=[0.95,0.95,0.95;
%              0.95,0.95,0.95;
%              0 0 1;
%              0 0 1];
    %colormap(mycolor);      
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