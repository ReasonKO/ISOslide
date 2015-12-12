function setPlotData(h,data1,data2,data3)
if ~ishandle(h)
    return
end
global Modul
if (nargin==2)
set(h,'xdata',Modul.T...
     ,'ydata',data1);
end
if (nargin==3)
set(h,'xdata',data1...
     ,'ydata',data2);
end
if (nargin==4)
set(h,'xdata',data1...
     ,'ydata',data2...
     ,'zdata',data3);
end
end