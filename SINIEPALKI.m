
%saveas(100,['test100map.png']);
dir='exp6_3';
mk=[dir,'\','bezPalok'];
mkdir(mk);   
files=ls(dir);
n=length(files);
for k=1:n
if ~isempty(regexp(files(k,:),'.png'))
filename=files(k,:);
fprintf('%d/%d %s\n',k,n,filename);
[X, map] = imread([dir,'\',filename],'png');
Y = X;

for i=1:901
    for j=1:1201
    
        if Y(i,j,3)==255
            Y(i,j,1)=255;
            Y(i,j,2)=255;
            Y(i,j,3)=255;
        end
    end
end
Y2=Y;
%Y2=repmat(Y,[1,1,3]);
imwrite(Y2,[mk,'\',filename],'png');
% hf=figure(101);
% clf
% subplot(1,2,2)
% %figure('color','k','Position',[0000 018 1201 901])
% axis([0,1200,0,900])
% image(Y2)
% colormap(map)
% axis off          % Remove axis ticks and numbers
% axis image 
% 
% subplot(1,2,1)
% image(X)
% axis off          % Remove axis ticks and numbers
% axis image 
end
end
