global Blues Yellows iso_par PAR

% if (iso_par.Type==7 || iso_par.Type==8)
%     for i=1:23
%         Blues(i,:)=[1,(rand()*200+500)*cos(pi/2-0.5+i/10*pi),(rand()*200+500)*sin(pi/2-0.5+i/10*pi),pi]+...
%             +[0,rand()*100,rand()*100,0];
%     end
% end
if (iso_par.Type==7 || iso_par.Type==8)
    Blues(1:23,[2,3])= [ 12     9
        10    11
        11     6
         8     4
         6     5
         8     9
         4     2
         2     0
        -1     2
        -4     2
        -5     5
        -8     4
        -6     7
       -10     6
        -8     9
       -10     9
         0    -3
         1    -6
         3    -8
        -2    -8
         1   -10
         2   -12
        -1   -12]*100;
end
if (iso_par.Type==9 || iso_par.Type==10)
    Blues(1:37,1)=ones(1,37);
    Blues(1:37,[2,3])= [  ...
        [-3*ones(1,7);-3:3]'
        [-2*ones(1,7);-3:3]'
        [-1*ones(1,3);-3:-1]'
        [-0*ones(1,3);-3:-1]'
        [1*ones(1,3);-3:-1]'
        [2*ones(1,7);-3:3]'
        [3*ones(1,7);-3:3]']*200;
end
if (iso_par.Type==11)
    ta=pi/2*([1:1:10,11:1:29,30:1:39])'/10;
    Blues(1:size(ta,1),1)=1;
    R=700*sin(pi/2+0*pi/6+0*ta/2*(1-2/6));%+100*(1.2./(0.2+sin(ta/2))-1);    
    Blues(1:size(ta,1),2:3)=150*(1.2./(0.2+sin(ta/2))-1)*[0,1]*0+[R,R].*[cos(pi/2-ta),sin(pi/2-ta)]+0*repmat([0,500],size(ta));
%     for i=2:(size(ta)/2)
%         plot([Blues(i,2),Blues(1+size(ta,1)-i,2)],[Blues(i,3),Blues(1+size(ta,1)-i,3)])
%     end
%     Blues(1:(2*size(ta,1)+10),1)=1;
%     Blues((size(ta,1)+1):2*size(ta,1),2:3)=100*(1.2./(0.2+sin(ta/2))-1)*[0,1]+[R,R]/2.*[cos(pi/2-ta),sin(pi/2-ta)]+repmat([0,500],size(ta));
%     Blues((2*size(ta,1)+1):((2*size(ta,1))+10),2:3)=100.*[cos((1:10)'/10*2*pi),sin((1:10)'/10*2*pi)]+repmat([0,500],[10,1]);
%     Blues=AddBlues([20,20],[-20,-20],2,Blues);
end

if (iso_par.Type==13)    
    zn=[-3,-1;-0.5,-1;0.5,-7;4,-7;4,1;0.5,1;-0.5,6;-3,6]*200;
    Blues(1:100,1)=1;   
    Blues( 1:10,2:3)=repmat(zn(1,:),[10,1])+(1:10)'/10*(zn(2,:)-zn(1,:));
    Blues(11:20,2:3)=repmat(zn(2,:),[10,1])+(1:10)'/10*(zn(3,:)-zn(2,:));
    Blues(21:30,2:3)=repmat(zn(3,:),[10,1])+(1:10)'/10*(zn(4,:)-zn(3,:));
    Blues(31:50,2:3)=repmat(zn(4,:),[20,1])+(1:20)'/20*(zn(5,:)-zn(4,:));
    Blues(51:60,2:3)=repmat(zn(5,:),[10,1])+(1:10)'/10*(zn(6,:)-zn(5,:));
    Blues(61:70,2:3)=repmat(zn(6,:),[10,1])+(1:10)'/10*(zn(7,:)-zn(6,:));
    Blues(71:80,2:3)=repmat(zn(7,:),[10,1])+(1:10)'/10*(zn(8,:)-zn(7,:));
    Blues(81:100,2:3)=repmat(zn(8,:),[20,1])+(1:20)'/20*(zn(1,:)-zn(8,:));
end
if (iso_par.Type==14)
    if (iso_par.dopisofieldMap)
       NC=100;
    else
       NC=50;
    end
    ta=2*pi*(0:NC)'/NC;
    CR=1000;
    Blues(1:size(ta,1),2:3)=1000.*[2*cos(pi/2-ta),sin(pi/2-ta)];
    Blues((size(ta,1)  +1):2*size(ta,1),2:3)=1100.*[2*cos(pi/2-ta),sin(pi/2-ta)];
    Blues((size(ta,1)*2+1):3*size(ta,1),2:3)=1250.*[2*cos(pi/2-ta),sin(pi/2-ta)];
    Blues((size(ta,1)*3+1):4*size(ta,1),2:3)=1400.*[2*cos(pi/2-ta),sin(pi/2-ta)];
    Blues(1:4*size(ta,1),1)=1;
end

%AddBlues=@(i,j,N)repmat(zn(i,:),[N,1])+(1:N)'/N*(zn(j,:)-zn(i,:));
Dynamics();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Yellows    
%--- DEFAULT
for i=1:iso_par.Nagent
    Yellows(i,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y*0.8,PAR.MAP_Y*0.5,2*pi]];
    %fi=rand(1,1)*2*pi;
    %Yellows(i,:)=[1,1250*[cos(fi),sin(fi)],fi-pi/2];
end
if (iso_par.Type==14)
    for i=1:iso_par.Nagent
        rang=rand(1,1)*2*pi;
        rR=rand(1,1)*CR*0.8;
        Yellows(i,:)=[1,rR*2*cos(rang),rR*sin(rang),rand(1,1)*2*pi];
    end
end

%Yellows(1,:)=[1,800,300,pi/2];
%Yellows(2,:)=[1,0,300,pi/2];
%Yellows(3,:)=[1,-600,300,-pi/2];