function iso_rules=iso_rule(Robots)
%%-------------------------------------------------------------------------
global Modul; % ��������� ������
global iso_par; %��������� ���������
%N=size(Robots,1);
N=iso_par.Nagent;
iso_rules=zeros(N,2);
%% ��������� ���������
% R_vision =iso_par.R_vision;  %800; %������ ��������� ������.
% Fi_vision=iso_par.Fi_vision; %0.5*pi/2; % ���� ��������� ������
% Rd_vision=iso_par.Rd_vision; %R_vision/N*0.9; % ������ ���������
% e=iso_par.e; %(V_-V_min)/N/50; %���������� ���������� ��� ���� ���������
%% ��������� �������
V_   =iso_par.Vmax; %70; %����������� �������� ��������
V_min=iso_par.Vmin; %10; %����������� �������� ��������
U_   =iso_par.Umax; %30  %����������� �������� �������� %U_=20..80, U_+V_=100

uslide=0.25;%0.25%1.34;
dslide=0.07;
islide=0.015;%P/10
%% ���������� ����
global ISO_VISION;
global iso_save;
if isempty(iso_save)
    %iso_save.dold=zeros(N,1);%
    iso_save.dold=NaN*ones(N,1);
    iso_save.mod=zeros(N,1);
    iso_save.fi_old=NaN*ones(N,1);
%    iso_save.kenem=zeros(N,1);
%    iso_save.sPmin=zeros(N,1);
    iso_save.Vreal_old=zeros(N,1);
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
%% ���������� ��� V

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

TT=@(x)([x(2),-x(1)]);
a_x_=@(al,v_p)1;
a_y_=@(al,v_p)1;

for i=1:N
    if (Robots(i,1)>0)  
%-------------------- V
        %Vreal=iso_save.Vreal_old(i);
        V=V_*delta(i);

        iso_save.Vreal_old(i)=norm(Robots(i,2:3)-iso_save.Robots_old(i,2:3),2);
        iso_save.Robots_old(i,:)=Robots(i,:);
        k=iso_save.Vreal_old(i)/0.2;
        %global Vreal_filt
        %if isempty(Vreal_filt)
        %    Vreal_filt=Vreal;
        %end
        %Vreal_filt=(Vreal_filt+Vreal)/2;
%-------------------- d_dot

        d=norm(C-Robots(i,2:3));%iso_D(Robots(i,2),Robots(i,3));
        d_save(i)=d;
%        d=d+iso_par.d0*(0.01*randn(1,1)*iso_par.error);%����������� �������
        dold=iso_save.dold(i);
        if isnan(dold)
            dold=d;
        end
        d_dot(i)=(d-dold)/(Modul.dT);
        iso_save.dold(i)=d;        
%--------------------
        e(i,:)=(C-Robots(i,2:3));
        e(i,:)=e(i,:)/norm(e(i,:));
        fi(i)=atan2(e(i,2),e(i,1));
        if isnan(iso_save.fi_old(i))
            iso_save.fi_old(i)=fi(i);
        end
        fi_dot(i)=azi(fi(i)-iso_save.fi_old(i))/(Modul.dT);
        iso_save.fi_old(i)=fi(i);
%% rule mod_C(0)
    al=NaN;v_p=NaN;
       u(i,:)=exp6_data.V(i,:)/norm(exp6_data.V(i,:));
       iso_save.mod(i)
        dfun(i)=d_dot(i)+iso_par.nu*iso_par.xi(d(i)-iso_par.d0);
        fifun(i)=fi_dot(i)-iso_par.o*iso_par.c_w/d(i);
        E(i)=fi_dot(i)-o*Q(p(i));
        if (iso_save.mod(i)==0)
            if abs(dfun(i))<0.01
                iso_save.mod(i)=1;
            end
            a(i,:)=iso_par.a_*TT(u(i,:));
        end
        if (iso_save.mod(i)==1)
            a_x(i)=a_x_(al,v_p)*sign(dfun(i));
            a_y(i)=-a_y_(al,v_p)*sign(fifun(i));
            a(i,:)=a_x(i)*e(i,:)+a_y(i)*TT(e(i,:));
        end
        if (iso_save.mod(i)==2)
            a_x(i)=a_x_(al,v_p)*sign(dfun(i));
            a_y(i)=-a_y_(al,v_p)*sign(E(i)-c(i));
            a(i,:)=a_x(i)*e(i,:)+a_y(i)*TT(e(i,:));
        end
%         p=exp3_re_P([Robots(i,2),Robots(i,3),0]);
%         if isnan(pold(i))
%             pold(i)=p;
%         end
%         p_dot=(p-pold(i));
%         pold(i)=p;
%         % 0==c
%         % B==1
%         % A==2  
% 
%         if (P_mod(i)==0) && (p<iso_par.d0) && (p_dot<0)
%             P_mod(i)=1;
%             P_d_star(i)=d;
%             P_p_star(i)=p;
%         else
%             if ((P_mod(i)==1)||(P_mod(i)==A2)) && (d>P_d_star(i)+1) && (abs(d_dot)<0.01)% && (d_dot>0)
%                 P_d_star(i)=d;
%                 P_mod(i)=2;
%                 Cmod=0;
%             else
%                 if (P_mod(i)==2) && (Cmod) %%&& (p<=P_p_star(i))%-0.1)%&& 
%                     if ~isnan(P_p_star(i))
%                         P_mod(i)=A2;
%                     else
%                         P_mod(i)=1;
%                     end
%                 end
%                 if (P_mod(i)==2) && (d>=P_d_star(i)+dD) && (d_dot>=-0.01)
%                     P_mod(i)=0;
%                     P_d_star(i)=NaN;
%                     P_p_star(i)=NaN;
%                 end
%             end
%         end
% 
% %        if P_mod(i)==2
% %            P_d_star(i)=d;
% %        end
%        if d<P_d_star(i)-dD
%            Cmod=1;
%        end
%        if  P_mod(i)==1
%            P_p_star(i)=p;
%            if (p_dot>-0.05)
%                P_mod(i)=A2;
%            end                   
%        end
% 
%                
%         if (P_mod(i)==0)
%             xi=0.9;
%             Uarg=d_dot-Vreal*xi;    
%         end
%         if ((P_mod(i)==1)||(P_mod(i)==A2))
%             xi_=(p-P_p_star(i))/iso_par.d0d;
%             %%xi_=(p-iso_par.d0)/iso_par.d0d;
%             xi=sign(xi_)*min(1,abs(xi_))*iso_par.Sgrad;            
%             Uarg=p_dot+Vreal*xi;        
%         end
%         if (P_mod(i)==2)
%             Uarg=-inf;
%         end
        

%         if iso_par.smooth
%             U=U_*9*(Uarg);%9
%             if (abs(U)>U_)
%                 U=sign(U)*U_;
%             end
%         else
%             U=U_*sign(Uarg);
%         end
%         iso_save.Uold(i)=U;
%         U=U+randn(1,1)*iso_par.error_U*500;
% %-------------------- rule
%         iso_rules(i,:)=[V+U,V-U];
    end
end
    exp6_data.a=a;
%% ---plots
global Save_iso;
plotln=30;
figure(100)
if (Modul.N==3)
    for i=1:N
        Save_iso.a(i)=plot(0,0,'B');
    end
end
if (Modul.N>3)
    for i=1:N
        setPlotData(Save_iso.a(i),Robots(i,2)+[0,plotln*a(i,1)],Robots(i,3)+[0,plotln*a(i,2)]);
    end
end

if (Modul.N==3)
    figure(201)
    for i=1:N
        subplot(3,2,1)
        Save_iso.d(i)=plot(0,d(i),'B');
        title('d');

        subplot(3,2,3)
        Save_iso.d_dot(i)=plot(0,d_dot(i),'B');
        title('d_{dot}');

        subplot(3,2,5)
        Save_iso.dfun(i)=plot(0,dfun(i),'B');
        title('d_{fun}');

        subplot(3,2,2)
        Save_iso.fi(i)=plot(0,fi(i),'B');
        title('fi');

        subplot(3,2,4)
        Save_iso.fi_dot(i)=plot(0,fi_dot(i),'B');
        title('fi_{dot}');
        
        subplot(3,2,6)
        Save_iso.ffun(i)=plot(0,fifun(i),'B');
        title('fi_{fun}');
    end

    
end
if (Modul.N>3 && Modul.PlotPulse)
    for i=1:N
        addPlotData(Save_iso.dfun(i),Modul.T,dfun(i));
        addPlotData(Save_iso.fi_dot(i),Modul.T,fi_dot(i));
        addPlotData(Save_iso.d(i),Modul.T,d(i));
        addPlotData(Save_iso.fi(i),Modul.T,fi(i));
        addPlotData(Save_iso.d_dot(i),Modul.T,d_dot(i));
        addPlotData(Save_iso.ffun(i),Modul.T,fifun(i));
    end
end

%% 1
% exp3_data.rule_data.P_mod=P_mod;
% exp3_data.rule_data.P_d_star=P_d_star;
% exp3_data.rule_data.P_p_star=P_p_star;
% exp3_data.rule_data.pold=pold;
% exp3_data.rule_data.Cmod=Cmod;
%exp3_data.rule_data.Pdes=Pdes;

%% �������
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