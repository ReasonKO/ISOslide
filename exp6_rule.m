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
iso_save.UrealFilt=zeros(N,1);
    iso_save.dold=NaN*ones(N,1);
    iso_save.mod=zeros(N,1);
    iso_save.fi_old=NaN*ones(N,1);
%    iso_save.kenem=zeros(N,1);
%    iso_save.sPmin=zeros(N,1);
    iso_save.Vreal_old=zeros(N,1);
    iso_save.Vreal=zeros(N,1);
    iso_save.Ureal=zeros(N,1);
    iso_save.Robots_old=Robots;
    iso_save.Uold=zeros(N,1);
%    iso_save.SU=zeros(N,1);
end
d_save=NaN*ones(1,N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global exp6_data
% if ~isfield(exp6_data,'rule_data');
%exp6_data.rule_data.mod=zeros(N,1);
%exp3_data.rule_data.P_d_star=NaN*ones(N,1);
%exp3_data.rule_data.P_p_star=NaN*ones(N,1);
%exp3_data.rule_data.pold=NaN*ones(N,1);
%exp3_data.rule_data.Cmod=zeros(N,1);
%exp3_data.rule_data.Pdes=NaN*ones(N,1);
% end
%P_mod=exp3_data.rule_data.P_mod;
% P_d_star=exp3_data.rule_data.P_d_star;
% P_p_star=exp3_data.rule_data.P_p_star;
% pold=exp3_data.rule_data.pold;
% Cmod=exp3_data.rule_data.Cmod;
%Pdes=exp3_data.rule_data.Pdes;
%% Управление для V

e=zeros(N,2);
a=zeros(N,2);
u=zeros(N,2);
dfun=zeros(N,1);
fifun=zeros(N,1);
a_x=zeros(N,1);
a_y=zeros(N,1);
delta=ones(N,1);
C=exp6_data.C;
d_dot=zeros(N,1);
fi=zeros(N,1);
fi_dot=zeros(N,1);
pij=zeros(N,N);
p=zeros(N,1);
E=zeros(N,1);
d=zeros(N,1);
d_old=zeros(N,1);
fi_dot_c=zeros(N,1);

TT=@(x)([x(2),-x(1)]);
a_x_=@(al,v_p)1;
a_y_=@(al,v_p)0.2;


for i=1:N 
    for j=1:N
        pij(i,j)=azi(iso_save.fi_old(j)-iso_save.fi_old(i));
        pij(i,j)=pij(i,j)+pi*2*(pij(i,j)<0);
        if iso_save.mod(j)~=2
            pij(i,j)=inf;
        end
    end
    pij(i,i)=inf;
end
%pij
p=min(pij')';
p(p==inf)=iso_par.delta_fi;
p(iso_save.mod~=2)=NaN;
TT=@(x)([x(2),-x(1)]);

global H
if isempty(H)
    H=[];
end
H=[H,Robots(1,4)];

for i=1:N
    if (Robots(i,1)>0)  
%-------------------- V
        %Vreal=iso_save.Vreal_old(i);
        V=V_*delta(i);

        iso_save.Vreal(i)=norm(Robots(i,2:3)-iso_save.Robots_old(i,2:3),2)/Modul.dT;
        iso_save.Ureal(i)=azi(Robots(i,4)-iso_save.Robots_old(i,4))/Modul.dT;
        iso_save.UrealFilt(i)=iso_save.UrealFilt(i)*0.9+iso_save.Ureal(i)*0.1;
        %global Vreal_filt
        %if isempty(Vreal_filt)
        %    Vreal_filt=Vreal;
        %end
        %Vreal_filt=(Vreal_filt+Vreal)/2;
%-------------------- d_dot

        d(i)=norm(C-Robots(i,2:3));%iso_D(Robots(i,2),Robots(i,3));
        d_save(i)=d(i);
%        d=d+iso_par.d0*(0.01*randn(1,1)*iso_par.error);%погрешность датчика
        d_dot(i)=(d(i)-iso_save.dold(i))/(Modul.dT);
        
%--------------------
        e(i,:)=(C-Robots(i,2:3));
        e(i,:)=e(i,:)/norm(e(i,:));
        fi(i)=atan2(e(i,2),e(i,1));
        if isnan(iso_save.fi_old(i))
            iso_save.fi_old(i)=fi(i);
        end
        fi_dot(i)=azi(fi(i)-iso_save.fi_old(i))/(Modul.dT);
        
%% rule mod_C(0)
    al=NaN;v_p=NaN;

    
    
       u(i,:)=exp6_data.V(i,:)/norm(exp6_data.V(i,:));
     %  iso_save.mod(i)

        dfun(i)=d_dot(i)+iso_par.nu*iso_par.xi(d(i)-iso_par.d0);
        
        c(i)=iso_par.kppa*d(i)*0;
        if (iso_save.mod(i)==0)
            if abs(dfun(i))<0.1
                iso_save.mod(i)=1;
            end
            a(i,:)=iso_par.a_*TT(u(i,:));
            fifun(i)=0;
            fi_dot_c(i)=0;
        elseif (iso_save.mod(i)==1)
            fi_dot_c(i)=iso_par.o*iso_par.c_w/d(i);
            fifun(i)=fi_dot(i)-fi_dot_c(i);        
            a_x(i)=a_x_(al,v_p)*sign(dfun(i));
            a_y(i)=-a_y_(al,v_p)*sign(fifun(i));
            a(i,:)=a_x(i)*e(i,:)+a_y(i)*TT(e(i,:));
            if abs(d(i))<iso_par.d1
                iso_save.mod(i)=2;
            end
        elseif (iso_save.mod(i)==2)           
            fi_dot_c(i)=iso_par.o*iso_par.Q(p(i));
            fifun(i)=fi_dot(i)-fi_dot_c(i);        
            a_x(i)=a_x_(al,v_p)*sign(dfun(i));
            a_y(i)=-a_y_(al,v_p)*sign(fifun(i))-c(i);
            a(i,:)=a_x(i)*e(i,:)+a_y(i)*TT(e(i,:));
        end

    end
end
exp6_data.a=a;
iso_save.Robots_old=Robots;
iso_save.fi_old=fi;
iso_save.dold=d;   
     
%% ---plots
global Save_iso;
plotln=30;

if (Modul.N==3)
    for i=1:N
        figure(200+i)
        subplot(4,2,1)
        hold on
        Save_iso.d(i)=plot(0,d(i),'B');
        title('d');
        Save_iso.d0(i)=plot(0,iso_par.d0,'R');
        

        subplot(4,2,2)
        hold on
        Save_iso.d_dot(i)=plot(0,d_dot(i),'B');
        title('d_{dot}');
        Save_iso.d_dot_c(i)=plot(0,0,'R');

    %    subplot(4,3,3)
    %    Save_iso.dfun(i)=plot(0,dfun(i),'B');
    %    title('d_{fun}');

        subplot(4,2,3)
        Save_iso.fi(i)=plot(0,fi(i),'B');
        title('fi');

        subplot(4,2,4)
        hold on
        Save_iso.fi_dot(i)=plot(0,fi_dot(i),'B');
        title('fi_{dot}');
        Save_iso.fi_dot_c(i)=plot(0,fi_dot_c(i),'R');
        
%         subplot(4,3,6)
%         Save_iso.ffun(i)=plot(0,fifun(i),'B');
%         title('fi_{fun}');

        subplot(4,2,5)
        Save_iso.mod(i)=plot(0,iso_save.mod(i),'B');
        axis([0,inf,0,3]);
        set(gca,'YTick',[0,1,2]);
        set(gca,'YTickLabel',{'C','A','M'});           
        title('mod');
        

        subplot(4,2,6)
        hold on
        Save_iso.p(i)=plot(0,p(i),'B');
        title('p');
        Save_iso.p0(i)=plot(0,pi*2/iso_par.Nagent,'R');

        subplot(4,2,7)
        hold on
        Save_iso.Vreal(i)=plot(0,iso_save.Vreal(i),'B');
        %axis([0,inf,0,0.1]);
        title('V');

        subplot(4,2,8)
        hold on
        Save_iso.Ureal(i)=plot(0,iso_save.Ureal(i),'G');
        Save_iso.UrealFilt(i)=plot(0,iso_save.UrealFilt(i),'B');
        Save_iso.Ureal_C(i)=plot(0,iso_par.w0,'R');
        %legend('U_{real}','U_{filt}');
        axis([0,inf,-iso_par.Umax*1.1,iso_par.Umax*1.1]);
        title('U');


    end

    
end
if (Modul.N>3)
    for i=1:N
        addPlotData(Save_iso.Ureal(i),Modul.T,iso_save.Ureal(i));
    if Modul.PlotPulse
        addPlotData(Save_iso.Vreal(i),Modul.T,iso_save.Vreal(i));
        setPlotData(Save_iso.Ureal_C(i),[0,Modul.T],iso_par.w0*[1,1]);        
        addPlotData(Save_iso.UrealFilt(i),Modul.T,iso_save.UrealFilt(i));        
        addPlotData(Save_iso.d_dot_c(i),Modul.T,-iso_par.nu*iso_par.xi(d(i)-iso_par.d0));
       
        setPlotData(Save_iso.d0(i),[0,Modul.T],[iso_par.d0,iso_par.d0]);
        setPlotData(Save_iso.p0(i),[0,Modul.T],pi*2/iso_par.Nagent*[1,1]);
      %  addPlotData(Save_iso.dfun(i),Modul.T,dfun(i));
        addPlotData(Save_iso.fi_dot(i),Modul.T,fi_dot(i));
        addPlotData(Save_iso.d(i),Modul.T,d(i));
        addPlotData(Save_iso.fi(i),Modul.T,fi(i));
        addPlotData(Save_iso.d_dot(i),Modul.T,d_dot(i));
        addPlotData(Save_iso.fi_dot_c(i),Modul.T,fi_dot_c(i));
      %  addPlotData(Save_iso.ffun(i),Modul.T,fifun(i));
        addPlotData(Save_iso.mod(i),Modul.T,iso_save.mod(i));
        addPlotData(Save_iso.p(i),Modul.T,p(i));        
    end
    end
end
if (Modul.N==3)
    figure(100)
%     for i=1:N
%         Save_iso.a(i)=plot(0,0,'B');
%     end
end
% if (Modul.N>3)
%     for i=1:N
%         setPlotData(Save_iso.a(i),Robots(i,2)+[0,plotln*a(i,1)],Robots(i,3)+[0,plotln*a(i,2)]);
%     end
% end

%% 1
% exp3_data.rule_data.P_mod=P_mod;
% exp3_data.rule_data.P_d_star=P_d_star;
% exp3_data.rule_data.P_p_star=P_p_star;
% exp3_data.rule_data.pold=pold;
% exp3_data.rule_data.Cmod=Cmod;
%exp3_data.rule_data.Pdes=Pdes;

%% Графика
% if iso_par.DataGraph
% global Save_iso;
% if (Modul.N==3)
%     
%     figure(201)
%     Save_iso.plot_p=plot(0,p,'K','LineWidth',1);
%     hold on
%     %Save_iso.plot_d2=plot(NaN,NaN,'B','LineWidth',1);
%     Save_iso.plot_d0=plot(0,P_p_star(i),'R','LineWidth',2);
%     Save_iso.plot_p02=plot(0,iso_par.d0,'R--','LineWidth',2);
%     legend('p','p_{des}','p_{sw}','Location','NorthWest');
%     title('p & p0');
%     
%     figure(202)
%     Save_iso.plot_dd=plot(0,d_dot,'K','LineWidth',1);
%     hold on
%     Save_iso.plot_sgrad=plot(0,Vreal*0.9,'R','LineWidth',2);
%     legend('d''','V_d','Location','NorthWest');
%     title('d'' & V_d');
%     
%     figure(203)
%     Save_iso.plot_u=plot(0,U/500,'K','LineWidth',1);
%     title('u');
%     
%     figure(204)
%     ylim([-1,3]);
%     hold on
%     Save_iso.plot_mod=plot(0,P_mod(1),'K','LineWidth',2);
%     set(gca,'YTick',[0,1,2]);
%     set(gca,'YTickLabel',{'C','A','B'});   
%     legend('mod','Location','NorthWest');
%     title('mod');
%   
%     figure(205)
%     Save_iso.plot_d_zero=plot(0,exp3_data.Cv,'G-','LineWidth',3);
%     hold on    
%     ylim([d-10,1001]);
%     Save_iso.plot_d_star=plot(0,d,'R','LineWidth',2);
%     Save_iso.plot_d=plot(0,d,'K','LineWidth',1);
%     legend('max','d_*','d','Location','NorthWest');
%     title('max, d_* & d');
%     figure(206)
%     Save_iso.plot_p_dot=plot(0,p_dot,'B','LineWidth',2);
%     legend('p''','Location','NorthWest');
%     figure(100);    
% end
% if (Modul.N>=3)
% addPlotData(Save_iso.plot_p,p);
% addPlotData(Save_iso.plot_d0,P_p_star(i));
% addPlotData(Save_iso.plot_p02,iso_par.d0);
% 
% addPlotData(Save_iso.plot_dd,d_dot/Vreal);
% addPlotData(Save_iso.plot_sgrad,0.9);
% 
% addPlotData(Save_iso.plot_d_star,P_d_star(1));
% addPlotData(Save_iso.plot_d,d);
% addPlotData(Save_iso.plot_d_zero,exp3_data.Cv);
% 
% addPlotData(Save_iso.plot_u,U/500);
% 
% addPlotData(Save_iso.plot_mod,P_mod(1));
% 
% addPlotData(Save_iso.plot_p_dot,p_dot);
% end
%Robots_old=Robots;
% end
end