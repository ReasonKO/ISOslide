function re = iso_D(x,y)
global iso_par
if isempty(iso_par)
    re=NaN;
else
    re=iso_par.re_D(x,y);
end
% global EXPERIMENT
% if isempty(EXPERIMENT) || ~isfield(EXPERIMENT,'iso_D') || isempty(EXPERIMENT.iso_D)
%     re=EXPERIMENT.iso_D(x,y);
%     return
% end
% if (nargin==1 && sum(size(x))==3)
%     y=x(2);
%     x=x(1);
% end
% re=NaN;
% if (iso_par.Type==1)
%     %iso_par.C=[0,0];
%     iso_par.C=400*[cos(iso_par.Tspeed*Modul.T/30),sin(iso_par.Tspeed*Modul.T/30)];
%     dop=@(x,y)0*sin(20*angVr(x,y));
%     iso_par.D=@(x,y)+0.4*sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2)+dop(x,y);
% 
% end
% if (iso_par.Type==2)
%     dop=@(x,y)0*sin(x/10).*cos(y/10);    
%     iso_par.C=[0,0];
%     iso_par.D=@(x,y)+dop(x,y)+0.1*(4+sin(iso_par.Tspeed*Modul.T/30+5*angVr(x,y))).*sqrt((x).^2+(y).^2)*(9+cos(iso_par.Tspeed*Modul.T/150))/9;
% end
% if (iso_par.Type==3)
%     iso_par.C=[0,0];
%     iso_par.D=@(x,y)+0.6*(1.5+sin(4+iso_par.Tspeed*Modul.T/200+2*angVr(x,y))).*sqrt((x).^2+(y).^2);
% end
% if (iso_par.Type==4)
%     iso_par.C=[0,0];
%     iso_par.C2=2000*[cos(iso_par.Tspeed*Modul.T/150),sin(iso_par.Tspeed*Modul.T/150)];
%     iso_par.D=@(x,y)-2750+200*(((x-iso_par.C2(1)/2).^2+(y-iso_par.C2(2)/2).^2).^(1/7)+((x+iso_par.C2(1)).^2+(y+iso_par.C2(2)).^2).^(1/7));
% end
% if (iso_par.Type==5)
%     iso_par.C=[0,0];
%     iso_par.C2=1500*[1,0];
%     iso_par.D=@(x,y)-2750+200*(((x-iso_par.C2(1)).^2+(y-iso_par.C2(2)).^2).^(1/7)+((x+iso_par.C2(1)).^2+(y+iso_par.C2(2)).^2).^(1/7));
% end
% if (iso_par.Type==6)
%     NB=9;
%     iso_par.C=Blues(NB,2:3);
%     iso_par.ANG=Blues(NB,4);
% %    iso_par.C=400*[cos(iso_par.Tspeed*Modul.T/30),sin(iso_par.Tspeed*Modul.T/30)];
%     %dop=@(x,y)0*sin(20*angVr(x,y));
%     iso_par.D=@(x,y)+0.4*sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2)+...
%        200*abs(( (x-iso_par.C(1))*sin(iso_par.ANG)+(y-iso_par.C(2))*cos(iso_par.ANG))./...
%        ((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2).^(1/2));
% end
% if (iso_par.Type==7)
%     NBm=8;
%     if (MOD1==1)
%         NBm=7;
%     end
%     modgroup=0;
%     if (MOD1==5)
%         NBm=6;
%         modgroup=6*(Modul.T>NewGroupTime);
%     end
%     iso_par.C=[0,0];
%     Dq=0;
%     Dq2=0;
%     for i=1:NBm
%         i=i+modgroup;
%         iso_par.C=iso_par.C+Blues(i,2:3);
%         for j=1:NBm
%             j=j+modgroup;
%             Dq=Dq+((Blues(i,2)-Blues(j,2))^2+(Blues(i,3)-Blues(j,3))^2);
%         end
%     end
%     iso_par.C=iso_par.C/NBm;
%     Dq=Dq/2/NBm/NBm;
%     k=2;
%     for i=1:NBm
%         i=i+modgroup;
%             Dq2=Dq2+((Blues(i,2)-iso_par.C(1))^2+(Blues(i,3)-iso_par.C(2))^2)^(k/2);
%     end
%     Dq2=(Dq2/NBm)^(2/k);
%     Dq3=0;
%     for i=1:NBm
%         i=i+modgroup;
%             Dq3=max(Dq3,((Blues(i,2)-iso_par.C(1))^2+(Blues(i,3)-iso_par.C(2))^2));
%     end
%     %iso_par.ANG=Blues(NB,4);
% %    iso_par.C=400*[cos(iso_par.Tspeed*Modul.T/30),sin(iso_par.Tspeed*Modul.T/30)];
%     %dop=@(x,y)0*sin(20*angVr(x,y));
%     %if (get(0,'CurrentFigure')==100)
%     %    iplot(iso_par.C(1),iso_par.C(2),'*');
%     %end
%     iso_par.D=@(x,y)+(((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2));%+Dq2);
% end
% re=zeros(size(x));
% global Blues;
% global iso_par;
% 
% if ((iso_par.Type==7) || (iso_par.Type==8))
%     Wmod=iso_par.dop.Wmod;
%     if (Wmod==1)
%         k=120;
%         p=2.1;
%         W=@(d)((d/k).^-p);
%     end
%     if (Wmod==2)
%         k=300;
%         W=@(d)(cos(d/k)+1).*and(d/k<=pi,-pi<=d/k)-0.001;
%     end
%     for i=1:23
%         if (Blues(i,1))
%             di=sqrt((Blues(i,2)-x).^2+(Blues(i,3)-y).^2);
%             de=W(di).*di.^2;
%             re=re+de;
%         end
%     end
% end
% 
% if (iso_par.Type==9)
%     Nrob=0;
%     const1=15;
%     k=0.1;
%     const2=10000000;
%     %%
%     dis=zeros(size(x));
%     for i=1:size(Blues,1)
%         if (Blues(i,1))
%             di=sqrt((Blues(i,2)-x).^2+(Blues(i,3)-y).^2);            
%             dis=dis+di.^2;
%             Nrob=Nrob+1;
%         end        
%     end
%     %dis=NaN*ones(size(x));
%     for i=1:50
%         if (Blues(i,1))
%             di=sqrt((Blues(i,2)-x).^2+(Blues(i,3)-y).^2);            
%             re=re+const2./(di.^k);
%             %re=re+NaN*ones(size(x));
%         end        
%     end
%     
%     re(dis>Nrob*(const1*100)^2)=dis(dis>Nrob*(const1*100)^2);
% end
% if (iso_par.Type==10) || (iso_par.Type>10 && iso_par.Type<=19)
%     dimax1=inf*ones(size(x));
%     dimax2=inf*ones(size(x));
%     for i=1:size(Blues,1)
%         if (Blues(i,1))
%             dinew=sqrt((Blues(i,2)-x).^2+(Blues(i,3)-y).^2);            
%             dimax2(and(dinew>dimax1,dinew<dimax2))=dinew(and(dinew>dimax1,dinew<dimax2));
%             dimax2(dinew<=dimax1)=dimax1(dinew<=dimax1);
%             dimax1(dinew<=dimax1)=dinew(dinew<=dimax1);   
%             
%         end
%     end
%     re=(dimax2+dimax1)/2;    
% end

% if (iso_par.Type==10) || (iso_par.Type>10 && iso_par.Type<16)
%     sX=size(x);
%     %dimax1=inf*ones(sX);
%     %dimax2=inf*ones(sX);
%     onBlues=Blues(Blues(:,1)==1,:);
%     sB=size(onBlues,1);
%     %Mdinew=zeros([sX,sB]);
%     Mdinew=sqrt((repmat(reshape(onBlues(:,2),[1,1,sB]),[sX,1])- repmat(x,[1,1,sB])).^2 ...
%                +(repmat(reshape(onBlues(:,3),[1,1,sB]),[sX,1])- repmat(y,[1,1,sB])).^2);
%     
%     %Mdinew=sqrt((Blues(:,2)-x).^2+(Blues(:,3)-y).^2);
%     %Mdinew(Blues(:,1)==0)=NaN;
%     [dimax1,~]=min(Mdinew,'',3);
% %    Mdinew(:,:,I)=NaN;
% %    [dimax2,~]=min(Mdinew,'',3);    
%     re=(dimax1)/2;   
% end

% 
% if (iso_par.Type>10 && iso_par.Type<16)
%     dimax1=inf*ones(size(x));
%     for i=1:size(Blues,1)
%         if (Blues(i,1))
%             dinew=sqrt((Blues(i,2)-x).^2+(Blues(i,3)-y).^2);            
%             dimax1(dinew<dimax1)=dinew(dinew<dimax1);               
%         end
%     end
%     re=dimax1;
% end

%    iso_par.D=@(x,y)+sqrt(x.^2+y.^2);
% if (iso_par.Type==1)
%     re=sqrt(x.^2+y.^2);
% end
% if (iso_par.Type==2)
%     Ct=mod(Modul.T*iso_par.Tspeed,1000);
%     if (Ct>500)
%         iso_par.C=[2000,2000]-8*[Ct-500,Ct-500];
%     else
%         iso_par.C=-[2000,2000]+8*[Ct,Ct];
%     end
%     re=sqrt((x-iso_par.C(1)).^2+(y-iso_par.C(2)).^2);
% end
% if (iso_par.Type==3)
%     iso_par.C=[0,0];
%     re=1/1.5*(1.5+sin(pi*3/2+2*angVr(x,y))).*sqrt((x).^2+(y).^2);
% end
% if (iso_par.Type==4)
%     iso_par.C=[0,0];
%     re=1/1.5*(1.5+sin(4+iso_par.Tspeed*Modul.T/200+2*angVr(x,y))).*sqrt((x).^2+(y).^2);
% end
% if (iso_par.Type==5)
%     iso_par.C=[0,0];
%     re=(4+sin(5*angVr(x,y)))/4.*sqrt((x).^2+(y).^2);
% end
% if (iso_par.Type==6)
%     iso_par.C=[0,0];
%     re=(4+sin(iso_par.Tspeed*Modul.T/30+5*angVr(x,y)))/4.*sqrt((x).^2+(y).^2)*(9+cos(iso_par.Tspeed*Modul.T/150))/9;
% end
end

