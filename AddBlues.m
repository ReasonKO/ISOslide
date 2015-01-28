function Blues = AddBlues(X,Y,N,Blues,close)
if (nargin==4)
    close=true;
end

Start=find(1-Blues(:,1),1);
if close
    Blues(Start:(Start+N-1),2:3)=repmat(X,[N,1])+(0:(N-1))'/(N-1)*(Y-X);
    Blues(Start:(Start+N-1),1)=1;
else
    Blues(Start:(Start+N-1),2:3)=repmat(X,[N,1])+(1:N)'/N*(Y-X);
    Blues(Start:(Start+N-1),1)=1;
end
end

