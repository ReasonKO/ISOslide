%Rule(Nom,Left,Right,Kick,Sound,Sensor)
%���������� ������ ���������� � ������� Rules
%���������� 1��� �������� [1,*,*,...]

function Rule(Nom,Left,Right,Kick,Sound,Sensor)
global Pause;
global Rules;
RulesI=1;
Rules_length=size(Rules,1);

%% ����� ��������� ������
while ((RulesI<=Rules_length)&&((Rules(RulesI,1)>0)||((Rules(RulesI,1)==1)&&(Rules(RulesI,2)~=Nom))))
    RulesI=RulesI+1;
end

%% �������� ����������.
% <100
if (abs(Right)>100) 
    Right=sign(Right)*100; 
end
if (abs(Left)>100) 
    Left=sign(Left)*100;  
end
% ����������
Right=fix(Right);
Left=fix(Left);

%% �������� ����������
if (Pause~=1)
    Rules(RulesI,1)=1;
    Rules(RulesI,2)=Nom;
    Rules(RulesI,3)=Left;
    Rules(RulesI,4)=Right;
    Rules(RulesI,5)=Kick;
    Rules(RulesI,6)=Sound;
    Rules(RulesI,7)=Sensor;
end
 