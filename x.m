% figure(10)
% clf
% axis([-200,200,-200,200]);
% hold on
% T=[0:1:2000]'.*1.6
% S2=90*[-cos(2*atan(sin(T/200)))+sin(T/300),atan(T/500)-1+sin(T/100)/2];%%%%%-----
% plot(S2(:,1),S2(:,2),'R')
% 
% 
% S=90*[-cos(6*atan(sin(T/200)))/2+1.1*sin(T/300),2*atan(T/400)-2*T/10000+sin(T/100)-1.6];
% plot(S(:,1),S(:,2))

figure(4)
clf
T=[0:1:1000]';
%Y=500+1000*floor(T/1000)

dx=50;
spT=@(x,T)max(x,min(T,x+dx))-x;
X=0;Y=0;
for i=0:18
    X=X+spT(dx*i*2,T-dx);
    Y=Y+spT(dx*i*2,T)*(mod(i,2)==0)-spT(dx*i*2,T)*(mod(i,2)==1);
end
Y=(Y-25)*3;
X=(X-250)*0.7;

subplot(2,1,1)
plot(X)
%Y=(spT(dy*2*0,Ty)-spT(dy*2*1,Ty)+spT(dy*2*3,Ty)-spT(dy*2*4,Ty))-200;
subplot(2,1,2)
plot(Y)
figure(5)
clf
axis([-200,200,-200,200]);
hold on
plot(X,Y)



%hold on
%plot(T,'R')
%plot(max(T,Y),'G')


%Y=max(Y,
clear all
figure(5)

T=500

dx=50;
spT=@(x,T)max(x,min(T,x+dx))-x;
X=0;Y=0;
for i=0:18
    X=X+spT(dx*i*2,T-dx);
    Y=Y+spT(dx*i*2,T)*(mod(i,2)==0)-spT(dx*i*2,T)*(mod(i,2)==1);
end
Y=(Y-25)*3;
X=(X-250)*0.7;

plot(X,Y,'G*');