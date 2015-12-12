%Внутреннее
%% Data
%от SSL
global Yellows Blues Rules Modul;
if isempty(Rules)
    Rules=zeros(12,7);
end
%% isoMAP
if (Modul.N==1)
    iso_info
end
%% iso
global iso_par
if isempty(iso_par.Rule)
    iso_rules=iso_rule(Yellows);
else
    iso_rules=iso_par.Rule(Yellows);
end
for i=1:iso_par.Nagent
    Rule(i,iso_rules(i,1),iso_rules(i,2),0,0,0);
end
% iso_save();
%toc()
%% MAP
%iso_MAP
%MAP
%toc()