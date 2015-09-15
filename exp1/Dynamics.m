global Modul iso_par PAR treckcolor MODUL_ON iso_MODUL_ON;
global Pause Rules Balls Blues Yellows Greens;  
if (iso_par.mooved)
    FieldSpeed=5;        
    Period=600;
    Ct=mod(Modul.T*iso_par.Tspeed+Period/4,Period);
    if (Ct>Period/2)
        Blues(1:23,[2,3])=Blues(1:23,[2,3])+FieldSpeed*ones(23,2)*Modul.dT;
        BluesSTART(1:23,[2,3])=BluesSTART(1:23,[2,3])+FieldSpeed*ones(23,2)*Modul.dT;
    else
        Blues(1:23,[2,3])=Blues(1:23,[2,3])-FieldSpeed*ones(23,2)*Modul.dT;
        BluesSTART(1:23,[2,3])=BluesSTART(1:23,[2,3])+FieldSpeed*ones(23,2)*Modul.dT;
    end
end
KopashatSpeed=100;
if (iso_par.mix)
    for i=1:23
        Blues(i,[2,3])=BluesSTART(i,[2,3])+[sin(i*10+Modul.T/(2+mod(i,5)*2)),cos(i*30+Modul.T/(3+mod(i,5)*3))]*KopashatSpeed;
    end
end
if (MOD2==3)
% 1 v pole voin
    for i=1:6
        Blues(i,2:3)=[sin(i*10+Modul.T/(2+i*2)),cos(i*30+Modul.T/(3+i*3))]*200-[2000,0]*(MOD1==5);
    end
    if (Modul.T>200)
        Blues(8,2:3)=Blues(8,2:3)+[Modul.T-200,0]*4;
    end
    for i=7:12
        Blues(i,2:3)=[sin(i*10+Modul.T/(2+i*2)),cos(i*30+Modul.T/(3+i*3))]*200+[2000,0]*(MOD1==5);
    if (MOD1==5)
        Blues(i,1)=1;
    end
    end
%         for i=2:8
%             Blues(i,2:3)=Blues(1,2:3)+[sin(i*10+Modul.T/(2+i*2)),cos(i*30+Modul.T/(3+i*3))]*200;
%         end
%     end
else
    %*******************************
    % migration 2
    sb=Blues(1,2:3);
    if (Modul.T<1200 || MOD2==1)
        th=+pi*Modul.T/1500;
        th2=th;
        pd=-pi/2;
    else
        th=pi*1200/1500+pi-pi*(Modul.T-1200)/1500;
        th2=pi*1200/1500-pi*(Modul.T-1200)/1500;
        pd=pi/2;
    end

    for i=1:1
        Blues(i,2:3)=Blues(i,2:3)+10*[cos(pd-th),sin(pd-th)]*Modul.dT;
    end
    if (get(0,'CurrentFigure')==100)
        if (isfield(MAP_PAR,'Track2'))
            xd=get(MAP_PAR.Track2,'xdata');
            yd=get(MAP_PAR.Track2,'ydata');
            set(MAP_PAR.Track2,'xdata',[xd(1:end),Blues(1,2)/100],'ydata',[yd(1:end),Blues(1,3)/100]);            
        else            
            MAP_PAR.Track2=plot(Blues(1,2)/100,Blues(1,3)/100,'color',[0,0,0],'LineWidth',1.2);
        end
    %    plot([sb(1),Blues(1,2)],[sb(2),Blues(1,3)],'K');
    end
    m=-6;
    Mth=[cos(th2),-sin(th2);sin(th2),cos(th2)];
    Blues(2,2:3)=Blues(1,2:3)+[0,50]*Mth*m;
    Blues(3,2:3)=Blues(1,2:3)+[30,-20]*Mth*m;
    Blues(4,2:3)=Blues(1,2:3)+[60,-90]*Mth*m;
    Blues(5,2:3)=Blues(1,2:3)+[0,-40]*Mth*m;
    Blues(6,2:3)=Blues(1,2:3)+[-60,-90]*Mth*m;
    Blues(7,2:3)=Blues(1,2:3)+[-30,-20]*Mth*m;
    if (MOD1==2)
        Blues(8,2:3)=Blues(1,2:3)+[sin(pi/2*Modul.T/30),cos(pi/2*Modul.T/30)]*[100+Modul.T/8]*abs(m);
    end
    if (MOD1==3)
        Blues(8,2:3)=Blues(1,2:3)+[0,60+Modul.T/8]*Mth*m;
    end
    if (MOD1==4)
        for i=2:8
            Blues(i,2:3)=Blues(1,2:3)+[sin(i*10+Modul.T/(2+i*2)),cos(i*30+Modul.T/(3+i*3))]*200;
        end
    end
    if (MOD1==5)
        for i=2:8
            Blues(i,2:3)=Blues(1,2:3)+[sin(i*10+Modul.T/(2+i*2)),cos(i*30+Modul.T/(3+i*3))]*200;
        end
    end
end    