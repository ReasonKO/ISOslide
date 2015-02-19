% MOD_NGO(N,R,Color,speed)
% —оедин€ет пару номера управлени€ и номера робота
% » замыкает контур управлени€

function MOD_NGO(N,R,Color,speed)
global Rules;
global Blues Yellows Greens;
if (Color=='Y') 
    for i=1:size(Rules,1)    
        if (Rules(i,1)==1)&&(Rules(i,2)==R)
            Yellows(N,:)=[Yellows(N,1),MOD_GO(Yellows(N,2:3),Yellows(N,4),speed*Rules(i,3:4))];
        end
    end
end
if (Color=='B')
    for i=1:size(Rules,1)    
        if (Rules(i,1)==1)&&(Rules(i,2)==R)
             Blues(N,:)=[Blues(N,1),MOD_GO(Blues(N,2:3),Blues(N,4),speed*Rules(i,3:4))];
        end
    end
end
if (Color=='G')
    for i=1:size(Rules,1)    
        if (Rules(i,1)==1)&&(Rules(i,2)==R)
             Greens(N,:)=[Greens(N,1),MOD_GO(Greens(N,2:3),Greens(N,4),speed*Rules(i,3:4))];
        end
    end
end