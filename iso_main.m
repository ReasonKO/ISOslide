%����������
%% Data
%�� SSL
global Yellows Blues Rules Modul;
if isempty(Rules)
    Rules=zeros(12,7);
end
%% isoMAP
if (Modul.N==1)
    iso_info
end
%% iso
iso_rules=iso_rule(Yellows);
for i=1:iso_par.Nagent
    Rule(i,iso_rules(i,1),iso_rules(i,2),0,0,0);
end
iso_save();
%toc()
%% MAP
iso_MAP
MAP
%toc()