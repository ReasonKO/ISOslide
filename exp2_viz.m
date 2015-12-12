global PAR exp2_data iso_par Blues
MAP_D=100;
%colormap(copper);%copper gray

[X,Y] = meshgrid(PAR.MAP_X/2*(-1:1/MAP_D:1),PAR.MAP_Y/2*(-1:1/MAP_D:1));
Z=iso_D(X,Y);
R=10;
if ~isfield(exp2_data,'viz_iso_1')
    for i=1:size(Blues,1)
         exp2_data.C(i)=plot(0,0,'K');
    end
    figure(100)
    Zisoline=[iso_par.d0,iso_par.d0];
    Zisoline2=[iso_par.d0+iso_par.d0d,iso_par.d0+iso_par.d0d];
    [~,exp2_data.viz_iso_1]=contour(X,Y,Z,Zisoline);
    [~,exp2_data.viz_iso_2]=contour(X,Y,Z,Zisoline2,'B');
    set(exp2_data.viz_iso_1,'color',[0,0.6,0]);
    set(exp2_data.viz_iso_1,'LineWidth',3);
    set(exp2_data.viz_iso_2,'LineWidth',1.5);
end
%%
set(exp2_data.viz_iso_1,'zdata',Z);
set(exp2_data.viz_iso_2,'zdata',Z);
for i=1:size(Blues,1)
    setPlotData(exp2_data.C(i),Blues(i,2)+R*cos(-pi:pi/10:pi),...
                               Blues(i,3)+R*sin(-pi:pi/10:pi));
end

        