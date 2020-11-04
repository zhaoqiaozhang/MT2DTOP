function [K2eij]=Calcf2e(lambda,N,detaJ)
K2eij=zeros(4);
for i=1:4
    for j=1:4
        K2eij(i,j)=lambda*N(i)*N(j)*detaJ;
    end
end
end