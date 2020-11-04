function [K3eij]=Calcf3e(tau,k,N,l34);  
K3e=zeros(4);
K3eij=zeros(4);    
        for i=3:4
            for j=3:4  
                K3eij(i,j)=tau*k*N(i)*N(j)*l34/2;
            end         
        end   
end