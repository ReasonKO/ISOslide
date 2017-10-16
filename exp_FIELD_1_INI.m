

r0=1;
sr0=sqrt(3)*r0;

Robots=struct('X',{},'di',{},'theta',{});

for i=1:12
    %randomize
    Robots(i).X=[rand(1)*200-100,rand(1)*200-100];
    ang=rand(1)*2*pi;
    r=rand(1)*r0;
    Robots(i).di=r*[cos(ang),sin(ang)];
    Robots(i).theta=rand(1)*pi/3;
end

