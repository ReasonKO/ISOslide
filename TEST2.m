figure(5446)
clf
load('H');

subplot(4,1,1)
plot(H);
subplot(4,1,2)
plot(azi([H,0]-[0,H]));
subplot(4,1,3)

%plot(filter(1,[4,-1,-2],azi([H,0]-[0,H])))
plot(filter([1,0,0,0,-1],[4,-1,-2],H))

subplot(4,1,4)
S=zeros(1,length(H));
for i=3:length(H)
    S(i)=(azi(H(i)-H(i-1))+19*S(i-1)+20*S(i-2))/40;
end
plot(S);
