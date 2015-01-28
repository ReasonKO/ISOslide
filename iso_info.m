%function 
%     global Modul
%     gradD=@(x,y)[(iso_par.D(x+0.001,y)-iso_par.D(x,y))/0.001,(iso_D(x,y+0.001)-iso_par.D(x,y))/0.001];
%     gmax=0;
%     gmin=inf;
%     for x=-3000:50:3000
%         for y=-2000:50:2000
%             grd=norm(gradD(x,y));
%             gmax=max(gmax,grd);
%             gmin=min(gmin,grd);
%         end
%     end
%     [gmax;gmin]



% return;
% %% Параметры жизни
% %global dT;
% %% Параметры алгаритма
% global iso_d0 iso_d0d iso_Sgrad iso_D iso_C;
% %% Параметры роботов
% V_=60;
% gradDn=@(r)norm(([(iso_D(r+[0.001,0])-iso_D(r))/0.001,(iso_D(r+[0,0.001])-iso_D(r))/0.001]),2);
% maxgrad=0;
% mingrad=999999999999;
%     
% global MAP_X MAP_Y MAP_D;
% if isempty(MAP_D)
%     MAP_D=15;
% end
% [X,Y] = meshgrid(MAP_X/2*(-1:1/MAP_D:1),MAP_Y/2*(-1:1/MAP_D:1));
%     Z=zeros(size(X,1),size(Y,2));
%     for i=1:size(X,1)
%         for j=1:size(Y,2)
%             Z(i,j)=gradDn([X(i,j),Y(i,j)]);
%                    Dn= gradDn([i,j]);
%             if (Z(i,j)>maxgrad)
%                 maxgrad=Z(i,j);
%             end
%             if (Z(i,j)<mingrad)
%                 mingrad=Z(i,j);
%             end
%             if (Z(i,j)<0)
%                 Z(i,j)=0;
%             end
%         end
%     end
% global surf_h2;
% if isempty(surf_h2)
%  %       surf_h2=surf(X,Y,-Z);
% else
% %        set(surf_h2,'zdata',-Z);
% end
% [sum(sum(Z))/(size(X,1)*size(X,2)),maxgrad,mingrad]
%end