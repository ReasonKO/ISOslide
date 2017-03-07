%MAP_INI
%Инициализация структуры MAP и создание figure(100)
%для быстрой последовательной отрисовки кадров.

global Blues
global Yellows
clear MAP_PAR; 
global MAP_PAR;
MAP_PAR.MAP_H=figure(100);
clf
hold on;grid off;
xlabel('metres');
ylabel('metres');
global PAR;
if (isempty(PAR))
    fprintf('PAR is not initialized/f');
    return;
end
axis equal
axis([-PAR.MAP_X/2,PAR.MAP_X/2,-PAR.MAP_Y/2,PAR.MAP_Y/2,0,2]);
%plot(C(1)+300*sin(0:0.1:2*pi),C(2)+300*cos(0:0.1:2*pi));
set(gca,'Color',[0.95 0.95 0.95]);

MAP_PAR.viz_Balls=[];

for i=1:size(Blues,1)
    MAP_PAR.viz_Blues{i}=[];
end
for i=1:size(Yellows,1)
    MAP_PAR.viz_Yellows{i}=[];
end