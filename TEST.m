figure(1003)
clf
hold on
V_=0.1;
x=[0,0,0];
hx=plot(x(1),x(2),'Ro');
hxl=plot(x(1),x(2),'R-');
x2=x;
hx2=plot(x2(1),x2(2),'Bo');
hxl2=plot(x2(1),x2(2),'B-');

axis([000,2000,-1000,1000]);


figure(1004)
clf
hold on
hv1=plot(0,norm(V),'R');
hv2=plot(0,norm(V),'B');

V=20*[cos(x(3)),sin(x(3))];
V2m=norm(V);
V2=[10,0];
x2=x;
%a=[1,0];

af=@(i)3*[0,cos(i/100)];
dt=0.1;

for i=1:1000
    %V=V_*[cos(x(3)),sin(x(3))];
    a=af(i);
    V=V+a*dt;
    x=x+[V,0]*dt;


    ae=rotV(a,-x2(3));
    V2m=V2m+ae(1)*dt;
    U2=ae(2)/V2m;
    V2=V2m*[cos(x2(3)),sin(x2(3))];
    %x2=x2+[V2,U2]*dt;
    [x2(1),x2(2),x2(3)]=extrap(x2(1),x2(2),x2(3),V2m,U2,dt);
    addPlotData(hxl,x(1),x(2));
    setPlotData(hx,x(1),x(2));
    addPlotData(hxl2,x2(1),x2(2));
    setPlotData(hx2,x2(1),x2(2));

    addPlotData(hv1,i,norm(V));
    addPlotData(hv2,i,norm(V2));
    drawnow

    
end