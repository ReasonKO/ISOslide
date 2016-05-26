function iso_rules=iso_rule(Robots)
%%-------------------------------------------------------------------------
global Modul; % Параметры модели
global iso_par; %Параметры алгаритма
%N=size(Robots,1);
N=iso_par.Nagent;
iso_rules=zeros(N,2);
%% Параметры алгоритма
% R_vision =iso_par.R_vision;  %800; %Радиус видимости робота.
% Fi_vision=iso_par.Fi_vision; %0.5*pi/2; % Угол видимости робота
% Rd_vision=iso_par.Rd_vision; %R_vision/N*0.9; % Радиус ближайших
% e=iso_par.e; %(V_-V_min)/N/50; %коэфициент замедления для ряда ближайших
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
    %iso_save.dold=zeros(N,1);%
    iso_save.dold=NaN*ones(N,1);
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
% P=inf*ones(N,N); %Матрица расстояний
% Pmin=zeros(N,1); %Вектор наименьших расстояний
% index=zeros(N,1);
% vizLength=zeros(N,1);
% viz_ang_Rd=(-pi/2-Fi_vision):0.1:(+pi/2-Fi_vision); %---Для вывода


% CloudyMatrix=zeros(N,N);
% 
% for i=1:N
%     for j=(i+1):N
%         Lzt=50;
%         Zt=repmat(Robots(i,2:3),[Lzt,1])+(1:Lzt)'/Lzt*(Robots(j,2:3)-Robots(i,2:3));
%         Dt=iso_D(Zt(:,1),Zt(:,2));
%         CloudyMatrix(i,j)=~isempty(find((Dt<50),1));
%         CloudyMatrix(j,i)=CloudyMatrix(i,j);        
%     end
% end
% 
% for i=1:N
% if (Robots(i,1)>0)  
%     iso_save.kenem(i)=0;
%     for j=1:N
% %%------------------- P
%     if (i~=j && Robots(j,1)>0)  
%         if ((norm(Robots(i,2:3)-Robots(j,2:3))<=R_vision) ...
%             && (abs(azi(angV(Robots(j,2:3)-Robots(i,2:3))-Robots(i,4)))<Fi_vision))
%             %Расстояние до левой границы видимости
%             dr1=abs(sin(angV(Robots(j,2:3)-Robots(i,2:3))-(Robots(i,4)-Fi_vision)))*norm(Robots(i,2:3)-Robots(j,2:3));
%             %Расстояние до правой границы видимости
%             dr2=abs(sin(angV(Robots(j,2:3)-Robots(i,2:3))-(Robots(i,4)+Fi_vision)))*norm(Robots(i,2:3)-Robots(j,2:3));
%             %dr1=abs(cos((Robots(i,4)-Fi_vision))*(Robots(j,3)-Robots(i,3))+sin((Robots(i,4)-Fi_vision))*(Robots(j,2)-Robots(i,2)));
%             %dr2=abs(cos((Robots(i,4)+Fi_vision))*(Robots(j,3)-Robots(i,3))+sin((Robots(i,4)+Fi_vision))*(Robots(j,2)-Robots(i,2)));            
%             %Минимальное расстояние до границы видимости
%             P(i,j)=min(dr1,dr2);
% %%------------------- Ke
%             %Ищем ближайших и считаем длину строя.
%             if (norm(Robots(i,2:3)-Robots(j,2:3))<=Rd_vision)
%                 iso_save.kenem(i)=min(iso_save.kenem(i),iso_save.kenem(j)+1);
%             end
%             iso_save.kenem(i)=min(iso_save.kenem(i),N);
%             %[i,j,dr1,dr2,P(i,j)] 
%         end
% %%------------------- P(i,j)=0
%         %Ищем ближайщих сбоку.
%         if ((norm(Robots(i,2:3)-Robots(j,2:3))<=Rd_vision)...
%             && (abs(azi(angV(Robots(j,2:3)-Robots(i,2:3))-pi/2-Robots(i,4)))<pi/2-Fi_vision))
%             P(i,j)=0;
%         end
%     end
%     end
% %%------------------- re
% %     if (iso_par.VidVisible)
% %         P(CloudyMatrix==1)=inf;
% %     end
% %     %Берём наименьшее расстояние по всем роботам и нормируем
% %     Pmax=R_vision*sin(Fi_vision);
% %     Pmin(i)=min(1,min(P(i,:))/Pmax);
% %     [Z,index(i)]=min(P(i,:));
% %     %[i,index(i),P(i,index(i)),Z]
% %     if (P(i,index(i))==inf)
% %         index(i)=0;
% %     end
% %     if (index(i)~=0)
% %         vizLength(i)=norm(Robots(i,2:3)-Robots(index(i),2:3),2);
% %     else
% %         vizLength(i)=NaN;
% %     end
% %     
%     %Превращаем P в delta(нормированная по V_).
%     %V():[0..1] -> ([V_min+N*e..V_]-Ke*e) -> [0,1] (линейная)
%     %delta(i)=Pmin(i);
% %     delta(i)=( (1-Pmin(i))*(V_min+N*e) + Pmin(i)*V_ - iso_save.kenem(i)*e )/V_;
% %=========================графика==========================================
% % if ~isempty(Modul)
% %     if (iso_par.SectorVisual)
% %         drawx=Robots(i,2)+R_vision*[0,cos(Robots(i,4)-Fi_vision),cos((Robots(i,4)-Fi_vision):0.2:(Robots(i,4)+Fi_vision)),cos(Robots(i,4)+Fi_vision),0];
% %         drawy=Robots(i,3)+R_vision*[0,sin(Robots(i,4)-Fi_vision),sin((Robots(i,4)-Fi_vision):0.2:(Robots(i,4)+Fi_vision)),sin(Robots(i,4)+Fi_vision),0];
% %         %drawx=[drawx,Robots(i,2)+[0,Rd_vision*cos(Robots(i,4)+pi/2+viz_ang_Rd),0]];
% %         %drawy=[drawy,Robots(i,3)+[0,Rd_vision*sin(Robots(i,4)+pi/2+viz_ang_Rd),0]];
% %             %plot(Robots(i,2)+Rd_vision*cos(0:0.1:2*pi),Robots(i,3)+Rd_vision*sin(0:0.1:2*pi),'R');
% %         if (Modul.N>1)
% %             if (~isfield(ISO_VISION,'viz') || size(ISO_VISION.viz,2)<i)
% %                 ISO_VISION.viz(i)=plot(drawx/100,drawy/100,'K');
% %             else
% %                 set(ISO_VISION.viz(i),'xdata',drawx/100,'ydata',drawy/100);
% %             end    
% %         end    
% %     end
% % end
% %     if ~isempty(Modul)
% %         drawx=Robots(i,2)+R_vision*[0,cos(Robots(i,4)-Fi_vision),cos((Robots(i,4)-Fi_vision):0.2:(Robots(i,4)+Fi_vision)),cos(Robots(i,4)+Fi_vision),0];
% %         drawy=Robots(i,3)+R_vision*[0,sin(Robots(i,4)-Fi_vision),sin((Robots(i,4)-Fi_vision):0.2:(Robots(i,4)+Fi_vision)),sin(Robots(i,4)+Fi_vision),0];
% %         drawx=[drawx,Robots(i,2)+[0,Rd_vision*cos(Robots(i,4)+pi/2+viz_ang_Rd),0]];
% %         drawy=[drawy,Robots(i,3)+[0,Rd_vision*sin(Robots(i,4)+pi/2+viz_ang_Rd),0]];
% %             %plot(Robots(i,2)+Rd_vision*cos(0:0.1:2*pi),Robots(i,3)+Rd_vision*sin(0:0.1:2*pi),'R');
% %         if (Modul.N>1)
% %             if (Modul.N==2)
% %                 ISO_VISION.viz(i)=plot(drawx,drawy);
% %             else
% %                 set(ISO_VISION.viz(i),'xdata',drawx,'ydata',drawy);
% %             end    
% %         end
% %     end
% %--------------------------------------------------------------------------
% end
% end

%=========графики для каждого робота=======================================
% if ~isempty(Modul)
%     if (iso_par.VidVisible)
%         iso_save.sPmin=[iso_save.sPmin,Pmin];
%         if (Modul.N==1)
%             figure(1001);
%             title('???????? Pmin ??? ??????? ??????');
%             for i=1:N
%                 subplot(floor((N-1)/4)+1,4,i)
%                 ISO_VISION.vizPmin(i)=plot(0:Modul.N,iso_save.sPmin(i,:));
%             end
%         else
%             for i=1:N
%                 set(ISO_VISION.vizPmin(i),'xdata',0:Modul.N,'ydata',iso_save.sPmin(i,:));
%             end
%         end
%     end
%     iso_save.sPmin=[iso_save.sPmin,Pmin];
%     if (Modul.N==1)
%         figure(1001);
%         for i=1:N
%             subplot(floor((N-1)/4)+1,4,i)
% %            ISO_VISION.vizPmin(i)=plot(0:Modul.N,iso_save.sPmin(i,:));
%         end
%     else
%         for i=1:N
%             set(ISO_VISION.vizPmin(i),'xdata',0:Modul.N,'ydata',iso_save.sPmin(i,:));
%         end
%     end
% end
% %======Вывод в comand window (убрать ';')==================================
% iso_save.kenem';
% P;
% Pmin';
% delta=delta/max(delta);
d_save=NaN*ones(1,N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global exp3_data
if ~isfield(exp3_data,'rule_data');
exp3_data.rule_data.P_mod=zeros(N,1);
exp3_data.rule_data.P_d_star=NaN*ones(N,1);
exp3_data.rule_data.P_p_star=NaN*ones(N,1);
exp3_data.rule_data.pold=NaN*ones(N,1);
exp3_data.rule_data.Cmod=zeros(N,1);
%exp3_data.rule_data.Pdes=NaN*ones(N,1);
end
P_mod=exp3_data.rule_data.P_mod;
P_d_star=exp3_data.rule_data.P_d_star;
P_p_star=exp3_data.rule_data.P_p_star;
pold=exp3_data.rule_data.pold;
Cmod=exp3_data.rule_data.Cmod;
%Pdes=exp3_data.rule_data.Pdes;
%% Управление для V
A2=1.01;
dD=3;%0.5;

for i=1:N
    if (Robots(i,1)>0)  
%-------------------- V
        Vreal=iso_save.Vreal_old(i);
        V=V_*delta(i);

        iso_save.Vreal_old(i)=norm(Robots(i,2:3)-iso_save.Robots_old(i,2:3),2);
        iso_save.Robots_old(i,:)=Robots(i,:);
        global Vreal_filt
        if isempty(Vreal_filt)
            Vreal_filt=Vreal;
        end
        Vreal_filt=(Vreal_filt+Vreal)/2;
%-------------------- d_dot

        d=iso_D(Robots(i,2),Robots(i,3));
        d_save(i)=d;
        d_clear=d;
        d=d+iso_par.d0*(0.01*randn(1,1)*iso_par.error);%погрешность датчика
        dold=iso_save.dold(i);
        if isnan(dold)
            dold=d;
        end
        d_dot=(d-dold);
        iso_save.dold(i)=d;        
        p=exp3_re_P([Robots(i,2),Robots(i,3),0]);
        if isnan(pold(i))
            pold(i)=p;
        end
        p_dot=(p-pold(i));
        pold(i)=p;
        % 0==c
        % B==1
        % A==2  

        if (P_mod(i)==0) && (p<iso_par.d0) && (p_dot<0)
            P_mod(i)=1;
            P_d_star(i)=d;
            P_p_star(i)=p;
        else
            if ((P_mod(i)==1)||(P_mod(i)==A2)) && (d>P_d_star(i)+1) && (abs(d_dot)<0.01)% && (d_dot>0)
                P_d_star(i)=d;
                P_mod(i)=2;
                Cmod=0;
            else
                if (P_mod(i)==2) && (Cmod) %%&& (p<=P_p_star(i))%-0.1)%&& 
                    if ~isnan(P_p_star(i))
                        P_mod(i)=A2;
                    else
                        P_mod(i)=1;
                    end
                end
                if (P_mod(i)==2) && (d>=P_d_star(i)+dD) && (d_dot>=-0.01)
                    P_mod(i)=0;
                    P_d_star(i)=NaN;
                    P_p_star(i)=NaN;
                end
            end
        end

%        if P_mod(i)==2
%            P_d_star(i)=d;
%        end
       if d<P_d_star(i)-dD
           Cmod=1;
       end
       if  P_mod(i)==1
           P_p_star(i)=p;
           if (p_dot>-0.05)
               P_mod(i)=A2;
           end                   
       end

               
        if (P_mod(i)==0)
            xi=0.9;
            Uarg=d_dot-Vreal*xi;    
        end
        if ((P_mod(i)==1)||(P_mod(i)==A2))
            xi_=(p-P_p_star(i))/iso_par.d0d;
            %%xi_=(p-iso_par.d0)/iso_par.d0d;
            xi=sign(xi_)*min(1,abs(xi_))*iso_par.Sgrad;            
            Uarg=p_dot+Vreal*xi;        
        end
        if (P_mod(i)==2)
            Uarg=-inf;
        end
        

        if iso_par.smooth
            U=U_*9*(Uarg);%9
            if (abs(U)>U_)
                U=sign(U)*U_;
            end
        else
            U=U_*sign(Uarg);
        end
        iso_save.Uold(i)=U;
        U=U+randn(1,1)*iso_par.error_U*500;
%-------------------- rule
        iso_rules(i,:)=[V+U,V-U];
    end
end

%% 1
exp3_data.rule_data.P_mod=P_mod;
exp3_data.rule_data.P_d_star=P_d_star;
exp3_data.rule_data.P_p_star=P_p_star;
exp3_data.rule_data.pold=pold;
exp3_data.rule_data.Cmod=Cmod;
%exp3_data.rule_data.Pdes=Pdes;

%% Графика
global Save_iso;
if (Modul.N==3)
    
    figure(201)
    Save_iso.plot_p=plot(0,p,'K','LineWidth',1);
    hold on
    %Save_iso.plot_d2=plot(NaN,NaN,'B','LineWidth',1);
    Save_iso.plot_d0=plot(0,P_p_star(i),'R','LineWidth',2);
    Save_iso.plot_p02=plot(0,iso_par.d0,'R--','LineWidth',2);
    legend('p','p_{des}','p_{sw}','Location','NorthWest');
    title('p & p0');
    
    figure(202)
    Save_iso.plot_dd=plot(0,d_dot,'K','LineWidth',1);
    hold on
    Save_iso.plot_sgrad=plot(0,Vreal*0.9,'R','LineWidth',2);
    legend('d''','V_d','Location','NorthWest');
    title('d'' & V_d');
    
    figure(203)
    Save_iso.plot_u=plot(0,U/500,'K','LineWidth',1);
    title('u');
    
    figure(204)
    ylim([-1,3]);
    hold on
    Save_iso.plot_mod=plot(0,P_mod(1),'K','LineWidth',2);
    set(gca,'YTick',[0,1,2]);
    set(gca,'YTickLabel',{'C','A','B'});   
    legend('mod','Location','NorthWest');
    title('mod');
  
    figure(205)
    Save_iso.plot_d_zero=plot(0,exp3_data.Cv,'G-','LineWidth',3);
    hold on    
    ylim([d-10,1001]);
    Save_iso.plot_d_star=plot(0,d,'R','LineWidth',2);
    Save_iso.plot_d=plot(0,d,'K','LineWidth',1);
    legend('max','d_*','d','Location','NorthWest');
    title('max, d_* & d');
    figure(206)
    Save_iso.plot_p_dot=plot(0,p_dot,'B','LineWidth',2);
    legend('p''','Location','NorthWest');
    figure(100);    
end
if (Modul.N>=3)
addPlotData(Save_iso.plot_p,p);
addPlotData(Save_iso.plot_d0,P_p_star(i));
addPlotData(Save_iso.plot_p02,iso_par.d0);

addPlotData(Save_iso.plot_dd,d_dot/Vreal);
addPlotData(Save_iso.plot_sgrad,0.9);

addPlotData(Save_iso.plot_d_star,P_d_star(1));
addPlotData(Save_iso.plot_d,d);
addPlotData(Save_iso.plot_d_zero,exp3_data.Cv);

addPlotData(Save_iso.plot_u,U/500);

addPlotData(Save_iso.plot_mod,P_mod(1));

addPlotData(Save_iso.plot_p_dot,p_dot);
end
%Robots_old=Robots;

end