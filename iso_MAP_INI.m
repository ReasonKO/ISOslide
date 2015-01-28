%if ~isempty(iso_MODUL_ON)
fprintf('Start ISO_MAO INI...')
%% ISO_MAP_INI
MAP_INI
clear ISO_MAP_PAR;
global ISO_MAP_PAR;
ISO_MAP_PAR.MAP_D=100;
ISO_MAP_PAR.viz_surf=[];
ISO_MAP_PAR.viz_cont=[];
colormap(copper);%copper gray
fprintf('OK\n')
