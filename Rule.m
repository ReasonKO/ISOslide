%Rule(Nom,Left,Right,Kick,Sound,Sensor)
%Размещение нового управления в массиве Rules
%Добавление 1ого елемента [1,*,*,...]

function Rule(Nom,Left,Right,Kick,Sound,Sensor)
global Pause;
global Rules;
RulesI=1;
Rules_length=size(Rules,1);

%% Поиск свободной строки
while ((RulesI<=Rules_length)&&((Rules(RulesI,1)>0)||((Rules(RulesI,1)==1)&&(Rules(RulesI,2)~=Nom))))
    RulesI=RulesI+1;
end

%% Проверки управления.
% <100
if (abs(Right)>100) 
    Right=sign(Right)*100; 
end
if (abs(Left)>100) 
    Left=sign(Left)*100;  
end
% Округление
Right=fix(Right);
Left=fix(Left);

%% Передача управления
if (Pause~=1)
    Rules(RulesI,1)=1;
    Rules(RulesI,2)=Nom;
    Rules(RulesI,3)=Left;
    Rules(RulesI,4)=Right;
    Rules(RulesI,5)=Kick;
    Rules(RulesI,6)=Sound;
    Rules(RulesI,7)=Sensor;
end
 