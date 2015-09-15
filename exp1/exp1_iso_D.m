function re = iso_D(x,y)
global Blues
    NBm=7;
    modgroup=0;
    C=[0,0];
    Dq=0;
    Dq2=0;
    for i=1:NBm
        i=i+modgroup;
        C=C+Blues(i,2:3);
        for j=1:NBm
            j=j+modgroup;
            Dq=Dq+((Blues(i,2)-Blues(j,2))^2+(Blues(i,3)-Blues(j,3))^2);
        end
    end
    C=C/NBm;
    Dq=Dq/2/NBm/NBm;
    k=2;
    for i=1:NBm
        i=i+modgroup;
            Dq2=Dq2+((Blues(i,2)-C(1))^2+(Blues(i,3)-C(2))^2)^(k/2);
    end
    Dq2=(Dq2/NBm)^(2/k);
    Dq3=0;
    for i=1:NBm
        i=i+modgroup;
            Dq3=max(Dq3,((Blues(i,2)-C(1))^2+(Blues(i,3)-C(2))^2));
    end
    %iso_par.ANG=Blues(NB,4);
%    iso_par.C=400*[cos(iso_par.Tspeed*Modul.T/30),sin(iso_par.Tspeed*Modul.T/30)];
    %dop=@(x,y)0*sin(20*angVr(x,y));
    %if (get(0,'CurrentFigure')==100)
    %    iplot(iso_par.C(1),iso_par.C(2),'*');
    %end
    re=(((x-C(1)).^2+(y-C(2)).^2));%+Dq2);
end
