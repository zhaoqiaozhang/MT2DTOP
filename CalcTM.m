function [K]=CalcTM(w,ny,nz,Nd,Ne,YZ,Me,sigma,Nair);
eps=1/(36*pi)*1e-9 ;miu=4*pi*1e-7;

Ns=Nair*(ny+1);
K=sparse(Nd,Nd);
for e=1:Ne                 
    tau=1/(sigma(e)-sqrt(-1)*w*eps);
    lambda=sqrt(-1)*w*miu; 
    k=sqrt(-sqrt(-1)*w*miu*sigma(e));          
    [Ke]=CalcKe(e,tau,lambda,k,ny,nz,YZ,Me,Ne) ;     
        
        for i=1:4;                 
            ni=Me(i,e);
            for j=1:4;
                nj=Me(j,e);
                K(ni,nj)=K(ni,nj)+Ke(i,j);
            end
        end
end