exp2_INI

global exp2_data iso_par
exp2_data.MOD2=1;
%0 - ломаная
%1 - гладкий
exp2_data.al=10000;
 exp2_viz
delete(exp2_data.viz_iso_2);

%% 
exp2_data.al=0.5;
 [X,Y] = meshgrid(PAR.MAP_X/2*(-1:1/MAP_D:1),PAR.MAP_Y/2*(-1:1/MAP_D:1));
 Z=iso_D(X,Y);
 R=10;
 figure(100)
 Zisoline=[iso_par.d0,iso_par.d0]+1;
 [~,exp2_data.viz_iso_1]=contour(X,Y,Z,Zisoline);
    set(exp2_data.viz_iso_1,'color',[0.5,0.5,0.5]);
    set(exp2_data.viz_iso_1,'LineWidth',3);

%% 
exp2_data.al=0.2;

[X,Y] = meshgrid(PAR.MAP_X/2*(-1:1/MAP_D:1),PAR.MAP_Y/2*(-1:1/MAP_D:1));
 Z=iso_D(X,Y);
 R=10;
 figure(100)
 Zisoline=[iso_par.d0,iso_par.d0]+3;
 [~,exp2_data.viz_iso_1]=contour(X,Y,Z,Zisoline);
    set(exp2_data.viz_iso_1,'color',[0,1,0]);
    set(exp2_data.viz_iso_1,'LineWidth',3);
%% 
exp2_data.al=0.35;
 [X,Y] = meshgrid(PAR.MAP_X/2*(-1:1/MAP_D:1),PAR.MAP_Y/2*(-1:1/MAP_D:1));
 Z=iso_D(X,Y);
 R=10;
 figure(100)
 Zisoline=[iso_par.d0,iso_par.d0]+2
 [~,exp2_data.viz_iso_1]=contour(X,Y,Z,Zisoline);
    set(exp2_data.viz_iso_1,'color',[0,0,1]);
    set(exp2_data.viz_iso_1,'LineWidth',3);
%% 
exp2_data.al=0.7;
 [X,Y] = meshgrid(PAR.MAP_X/2*(-1:1/MAP_D:1),PAR.MAP_Y/2*(-1:1/MAP_D:1));
 Z=iso_D(X,Y);
 R=10;
 figure(100)
 Zisoline=[iso_par.d0,iso_par.d0];
 [~,exp2_data.viz_iso_1]=contour(X,Y,Z,Zisoline);
    set(exp2_data.viz_iso_1,'color',[1,0,0]);
    set(exp2_data.viz_iso_1,'LineWidth',3);


