

%saveas(100,['test100map.png']);
dir='exp6_3';
mk=[dir,'\','bezPalok'];
dir=mk;
mk=[dir,'\','gif'];
mkdir(mk);   
%mkdir([dir,'\','gif']);   
files=ls(dir);


n=length(files);
idx=0;
figure(1)



for i=1:n
if ~isempty(regexp(files(i,:),'.png'))
filename=files(i,:);
fprintf('%d/%d %s\n',i,n,filename);
[X, map] = imread([dir,'\',filename],'png');
image(X);
colormap(map)
axis off          % Remove axis ticks and numbers
axis image 

idx=idx+1;
    drawnow
    [A,map] = rgb2ind(X,256);

if idx == 1
    imwrite(A,map,[mk,'\movie.gif'],'gif','LoopCount',Inf,'DelayTime',0.5);
else
    imwrite(A,map,[mk,'\movie.gif'],'WriteMode','append','DelayTime',0.1);
end

end
end


return
[A,map] = rgb2ind(im{idx},256);
imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);

return


close all
clear all
clc
figure(1);
x = 0:0.01:1;
n = 3;
y = x.^n;
plot(x,y,'LineWidth',3)
title(['y = x^n,  n = ' num2str(n) ])
n = 1:0.5:5;
nImages = length(n);

figure(1);

for idx = 1:nImages
    y = x.^n(idx);
    plot(x,y,'LineWidth',3)
    title(['y = x^n,  n = ' num2str( n(idx)) ])
    drawnow
    frame = getframe(1);
    im{idx} = frame2im(frame);
end
%close;

% figure;
% for idx = 1:nImages
%     subplot(3,3,idx)
%     imshow(im{idx});
% end
filename = 'testAnimated.gif'; % Specify the output file name
for idx = 1:nImages
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
    end
end