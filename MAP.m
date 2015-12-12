% MAP
% Отрисовка поля и игроков 
% Создание структуры MAP_PAR и перемещение отрисованного ранее

%% Было ли создано окно?
global MAP_PAR iso_par;
global Blues Yellows Balls Greens;
if (isfield(MAP_PAR,'MAP_H') && ishandle(MAP_PAR.MAP_H) && isequal('on',get(MAP_PAR.MAP_H,'Visible')))
%% BEGIN 

MAP_l=20;
for MAP_i=1:size(Blues,1)
    if ~(iso_par.dopisofieldMap)
        if (Blues(MAP_i,1)>0)
            viz_x=Blues(MAP_i,2);
            viz_y=Blues(MAP_i,3);
            viz_angx=[Blues(MAP_i,2),Blues(MAP_i,2)+MAP_l*cos(Blues(MAP_i,4))];
            viz_angy=[Blues(MAP_i,3),Blues(MAP_i,3)+MAP_l*sin(Blues(MAP_i,4))];
            if (isempty(MAP_PAR.viz_Blues{MAP_i}))
                figure(100)
                MAP_PAR.viz_Blues{MAP_i}(1)=plot(viz_x,viz_y,'B.','MarkerSize',15);        
                %MAP_PAR.viz_Blues{MAP_i}(2)=plot(viz_angx,viz_angy,'B-');            
                %MAP_PAR.viz_Blues{MAP_i}(3)=text(viz_x+MAP_l/2,viz_y+MAP_l/2,{MAP_i});
            else                        
                set(MAP_PAR.viz_Blues{MAP_i}(1),'xdata',viz_x,'ydata',viz_y);
                %set(MAP_PAR.viz_Blues{MAP_i}(2),'xdata',viz_angx,'ydata',viz_angy);    
                %set(MAP_PAR.viz_Blues{MAP_i}(3),'Position',[viz_x+MAP_l/2,viz_y+MAP_l/2]);    
            end
        end
    end
end    
for MAP_i=1:size(Yellows,1)
    if (Yellows(MAP_i,1)>0)
        viz_x=Yellows(MAP_i,2);
        viz_y=Yellows(MAP_i,3);
        viz_angx=[Yellows(MAP_i,2),Yellows(MAP_i,2)+MAP_l*cos(Yellows(MAP_i,4))];
        viz_angy=[Yellows(MAP_i,3),Yellows(MAP_i,3)+MAP_l*sin(Yellows(MAP_i,4))];
        if (isempty(MAP_PAR.viz_Yellows{MAP_i}))
            figure(100)
            if (MAP_i<=iso_par.Nagent-iso_par.Nagent2)
                MAP_PAR.viz_Yellows{MAP_i}(1)=plot(viz_x,viz_y,'R.','MarkerSize',25);   
                MAP_PAR.viz_Yellows_track{MAP_i}=plot(viz_x,viz_y,'LineWidth',2,'Color',iso_par.TracksColor);   
                MAP_PAR.viz_Yellows{MAP_i}(2)=plot(viz_angx,viz_angy,'R-','LineWidth',2);            
            else
                MAP_PAR.viz_Yellows{MAP_i}(1)=plot3(viz_x,viz_y,1,'G.','MarkerSize',25);   
                MAP_PAR.viz_Yellows_track{MAP_i}=plot(viz_x,viz_y,'LineWidth',2,'Color',iso_par.TracksColor);   
                MAP_PAR.viz_Yellows{MAP_i}(2)=plot(viz_angx,viz_angy,'G-','LineWidth',2);            
            end
            %MAP_PAR.viz_Yellows{MAP_i}(3)=text(viz_x+MAP_l/2,viz_y+MAP_l/2,{MAP_i});
        else                        
            set(MAP_PAR.viz_Yellows{MAP_i}(1),'xdata',viz_x,'ydata',viz_y);
            if (iso_par.TracksVizual==1)||((iso_par.TracksVizual==2) && (norm(iso_par.TrackViz)>0))
                xd=get(MAP_PAR.viz_Yellows_track{MAP_i},'xdata');
                yd=get(MAP_PAR.viz_Yellows_track{MAP_i},'ydata');
                set(MAP_PAR.viz_Yellows_track{MAP_i},'xdata',[xd(max(end-iso_par.TracksTime,1):end),viz_x],'ydata',[yd(max(end-iso_par.TracksTime,1):end),viz_y]);            
            else
                set(MAP_PAR.viz_Yellows_track{MAP_i},'xdata',NaN,'ydata',NaN);            
            end
                %   set(MAP_PAR.Track,'xdata',[xd(max(end-2000,1):end),CC(1)+Xr*cos(a1:ad:a2)],'ydata',[yd(max(end-2000,1):end),CC(2)+Xr*sin(a1:ad:a2)]);            
            set(MAP_PAR.viz_Yellows{MAP_i}(2),'xdata',viz_angx,'ydata',viz_angy);                 
            %set(MAP_PAR.viz_Yellows{MAP_i}(3),'Position',[viz_x+MAP_l/2,viz_y+MAP_l/2]);   
        end
    end
end

if (Balls(1)>0)
    viz_x=Balls(2);
    viz_y=Balls(3);
    if (isempty(MAP_PAR.viz_Balls))
        figure(100)
        MAP_PAR.viz_Balls=plot(viz_x,viz_y,'Ro');
    else
        set(MAP_PAR.viz_Balls,'xdata',viz_x,'ydata',viz_y);
    end
end
drawnow
%% END
end
