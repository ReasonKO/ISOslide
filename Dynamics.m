global Blues Modul

if (iso_par.Type==15)    
    M=300+100*sin(Modul.T*iso_par.Tspeed/30);
    Blues=zeros(1000,4);
    Blues=AddBlues([-1,4]*M,[1,4]*M,3,Blues);
    Blues=AddBlues([-1,3]*M,[1,3]*M,3,Blues);
    Blues=AddBlues([-1,2]*M,[1,2]*M,3,Blues);
    Blues=AddBlues([-4,1]*M,[4,1]*M,9,Blues);
    Blues=AddBlues([-4,0]*M,[4,0]*M,9,Blues);
    Blues=AddBlues([-4,-1]*M,[4,-1]*M,9,Blues);
    Blues=AddBlues([-1,-4]*M,[1,-4]*M,3,Blues);
    Blues=AddBlues([-1,-3]*M,[1,-3]*M,3,Blues);
    Blues=AddBlues([-1,-2]*M,[1,-2]*M,3,Blues);    
end

if (iso_par.Type==14)
    if (iso_par.dopisofieldMap)
       NC=100;
    else
       NC=50;
    end
    ta=2*pi*(0:NC)'/NC;
    CR=1000;
    M=Modul.T*iso_par.Tspeed/50;
    
    [A,B]=rotV(2*cos(pi/2-ta),sin(pi/2-ta),M);
    Blues(1:size(ta,1),2:3)=1000.*[A,B];
    Blues((size(ta,1)  +1):2*size(ta,1),2:3)=1100*[A,B];
    Blues((size(ta,1)*2+1):3*size(ta,1),2:3)=1250*[A,B];
    Blues((size(ta,1)*3+1):4*size(ta,1),2:3)=1400*[A,B];
    Blues(1:4*size(ta,1),1)=1;
end
if (iso_par.Type==12) 
    Blues=zeros(1000,4);
    M=mod(Modul.T*iso_par.Tspeed/100,4);    
    D=[-100,-100];
    D=D+[0,200]*min(1,max(0,M));
    D=D+[200,0]*min(1,max(0,M-1));
    D=D+[0,-200]*min(1,max(0,M-2));
    D=D+[-200,0]*min(1,max(0,M-3));
    
    zn=[-8,-4;6,-6;5,5;-5,4]*200;
    zn=zn+10*repmat(D,[4,1]);
    Ln1=repmat(zn(1,:),[11,1])+(0:10)'/10*(zn(2,:)-zn(1,:));
    Ln2=repmat(zn(4,:),[11,1])+(0:10)'/10*(zn(3,:)-zn(4,:));
    for i=1:11
        Blues=AddBlues(Ln1(i,:),Ln2(i,:),10,Blues);
    end
%     Blues(1:40,1)=1;   
%     Blues( 1:10,2:3)=repmat(zn(1,:),[10,1])+(1:10)'/10*(zn(2,:)-zn(1,:));
%     Blues(11:20,2:3)=repmat(zn(2,:),[10,1])+(1:10)'/10*(zn(3,:)-zn(2,:));
%     Blues(21:30,2:3)=repmat(zn(3,:),[10,1])+(1:10)'/10*(zn(4,:)-zn(3,:));
%     Blues(31:40,2:3)=repmat(zn(4,:),[10,1])+(1:10)'/10*(zn(1,:)-zn(4,:));
end
