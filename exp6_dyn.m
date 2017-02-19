global Yellows iso_par exp6_data Modul
for i=1:iso_par.Nagent
    Yellows(i,2:3)=Yellows(i,2:3)+exp6_data.V(i,:)*Modul.dT;
  
    %Uneed=atan2(exp6_data.a(i,2),exp6_data.a(i,1));
    
    exp6_data.V(i,:)=exp6_data.V(i,:)+exp6_data.a(i,:)*Modul.dT;
    Yellows(i,4)=atan2(exp6_data.V(i,2),exp6_data.V(i,1));
    
end

global exp3_ADDviz
%exp6_data.C=90*[-cos(Modul.T/100),sin(Modul.T/100)];
setPlotData(exp3_ADDviz.C,exp6_data.C(1),exp6_data.C(2));