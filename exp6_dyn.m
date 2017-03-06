global Yellows iso_par exp6_data Modul
global Save_iso
for i=1:iso_par.Nagent
    if iso_par.Rul2Uconf
        V=norm(exp6_data.V(i,:));
        ae=rotV(exp6_data.a(i,:),-Yellows(i,4));
        U=ae(2)/V;
        U=max(-iso_par.Umax,min(iso_par.Umax,U));
        V=V+ae(1)*Modul.dT;
        V=min(V,iso_par.Vmax);
        [re(1),re(2),re(3)]=extrap(Yellows(i,2),Yellows(i,3),Yellows(i,4),...
            V,U,Modul.dT);
        Ureal=azi(re(3)-Yellows(i,4))/Modul.dT;
        Vreal=norm(re(1:2)-Yellows(i,2:3),2)/Modul.dT;
%[1,i,norm(re(1:2)-Yellows(i,2:3),2)]

        Yellows(i,2:4)=re;
        exp6_data.V(i,:)=V*[cos(Yellows(i,4)),sin(Yellows(i,4))];
%         if (Modul.N==3)
%             figure(200+i);
%             subplot(4,2,8)
%             hold on
%             Save_iso.Ureal2(i)=plot(0,U,'R');
%             Save_iso.Ureal3(i)=plot(0,U,'G');
%             subplot(4,2,7)
%             hold on
%             Save_iso.Vreal2(i)=plot(0,V,'R');
%             Save_iso.Vreal3(i)=plot(0,U,'G');
%         end
%         if (Modul.N>3)
%             addPlotData(Save_iso.Ureal2(i),Modul.T,U);
%             addPlotData(Save_iso.Vreal2(i),Modul.T,V);
%             addPlotData(Save_iso.Ureal3(i),Modul.T,Ureal);
%             addPlotData(Save_iso.Vreal3(i),Modul.T,Vreal);
%         end    
        
    else
        Yellows(i,2:3)=Yellows(i,2:3)+exp6_data.V(i,:)*Modul.dT;
        %Uneed=atan2(exp6_data.a(i,2),exp6_data.a(i,1));
        exp6_data.V(i,:)=exp6_data.V(i,:)+exp6_data.a(i,:)*Modul.dT;
        Yellows(i,4)=atan2(exp6_data.V(i,2),exp6_data.V(i,1));

    end
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
    T=Modul.T*1.5;
    if T>300
        T=T-300;
    end
    if T>300
        T=T-300;
    end
    exp6_data.C=[min(T,100),max(0,min((T-100),100))]-[50,50]...
        -[max(0,min((T-200),100)),max(0,min((T-200),100))];
end
if Modul.PlotPulse
    setPlotData(exp3_ADDviz.C,exp6_data.C(1),exp6_data.C(2));
    setPlotData(exp3_ADDviz.Co,exp6_data.C(1)+iso_par.d0*sin(0:pi/10:2*pi),exp6_data.C(2)+iso_par.d0*cos(0:pi/10:2*pi));
end