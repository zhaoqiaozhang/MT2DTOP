function [K]=CalcTE(w,ny,nz,Nd,Ne,YZ,Me,sigma)
eps=1/(36*pi)*1e-9 ;miu=4*pi*1e-7;
K=sparse(Nd,Nd);
for ie=1:Ne        
    tau=1/(sqrt(-1)*w*miu);       
    lambda=sigma(ie)-sqrt(-1)*w*eps;               
    k=sqrt(-(sqrt(-1)*w*miu*sigma(ie)));         
    [Ke]=CalcKe(ie,tau,lambda,k,ny,nz,YZ,Me,Ne) ;         
     
        for i=1:4;                 
            ni=Me(i,ie);
            for j=1:4;
                nj=Me(j,ie);
                K(ni,nj)=K(ni,nj)+Ke(i,j);
            end
        end
        
end
