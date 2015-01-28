global MAP_PAR;
if (isfield(MAP_PAR,'MAP_H') &&  ishandle(MAP_PAR.MAP_H) && isequal('on',get(MAP_PAR.MAP_H,'Visible')))

global ISO_MAP_PAR ;
if (~isempty(ISO_MAP_PAR))
%% global
global iso_par;
global PAR;
%% Построение карты
    [X,Y] = meshgrid(PAR.MAP_X/2*(-1:1/ISO_MAP_PAR.MAP_D:1),PAR.MAP_Y/2*(-1:1/ISO_MAP_PAR.MAP_D:1));
    Z=iso_D(X,Y);
%% Отрисовка
%      if isempty(ISO_MAP_PAR.viz_surf)
%          figure(100)
%          ISO_MAP_PAR.viz_surf=surf(X/100,Y/100,Z);
%          %[~,ISO_MAP_PAR.viz_surf]=contourf(X,Y,Z);
%          set(ISO_MAP_PAR.viz_surf, 'EdgeColor', 'none')
%      else
%          set(ISO_MAP_PAR.viz_surf,'zdata',Z);
%      end
     
    if (iso_par.dopisofieldMap)
        Zd=Z;
        Zd(Z<150)=150;
        Zd(Z>500)=NaN;
        Zd=-Zd+150;
        if ~isfield(ISO_MAP_PAR,'dopisofieldMap')
            ISO_MAP_PAR.dopisofieldMap=surf(X/100,Y/100,Zd,'EdgeColor', 'none');
            mycolor=[0.95,0.95,0.95;
                    0.95,0.95,0.95;
                    0 0 1;
                    0 0 1];
            colormap(mycolor);                    
        else
            set(ISO_MAP_PAR.dopisofieldMap,'zdata',Zd)
        end
    end

    if isempty(ISO_MAP_PAR.viz_cont)
        figure(100)
        if (iso_par.TripleIsoline)
            Zisoline=[iso_par.d0-iso_par.d0d,iso_par.d0,iso_par.d0+iso_par.d0d];
        else
            Zisoline=[iso_par.d0,iso_par.d0+0];
        end
        [C,ISO_MAP_PAR.viz_cont]=contour(X/100,Y/100,Z,Zisoline,'B--');
        set(ISO_MAP_PAR.viz_cont,'LineWidth',1.5);
    else        
        set(ISO_MAP_PAR.viz_cont,'zdata',Z)
    end
    %drawnow
end
end
%%