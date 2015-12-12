function re=exp3_reD(x,y)
global exp3_data
re=1000-sqrt((exp3_data.C(1)-x).^2+(exp3_data.C(2)-y).^2);
end