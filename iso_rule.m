function iso_rules=iso_rule(Robots)
%%-------------------------------------------------------------------------
global Modul; % Параметры модели
global iso_par; %Параметры алгаритма
%N=size(Robots,1);
N=iso_par.Nagent;
iso_rules=zeros(N,2);
%% Параметры алгоритма
R_vision =iso_par.R_vision;  %800; %Радиус видимости робота.
Fi_vision=iso_par.Fi_vision; %0.5*pi/2; % Угол видимости робота
Rd_vision=iso_par.Rd_vision; %R_vision/N*0.9; % Радиус ближайших
e=iso_par.e; %(V_-V_min)/N/50; %коэфициент замедления для ряда ближайших
%% Параметры роботов
V_   =iso_par.Vmax; %70; %Номинальная линейная скорость
V_min=iso_par.Vmin; %10; %Номинальная линейная скорость
U_   =iso_par.Umax; %30  %Номинальный скорость поворота %U_=20..80, U_+V_=100

uslide=0.25;%0.25%1.34;
dslide=0.07;
islide=0.015;%P/10
%% Сохранение шага
global ISO_VISION;
global iso_save;
if isempty(iso_save)
    iso_save.dold=zeros(N,1);
    iso_save.kenem=zeros(N,1);
    iso_save.sPmin=zeros(N,1);
    iso_save.Vreal_old=zeros(N,1);
    iso_save.Robots_old=Robots;
    iso_save.Uold=zeros(N,1);
    iso_save.SU=zeros(N,1);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Speed(Vreal)----------------------------------------------
%% Старый вариант----------------------------------------------------------
%ONisoline=zeros(N,1);
%for i=1:N
%    ONisoline(i)=abs(iso_par.D(Robots(i,2),Robots(i,3))-iso_par.d0)<iso_par.d0d;
%end
%delta=ones(N,1);
% for i=1:N
%     if (Robots(i,1)>0)  
%         %------------V-------------------
%         delta(i)=1;
%         if (ONisoline(i))        
%             angv=angV(Robots(i,2:3)-iso_par.C);
%             angvm=2*pi;
%             js=i;
%             for j=1:N
%                 if (Robots(j,1)>0 && ONisoline(j))
%                     angvn=rem(azi(-angV(Robots(j,2:3)-iso_par.C)+angv)-0.001+2*pi,2*pi)+0.001;
%                     if (angvn<angvm)
%                         js=j;
%                         angvm=angvn;
%                     end
%                 end                    
%             end
%             if (angvm<pi)
%                 delta(i)=2/pi*atan(norm(Robots(i,2:3)-Robots(js,2:3),2)/500);
%             end
%         end
%     end
% end
% delta=delta/max(delta);
% if (~isempty(find(delta<0)))
%     error('delta<0');
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Новый вариант распределения скоростей-----------------------------------
% i - номер робота в Robots(i,:)
% Robots(i,1) - робот находится на поле?
% Robots(i,2) - координата х
% Robots(i,3) - координата у
% Robots(i,4) - угол направления движения
% azi(ang) - приводит угол ang к значению (-pi,pi]
% angV([x,y]) - находит угол вектора [x,y]

%%------------Инициализация переменных
delta=ones(N,1);
P=inf*ones(N,N); %Матрица расстояний
Pmin=zeros(N,1); %Вектор наименьших расстояний
index=zeros(N,1);
vizLength=zeros(N,1);
viz_ang_Rd=(-pi/2-Fi_vision):0.1:(+pi/2-Fi_vision); %---Для вывода


CloudyMatrix=zeros(N,N);

for i=1:N
    for j=(i+1):N
        Lzt=50;
        Zt=repmat(Robots(i,2:3),[Lzt,1])+(1:Lzt)'/Lzt*(Robots(j,2:3)-Robots(i,2:3));
        Dt=iso_D(Zt(:,1),Zt(:,2));
        CloudyMatrix(i,j)=~isempty(find((Dt<50),1));
        CloudyMatrix(j,i)=CloudyMatrix(i,j);        
    end
end

for i=1:N
if (Robots(i,1)>0)  
    iso_save.kenem(i)=0;
    for j=1:N
%%------------------- P
    if (i~=j && Robots(j,1)>0)  
        if ((norm(Robots(i,2:3)-Robots(j,2:3))<=R_vision) ...
            && (abs(azi(angV(Robots(j,2:3)-Robots(i,2:3))-Robots(i,4)))<Fi_vision))
            %Расстояние до левой границы видимости
            dr1=abs(sin(angV(Robots(j,2:3)-Robots(i,2:3))-(Robots(i,4)-Fi_vision)))*norm(Robots(i,2:3)-Robots(j,2:3));
            %Расстояние до правой границы видимости
            dr2=abs(sin(angV(Robots(j,2:3)-Robots(i,2:3))-(Robots(i,4)+Fi_vision)))*norm(Robots(i,2:3)-Robots(j,2:3));
            %dr1=abs(cos((Robots(i,4)-Fi_vision))*(Robots(j,3)-Robots(i,3))+sin((Robots(i,4)-Fi_vision))*(Robots(j,2)-Robots(i,2)));
            %dr2=abs(cos((Robots(i,4)+Fi_vision))*(Robots(j,3)-Robots(i,3))+sin((Robots(i,4)+Fi_vision))*(Robots(j,2)-Robots(i,2)));            
            %Минимальное расстояние до границы видимости
            P(i,j)=min(dr1,dr2);
%%------------------- Ke
            %Ищем ближайших и считаем длину строя.
            if (norm(Robots(i,2:3)-Robots(j,2:3))<=Rd_vision)
                iso_save.kenem(i)=min(iso_save.kenem(i),iso_save.kenem(j)+1);
            end
            iso_save.kenem(i)=min(iso_save.kenem(i),N);
            %[i,j,dr1,dr2,P(i,j)] 
        end
%%------------------- P(i,j)=0
        %Ищем ближайщих сбоку.
        if ((norm(Robots(i,2:3)-Robots(j,2:3))<=Rd_vision)...
            && (abs(azi(angV(Robots(j,2:3)-Robots(i,2:3))-pi/2-Robots(i,4)))<pi/2-Fi_vision))
            P(i,j)=0;
        end
    end
    end
%%------------------- re
    if (iso_par.VidVisible)
        P(CloudyMatrix==1)=inf;
    end
    %Берём наименьшее расстояние по всем роботам и нормируем
    Pmax=R_vision*sin(Fi_vision);
    Pmin(i)=min(1,min(P(i,:))/Pmax);
    [Z,index(i)]=min(P(i,:));
    %[i,index(i),P(i,index(i)),Z]
    if (P(i,index(i))==inf)
        index(i)=0;
    end
    if (index(i)~=0)
        vizLength(i)=norm(Robots(i,2:3)-Robots(index(i),2:3),2);
    else
        vizLength(i)=NaN;
    end
    
    %Превращаем P в delta(нормированная по V_).
    %V():[0..1] -> ([V_min+N*e..V_]-Ke*e) -> [0,1] (линейная)
    %delta(i)=Pmin(i);
    delta(i)=( (1-Pmin(i))*(V_min+N*e) + Pmin(i)*V_ - iso_save.kenem(i)*e )/V_;
%=========================графика==========================================
if ~isempty(Modul)
    if (iso_par.SectorVisual)
        drawx=Robots(i,2)+R_vision*[0,cos(Robots(i,4)-Fi_vision),cos((Robots(i,4)-Fi_vision):0.2:(Robots(i,4)+Fi_vision)),cos(Robots(i,4)+Fi_vision),0];
        drawy=Robots(i,3)+R_vision*[0,sin(Robots(i,4)-Fi_vision),sin((Robots(i,4)-Fi_vision):0.2:(Robots(i,4)+Fi_vision)),sin(Robots(i,4)+Fi_vision),0];
        %drawx=[drawx,Robots(i,2)+[0,Rd_vision*cos(Robots(i,4)+pi/2+viz_ang_Rd),0]];
        %drawy=[drawy,Robots(i,3)+[0,Rd_vision*sin(Robots(i,4)+pi/2+viz_ang_Rd),0]];
            %plot(Robots(i,2)+Rd_vision*cos(0:0.1:2*pi),Robots(i,3)+Rd_vision*sin(0:0.1:2*pi),'R');
        if (Modul.N>1)
            if (~isfield(ISO_VISION,'viz') || size(ISO_VISION.viz,2)<i)
                ISO_VISION.viz(i)=plot(drawx/100,drawy/100,'K');
            else
                set(ISO_VISION.viz(i),'xdata',drawx/100,'ydata',drawy/100);
            end    
        end    
    end
end
%     if ~isempty(Modul)
%         drawx=Robots(i,2)+R_vision*[0,cos(Robots(i,4)-Fi_vision),cos((Robots(i,4)-Fi_vision):0.2:(Robots(i,4)+Fi_vision)),cos(Robots(i,4)+Fi_vision),0];
%         drawy=Robots(i,3)+R_vision*[0,sin(Robots(i,4)-Fi_vision),sin((Robots(i,4)-Fi_vision):0.2:(Robots(i,4)+Fi_vision)),sin(Robots(i,4)+Fi_vision),0];
%         drawx=[drawx,Robots(i,2)+[0,Rd_vision*cos(Robots(i,4)+pi/2+viz_ang_Rd),0]];
%         drawy=[drawy,Robots(i,3)+[0,Rd_vision*sin(Robots(i,4)+pi/2+viz_ang_Rd),0]];
%             %plot(Robots(i,2)+Rd_vision*cos(0:0.1:2*pi),Robots(i,3)+Rd_vision*sin(0:0.1:2*pi),'R');
%         if (Modul.N>1)
%             if (Modul.N==2)
%                 ISO_VISION.viz(i)=plot(drawx,drawy);
%             else
%                 set(ISO_VISION.viz(i),'xdata',drawx,'ydata',drawy);
%             end    
%         end
%     end
%--------------------------------------------------------------------------
end
end

%=========графики для каждого робота=======================================
if ~isempty(Modul)
    if (iso_par.VidVisible)
        iso_save.sPmin=[iso_save.sPmin,Pmin];
        if (Modul.N==1)
            figure(1001);
            title('???????? Pmin ??? ??????? ??????');
            for i=1:N
                subplot(floor((N-1)/4)+1,4,i)
                ISO_VISION.vizPmin(i)=plot(0:Modul.N,iso_save.sPmin(i,:));
            end
        else
            for i=1:N
                set(ISO_VISION.vizPmin(i),'xdata',0:Modul.N,'ydata',iso_save.sPmin(i,:));
            end
        end
    end
    iso_save.sPmin=[iso_save.sPmin,Pmin];
    if (Modul.N==1)
        figure(1001);
        for i=1:N
            subplot(floor((N-1)/4)+1,4,i)
%            ISO_VISION.vizPmin(i)=plot(0:Modul.N,iso_save.sPmin(i,:));
        end
    else
        for i=1:N
            set(ISO_VISION.vizPmin(i),'xdata',0:Modul.N,'ydata',iso_save.sPmin(i,:));
        end
    end
end
% %======Вывод в comand window (убрать ';')==================================
% iso_save.kenem';
% P;
% Pmin';
% delta=delta/max(delta);
d_save=NaN*ones(1,N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Управление для V
for i=1:N
    if (Robots(i,1)>0)  
%-------------------- V
        Vreal=iso_save.Vreal_old(i);
        V=V_*delta(i);
%        V=V_-15*(1+sin(Modul.T/100));%*delta(i);
        %V=V_-3*(rem(Modul.T,10));%*delta(i);
        %iso_save.Vreal_old(i)=V*Modul.dT;
        iso_save.Vreal_old(i)=norm(Robots(i,2:3)-iso_save.Robots_old(i,2:3),2);
        %[Vo,V_*Modul.dT];
        iso_save.Robots_old(i,:)=Robots(i,:);
%-------------------- d_dot
%x=Robots(i,2);
%y=Robots(i,3);
% d=0.4*sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2)+...
%       0*abs(( (x-iso_par.C(1))*sin(iso_par.ANG)+(y-iso_par.C(2))*cos(iso_par.ANG))./...
%       ((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2).^(1/2));       

%d=iso_par.D(Robots(i,2),Robots(i,3));
d=iso_D(Robots(i,2),Robots(i,3));
d_save(i)=d;
        
        d_clear=d;
        d=d+iso_par.d0*(0.01*randn(1,1)*iso_par.error);%погрешность датчика
        dold=iso_save.dold(i);
        d_dot=(d-dold);
        iso_save.dold(i)=d;
%-------------------- Xi
        if (i<=iso_par.Nagent-iso_par.Nagent2)
            tempd0=iso_par.d0;
            tempd0d=iso_par.d0d;
        else
            tempd0=iso_par.d02;
            tempd0d=iso_par.d0d2;
        end
        if abs(d-tempd0)<tempd0d
            xi=((d-tempd0)/tempd0d)*iso_par.Sgrad;
%        if abs(d-iso_par.d0)<iso_par.d0d
%            xi=(d-iso_par.d0)*iso_par.Sgrad/iso_par.d0d;
        else
            xi=sign(d-tempd0)*iso_par.Sgrad; % y*d0d
%            xi=sign(d-iso_par.d0)*iso_par.Sgrad; % y*d0d
        end        
%-------------------- U
%         if iso_par.smooth
%             U=U_*10*(d_dot+Vreal*xi);%/(iso_par.Sgrad*V_*Modul.dT);
%             if (abs(U)>U_)
%                 U=sign(U)*U_;
%             end
%         else
%             U=U_*sign(d_dot+Vreal*xi);
%         end%-------------------- U
%         
        if iso_par.smooth
            U=U_*10*(d_dot+Vreal*xi);%/(iso_par.Sgrad*V_*Modul.dT);
            %cU=(d_dot+Vreal*xi)/(iso_par.Sgrad*max(Vreal,0.001));
            %U=U_*uslide*cU+dslide*U_*(cU-iso_save.Uold(i))/Modul.dT;
            %iso_save.SU(i)=0.9*iso_save.SU(i)+cU;
            %U=U+U_*islide*iso_save.SU(i);
%            U=U
%            U=U+
            if (abs(U)>U_)
                U=sign(U)*U_;
            end
        else
            U=U_*sign(d_dot+Vreal*xi);
        end
        iso_save.Uold(i)=U;
%-------------------- rule
        iso_rules(i,:)=[V+U,V-U];
    end
end
%Robots_old=Robots;
%=====================Графика==============================================
if ~isempty(Modul)

    global Save_iso;
    if (Modul.N==1)
        Save_iso.vLen=NaN*ones(N,Modul.Tend/Modul.dT);
        Save_iso.ddot=NaN*ones(1,Modul.Tend/Modul.dT);
        Save_iso.xi=NaN*ones(1,Modul.Tend/Modul.dT);
        Save_iso.d=NaN*ones(1,Modul.Tend/Modul.dT);

        Save_iso.Map_ddot=figure(201);
        title('???????? d_{dot} ? Vreal*xi ??? ??????? ??????');
        %subplot(2,1,1)
        %legend('dt(d)/dt','Xi');
        %plot([0,Modul.Tend/Modul.dT],Vreal*[iso_par.Sgrad,iso_par.Sgrad]);
        hold on;
        grid on;
        %plot([0,Modul.Tend/Modul.dT],[0,0],'G');
        %plot([0,Modul.Tend/Modul.dT],-Vreal*[iso_par.Sgrad,iso_par.Sgrad]);
        Save_iso.P_ddot=plot(1,d_dot);
        Save_iso.P_xi=plot(1,Vreal*xi,'R');
        set(Save_iso.P_xi,'LineWidth',2);
        %subplot(2,1,2)    
        %plot([0,Modul.Tend/Modul.dT],[0,0],'G');
        Save_iso.Map_ddot=figure(201);
        hold all;
        grid on;
        
        Save_iso.d=NaN*ones(N,Modul.Tend/Modul.dT);
        for i=1:N
            Save_iso.P_d(i)=plot(1,sqrt(d_save(i)/100),'R','LineWidth',2);     
        end
        ylabel('d, metres');
        xlabel('t,seconds');
        Save_iso.Map_Len=figure(204);
        title('?????????? ?? ?????????? ?????? ?? ??????');
        hold all;
        for i=1:N
            Save_iso.Map_Len(i)=plot(1,vizLength(i),'LineWidth',1);     
        end
        
        Save_iso.P_d=plot(1,sqrt(d)/10,'R');     
        ylabel('metres');
        xlabel('seconds');
        figure(112)
        Save_iso.P_U=plot(1,U);
        Save_iso.U=NaN*ones(1,Modul.Tend/Modul.dT);
        Save_iso.U(1)=U/100;
    else
        Save_iso.U(Modul.N)=U/100;
        Save_iso.ddot(Modul.N)=d_dot;
        Save_iso.xi(Modul.N)=Vreal*xi;
        for i=1:N
            Save_iso.d(i,Modul.N)=d_save(i);%-iso_par.d0;
            if (iso_par.TrackViz)
                iso_par.TrackViz(i)=abs(d_save(i)-iso_par.d0)>10;
            end
            Save_iso.vLen(i,Modul.N)=vizLength(i);
        end        
    end
    if (ishandle(Save_iso.Map_ddot) && isequal('on',get(Save_iso.Map_ddot,'Visible')))        
        set(Save_iso.P_ddot,'xdata',1:Modul.Tend/Modul.dT,'ydata', Save_iso.ddot);
        set(Save_iso.P_xi  ,'xdata',1:Modul.Tend/Modul.dT,'ydata',-Save_iso.xi  );
        for i=1:N
%            set(Save_iso.P_d(i) ,'xdata',(1:Modul.Tend/Modul.dT)*Modul.dT,'ydata',(Save_iso.d(i,:)/100)  );
        end
        for i=1:N
            set(Save_iso.Map_Len(i) ,'xdata',(1:Modul.Tend/Modul.dT)*Modul.dT,'ydata',(Save_iso.vLen(i,:)/100)  );
        end
        Save_iso.d(Modul.N)=d_clear;%-iso_par.d0;
%    end
%    if (ishandle(Save_iso.Map_ddot) && isequal('on',get(Save_iso.Map_ddot,'Visible')))
        %set(Save_iso.P_ddot,'xdata',1:Modul.Tend/Modul.dT,'ydata', Save_iso.ddot);
        %set(Save_iso.P_xi  ,'xdata',1:Modul.Tend/Modul.dT,'ydata',-Save_iso.xi  );
    %    set(Save_iso.P_d   ,'xdata',1:Modul.Tend/Modul.dT,'ydata',sqrt(Save_iso.d)/10  );
    %    set(Save_iso.P_U   ,'xdata',1:Modul.Tend/Modul.dT,'ydata',Save_iso.U/100);

        drawnow
    end
end
end