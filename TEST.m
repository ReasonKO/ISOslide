figure(1003)
clf
hold on
V_=0.1;
x=[0,0,0];
hx=plot(x(1),x(2),'Ro');
hxl=plot(x(1),x(2),'R-');
axis([-1000,1000,-1000,1000]);

    a=[1,0];
dt=0.1;
for i=1:1000
    %V=V_*[cos(x(3)),sin(x(3))];
    V=V+a*dt;
    x=x+[V,0];
    addPlotData(hxl,x(1),x(2));
    setPlotData(hx,x(1),x(2));
    drawnow
end