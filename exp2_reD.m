function re=exp2_reD(x,y)
global Blues exp2_data
al=exp2_data.al;
range=inf*ones(size(x));
for i=1:size(Blues,1)
    range_i=sqrt((Blues(i,2)-x).^2+(Blues(i,3)-y).^2);
    range=min(range,range_i);
end
re=range;
    
if exp2_data.MOD2
    sum=zeros(size(x));
    for i=1:size(Blues,1)
        range_i=sqrt((Blues(i,2)-x).^2+(Blues(i,3)-y).^2);
        x_e=exp(-al*(range_i-range));
        sum=sum+x_e;
    end
    re=range-1/al*log(sum);
end
end