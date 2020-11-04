function [K,P]=updateTopBoundary(K,ny,Nd)
P=zeros(size(K,1),1);
for i=1:ny+1
    K(i,i)=1e10;
    P(i)=1e10;
end
end