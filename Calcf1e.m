function [K1eij]=Calcf1e(tau,dN_dy,dN_dz,detJ)  
K1eij=zeros(4);
for i=1:4
    for j=1:4
        K1eij(i,j)=tau*(dN_dy(i).*dN_dy(j)+dN_dz(i).*dN_dz(j))./detJ;
    end
end
 end