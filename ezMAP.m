% global iso_par
% figure(113)
% clf
% [X,Y] = meshgrid((-300:10:300),(-300:10:300));
% %    Z=iso_D(X,Y);
% Z=iso_par.re_D(X,Y);
% ISO_MAP_PAR.viz_surf=surf(X,Y,Z);
% set(ISO_MAP_PAR.viz_surf, 'EdgeColor', 'none')
% Zisoline=[iso_par.d0-iso_par.d0d,iso_par.d0,iso_par.d0+iso_par.d0d];
% hold on
% [C,ISO_MAP_PAR.viz_cont]=contour3(X,Y,Z,Zisoline,'K');
% figure(114)
% dX=(Z-iso_par.re_D(X+0.001,Y))/0.001;
% dY=(Z-iso_par.re_D(X,Y+0.001))/0.001;
% dZ=sqrt(dX.^2+dY.^2);
% ISO_MAP_PAR.viz_surf=mesh(X,Y,dZ);
iso_par.re_D=@(x,y)700+200*exp(-((exp3_data.C(1)-x).^2/200^2+(exp3_data.C(2)-y).^2/100^2));

global iso_par
figure(113)
clf
[X,Y] = meshgrid((-300:10:300),(-300:10:300));
iso_par.re_D2=@(x,y)1000-sqrt((exp3_data.C(1)-x).^2+(exp3_data.C(2)-y).^2);
Z2=iso_par.re_D2(X,Y);
ISO_MAP_PAR.viz_surf=surf(X,Y,Z2);
hold on
%    Z=iso_D(X,Y);
Z=iso_par.re_D(X,Y);
ISO_MAP_PAR.viz_surf=surf(X,Y,Z);
set(ISO_MAP_PAR.viz_surf, 'EdgeColor', 'none')
Zisoline=[iso_par.d0-iso_par.d0d,iso_par.d0,iso_par.d0+iso_par.d0d];
hold on
[C,ISO_MAP_PAR.viz_cont]=contour3(X,Y,Z,Zisoline,'K');
figure(114)
clf
dX=(Z-iso_par.re_D(X+0.001,Y))/0.001;
dY=(Z-iso_par.re_D(X,Y+0.001))/0.001;
dZ=sqrt(dX.^2+dY.^2);
ISO_MAP_PAR.viz_surf=mesh(X,Y,dZ);
hold on
dX2=(Z2-iso_par.re_D2(X+0.001,Y))/0.001;
dY2=(Z2-iso_par.re_D2(X,Y+0.001))/0.001;
dZ2=sqrt(dX2.^2+dY2.^2);
ISO_MAP_PAR.viz_surf=mesh(X,Y,dZ2);
