
MOD1=1;
%1 - цельная группа
%2 - цельная с гулякой по окружности
%3 - цельная с гулякой по линии
%4 - хаос
MOD2=2;
%1 - по окружности
%2 - дуги
%3 - компашка

NewGroupTime=1000;

global iso_par;
iso_par.d0d=400^2;   %Шарана коридора присоедования
iso_par.error=0.01;    %Ошибка датчика в %
iso_par.d0=1000^2; %приследуемое значение
iso_par.Type=7; %тип изолинии
iso_par.Sgrad=1200;%1  %Макс.градиент
iso_par.Tspeed=1;   %Ускорение изолинии по времени
iso_par.Nagent=2;%12  %Кол-во агентов
iso_par.smooth=1;   %*гладкий режим*

iso_par.Vmax=50; %Максимальная линейная скорость [Vmin..100]
iso_par.Vmin=10; %Минимальная линейная скорость  [0..Vmax] 
iso_par.Umax=50; %Максимальная скорость поворота [0..(100-Vmax)]

iso_par.R_vision=1000;       %Радиус видимости робота.
iso_par.Fi_vision=0.5*pi/2; %Угол видимости робота
iso_par.Rd_vision=0.9*iso_par.R_vision/iso_par.Nagent; % Радиус ближайших
iso_par.e=(iso_par.Vmax-iso_par.Vmin)/iso_par.Nagent/50;  %коэфициент замедления для ряда ближайших

iso_par.TracksVizual=1; %Демонстрация треков (0 - никогда, 1 - всегда, 2 - до выхода на изолинию)
iso_par.TracksTime=100; %Затирание трека спустя iso_par.TracksTime отрисовок
iso_par.TracksColor=[1,0,0];

global treckcolor;
treckcolor=[0.8,0.1,0.1];

global Pause; Pause=0;

global PAR;
if (MOD2==1)
    PAR.MAP_X=15000;
    PAR.MAP_Y=15000;
    ppz=0;
else
    PAR.MAP_X=20000;
    PAR.MAP_Y=10000;
    ppz=2000;
end
if (MOD2==3)
    PAR.MAP_X=5000;
    PAR.MAP_Y=5000;
end

if (MOD1==5)
    PAR.MAP_X=5000;
    PAR.MAP_Y=5000;
end
PAR.KICK_DIST=150;
%% Global INI
global MODUL_ON; MODUL_ON=1;
global iso_MODUL_ON; iso_MODUL_ON=1; 

global Rules;    Rules=zeros(12,7);
global Balls;    Balls=zeros(1,3);
global Blues;    Blues=zeros(12,4);
global Yellows;  Yellows=zeros(12,4);

global Modul;
if (MOD2==1)
Modul.Tend=3000; %Время работы
else
Modul.Tend=2500; %Время работы
end
Modul.dT=0.5;     %Щаг дискретизации
Modul.Delay=0;  %Задержка
Modul.l_wheel=100;
Modul.T=0;
Modul.N=0;
Modul.viz=0;
Modul.SaveExp=1;
