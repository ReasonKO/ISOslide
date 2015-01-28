%angV = angV(Z)
%angV = angV(re,im)
%Угол направления вектора.

function angV = angV(re,im)
if (nargin==1)
    im=re(2);
    re=re(1);
end

%AZI Summary of this function goes here
%   Detailed explanation goes here
% if norm(Z)==0 
%     angV=0;
%     return;
% end
%re=Z(1);
%im=Z(2);
angV = acos(re./sqrt((re).^2+(im).^2));
%     if(sign(re)~=sign(im))
%         alpha=-alpha;
%     end
%     alpha
%     if (re<0)
%         alpha=alpha+pi*sign(im);
%     end
angV(im<0)=-angV(im<0);
angV(and(re==0,im==0))=0;
end