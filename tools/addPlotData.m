function addPlotData(h,data1,data2,data3)
if ~ishandle(h)
    return
end
global Modul
if (nargin==2)
set(h,'xdata',[get(h,'Xdata'),Modul.T]...
     ,'ydata',[get(h,'Ydata'),data1]);
end
if (nargin==3)
set(h,'xdata',[get(h,'Xdata'),data1]...
     ,'ydata',[get(h,'Ydata'),data2]);
end
if (nargin==4)
set(h,'xdata',[get(h,'Xdata'),data1]...
     ,'ydata',[get(h,'Ydata'),data2]...
     ,'zdata',[get(h,'Zdata'),data3]);
end
end