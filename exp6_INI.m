clear all
iso_ini_def
global exp6_data field


exp6_data.C=[-90,-5];

%%
global iso_par;
iso_par.d0d=10;   %Шарана коридора присоедования
iso_par.error=0.0;    %Ошибка датчика в %
iso_par.d0=30; %приследуемое значение
iso_par.d1=iso_par.d0+iso_par.d0d; %приследуемое значение

iso_par.Sgrad=0.7;%1  %Макс.градиент
iso_par.Tspeed=1;   %Ускорение изолинии по времени
iso_par.Nagent=5;%12  %Кол-во агентов
iso_par.smooth=0;   %*гладкий режим*


iso_par.xi=@(x)80*atan((x)/10);
iso_par.nu=0.01;
iso_par.o=1; %rotation direction
iso_par.Q0=1/20;
iso_par.w0=0.08;
iso_par.Q=@(x)iso_par.Q0+x/(2*pi/iso_par.Nagent)*(iso_par.w0-iso_par.Q0);
iso_par.c_w=iso_par.d1*iso_par.Q0;
iso_par.a_=1; %a_max

iso_par.delta_fi=2*pi/iso_par.Nagent;
iso_par.Rviz=20;
iso_par.kppa=0.2/100;
iso_par.beta=@(fi)sign(fi).*(max(0,1-abs(fi)/(pi/3)));

iso_par.Rul2Uconf=1;

iso_par.SCENARIO6=0; %0,1,2,3 %!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
iso_par.ExpName='exp6_';
iso_par.ExpName(6)=48+iso_par.SCENARIO6;

%iso_par.re_D=@(x,y)700+300*exp(-((exp3_data.C(1)-x).^2/200^2+(exp3_data.C(2)-y).^2/100^2));
%iso_par.re_D=@(x,y)700+300*exp(-((exp3_data.C(1)-x).^2/300^2+(exp3_data.C(2)-y).^2/300^2));
iso_par.re_D=@(x,y)0;%exp3_reD(x,y);
iso_par.Dynamic=@exp6_dyn;
iso_par.AddViz=[];
iso_par.Rule=@(Y)exp6_rule(Y);

iso_par.TT=@(x)([x(2),-x(1)]);

iso_par.Vmax=5; %Максимальная линейная скорость [Vmin..100]
%iso_par.Vmin=10; %Минимальная линейная скорость  [0..Vmax] 
iso_par.Umax=0.5; %Максимальная скорость поворота [0..(100-Vmax)]

iso_par.R_vision=10;       %Радиус видимости робота.
iso_par.Fi_vision=0.5*pi/2; %Угол видимости робота
iso_par.Rd_vision=0.9*iso_par.R_vision/iso_par.Nagent; % Радиус ближайших
iso_par.e=(iso_par.Vmax-iso_par.Vmin)/iso_par.Nagent/50;  %коэфициент замедления для ряда ближайших

iso_par.TracksVizual=1; %Демонстрация треков (0 - никогда, 1 - всегда, 2 - до выхода на изолинию)
iso_par.TracksTime=100; %Затирание трека спустя iso_par.TracksTime отрисовок
iso_par.TracksColor=[0.9,0.6,0.6];
iso_par.RobotFormat=1;
iso_par.trackDepth=-10;

iso_par.TripleIsoline=false;
global treckcolor;
treckcolor=[0.8,0.1,0.1];

global Pause; Pause=0;
%% ----------------------
iso_par.add.delta_a_=0.1;
iso_par.add.delta_v_=0.1;
iso_par.add.delta=(2*iso_par.Vmax)^-1*sqrt(2*iso_par.Vmax*iso_par.add.delta_v_-iso_par.add.delta_v_^2);

%% -----------------------
global PAR;
PAR.MAP_X=300;
PAR.MAP_Y=300;
PAR.KICK_DIST=150;
%% Global INI
global MODUL_ON; MODUL_ON=1;
global iso_MODUL_ON; iso_MODUL_ON=1; 

global Rules;    Rules=zeros(12,7);
global Balls;    Balls=zeros(1,3);
global Blues;    Blues=zeros(12,4);
global Yellows;  Yellows=zeros(12,4);

global Modul;

Modul.Tend=1000; %Время работы
if iso_par.SCENARIO6==0
    Modul.Tend=500; %Время работы
end
if iso_par.SCENARIO6==2
    Modul.Tend=2000; %Время работы
end
if iso_par.SCENARIO6==3
    Modul.Tend=1000; %Время работы
end

Modul.dT=0.1;     %Щаг дискретизации
Modul.freq=1;
Modul.save_freq=5; 
Modul.Delay=0;  %Задержка
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
Modul.SaveExp=1;  %ЗАПИСЬ ЛОГОВ
%% 
Yellows(1,:)=[1,30,-30,0];
Yellows(2,:)=[1,50,100,0];
Yellows(3,:)=[1,150,100,0];
Yellows(4,:)=[1,-400,150,0];
Yellows(5,:)=[1,200,-350,0];
exp6_data.V=ones(iso_par.Nagent,2);
exp6_data.a=zeros(iso_par.Nagent,2);
exp6_data.Cv=1000;
%% SECTION TITLE
% DESCRIPTIVE TEXT

%[ang,h]=meshgrid([-2.45*pi:pi/30:-pi/3,-pi/3:pi/100:pi/3,pi/3:pi/30:(2.45*pi)],-3:3);
%field.Xm{1}=max(23.2276,exp(1/ang)/1000).*sin(ang+pi/4)+h;
%field.Ym{1}=max(23.2276,exp(1/ang)/1000).*cos(ang+pi/4)+h;
field.Xm{1}=2000+[0,1;1,0];
field.Ym{1}=2000+[1,0;1,0];
field.Zm{1}=2000+[0,0;0,0];
% field.Xm{1}=[1,1;1,1];
% field.Ym{1}=[1,1;1,1];
% field.Zm{1}=[1,1;1,1];

%%     
MAP_INI
figure(100)
axis([-200,200,-200,200]);
global exp3_ADDviz
hold on
exp3_ADDviz.C=plot(exp6_data.C(1),exp6_data.C(2),'B.','MarkerSize',25);
exp3_ADDviz.Co=plot(exp6_data.C(1)+iso_par.d0*sin(0:pi/10:2*pi),exp6_data.C(2)+iso_par.d0*cos(0:pi/10:2*pi),'B-');
%plot(exp6_data.C(1),exp6_data.C(2),'Go');%,'MarkerSize',25);
MAP
%% RUN
figure(100)
% for i=1:5000
%     Modul.T=Modul.T+Modul.dT*10;
%     Modul.PlotPulse=mod(Modul.N,floor(Modul.freq/Modul.dT))==0;
%     iso_par.Dynamic();
%     drawnow
% end
MODUL