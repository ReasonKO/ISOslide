function createfigure(ZData1, YData1, XData1, CData1)
%CREATEFIGURE(ZDATA1, YDATA1, XDATA1, CDATA1)
%  ZDATA1:  surface zdata
%  YDATA1:  surface ydata
%  XDATA1:  surface xdata
%  CDATA1:  surface cdata

%  Auto-generated by MATLAB on 06-Jun-2016 23:40:34

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'PlotBoxAspectRatio',[25 25 1],...
    'DataAspectRatio',[1 1 1]);
%% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[50 100]);
%% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[50 100]);
box(axes1,'on');
hold(axes1,'all');

% Create surface
surface('Parent',axes1,'ZData',ZData1,'YData',YData1,'XData',XData1,...
    'EdgeColor','none',...
    'CData',CData1);

