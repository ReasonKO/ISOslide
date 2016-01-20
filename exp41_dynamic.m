global iso_save Modul exp3_data

global field


ang1=-Modul.T/400+2;
ang2=Modul.T/300-pi/5;
ang3=Modul.T/320+0.925;
field.Xm{1}=cos(ang1)*100+exp3_data.field_save.Xm{1};
field.Ym{1}=exp3_data.field_save.Ym{1};
%field.Xm{1}=cos(ang1)*exp3_data.field_save.Xm{1}-sin(ang1)*exp3_data.field_save.Ym{1};
%field.Ym{1}=sin(ang1)*exp3_data.field_save.Xm{1}+cos(ang1)*exp3_data.field_save.Ym{1};
field.Xm{2}=cos(ang2)*exp3_data.field_save.Xm{2}-sin(ang2)*exp3_data.field_save.Ym{2};
field.Ym{2}=sin(ang2)*exp3_data.field_save.Xm{2}+cos(ang2)*exp3_data.field_save.Ym{2};
field.Xm{3}=cos(ang3)*exp3_data.field_save.Xm{3}-sin(ang3)*exp3_data.field_save.Ym{3};
field.Ym{3}=sin(ang3)*exp3_data.field_save.Xm{3}+cos(ang3)*exp3_data.field_save.Ym{3};

field.Ym{3}=field.Ym{3}-50;

field.Ym{1}=field.Ym{1}+90;

field.Ym{2}=field.Ym{2}-50;

if abs(iso_save.dold(1)-exp3_data.Cv)<20
    Modul.T=Modul.Tend;
end