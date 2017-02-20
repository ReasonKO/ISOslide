global Yellows iso_par exp6_data Modul
for i=1:iso_par.Nagent
    Yellows(i,2:3)=Yellows(i,2:3)+exp6_data.V(i,:)*Modul.dT;
  
    %Uneed=atan2(exp6_data.a(i,2),exp6_data.a(i,1));
    
    exp6_data.V(i,:)=exp6_data.V(i,:)+exp6_data.a(i,:)*Modul.dT;
    Yellows(i,4)=atan2(exp6_data.V(i,2),exp6_data.V(i,1));
    
end

global exp3_ADDviz
if iso_par.SCENARIO6==1
    exp6_data.C=90*[-cos(Modul.T/100),sin(Modul.T/100)/2];
end
if iso_par.SCENARIO6==2
    T=Modul.T*2;
    exp6_data.C=90*[-cos(2*atan(sin(T/200)))+sin(T/300),atan(T/500)-1+sin(T/100)/2];
end
if iso_par.SCENARIO6==3
    exp6_data.C=90*[-cos(Modul.T/100),sin(Modul.T/100)/2];
end
if Modul.PlotPulse
    setPlotData(exp3_ADDviz.C,exp6_data.C(1),exp6_data.C(2));
    setPlotData(exp3_ADDviz.Co,exp6_data.C(1)+iso_par.d0*sin(0:pi/10:2*pi),exp6_data.C(2)+iso_par.d0*cos(0:pi/10:2*pi));
end