N___=5751;

% for countexp3=1:N___
%     S{countexp3}=load(sprintf('exp3FULL4\\exp3_r_%d',countexp3));
%  end
clear T C SS
figure(999)
clf
hold on
for countexp3=1:N___
    SS=S{countexp3};
    %plot(C(countexp3,1),C(countexp3,2))
end


for countexp3=1:N___
SS=S{countexp3};
C(countexp3,1:2)=SS.StartCoor(1:2);
if isfield(SS.Modul,'Tsave')
T(countexp3)=SS.Modul.Tsave;
else
T(countexp3)=99999;
end
end

valid=and(and(~isnan(T),~isinf(T)),T<99999);
Tmax=3000;%2500;%max(T(valid));
clear mycolor
for i=1:N___
    if valid(i)
        mycolor(i)=min(1,T(i)/Tmax);
        plot3(C(i,1),C(i,2),T(i),'*','Color',[mycolor(i),1-mycolor(i),0])
    end
end

figure(998)
clf
Cx=C(:,1);
Cy=C(:,2);
Cc=mycolor(:);
%
%Cx=C(valid,1);
%Cy=C(valid,2);
%Cc=mycolor(valid);
N=size(Cc,1)*size(Cc,2);
p=71
Cx=reshape(Cx,p,N___/p);
Cy=reshape(Cy,p,N___/p);
Cc=reshape(Cc,p,N___/p);
p=pcolor(Cx,Cy,Cc)
set(p,'EdgeColor','none');
[X____,Y____]=meshgrid([-300:5:100],[-200:5:150]);
[X,Y]=meshgrid(-300:1:100,-200:150);
axis equal tight

% n = 6;
% r = (0:n)'/n;
% theta = pi*(-n:n)/n;
% 
% X = r*cos(theta);
% Y = r*sin(theta);
% C = r*cos(2*theta);
% N=size(X,1)*size(X,2);
% X=reshape(X,1,N);
% Y=reshape(Y,1,N);
% C=reshape(C,1,N);
% pcolor(X,Y,C)
% axis equal tight 