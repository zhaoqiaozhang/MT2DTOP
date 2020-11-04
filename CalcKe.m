     
function [Ke]=CalcKe(e,tau,lambda,k,ny,nz,YZ,Me,Ne)      

ksai=[-0.5773503 0.5773503];eta=[-0.5773503 0.5773503];
Wl=[1 1];Wm=[1 1];

for l=1:size(ksai,2)
    for m=1:size(eta,2)

%%
y1=YZ(1,Me(1,e));
y2=YZ(1,Me(2,e));
y3=YZ(1,Me(3,e));
y4=YZ(1,Me(4,e));
z1=YZ(2,Me(1,e));
z2=YZ(2,Me(2,e));
z3=YZ(2,Me(3,e));
z4=YZ(2,Me(4,e));
%%
N=[0,0,0,0];
N(1)=1/4*(1-ksai(l))*(1-eta(m));
N(2)=1/4*(1+ksai(l))*(1-eta(m));
N(3)=1/4*(1+ksai(l))*(1+eta(m));
N(4)=1/4*(1-ksai(l))*(1+eta(m));
%%
dN_dksai=[0,0,0,0];
dN_deta=[0,0,0,0];
dN_dksai(1)=-(1/4)*(1-eta(m));
dN_dksai(2)=(1/4)*(1-eta(m));
dN_dksai(3)=(1/4)*(1+eta(m));
dN_dksai(4)=-(1/4)*(1+eta(m));
dN_deta(1)=-(1/4)*(1-ksai(l));
dN_deta(2)=-(1/4)*(1+ksai(l));
dN_deta(3)=(1/4)*(1+ksai(l));
dN_deta(4)=(1/4)*(1-ksai(l));
%%
dN_dy=[0,0,0,0];
dN_dz=[0,0,0,0];
dy_dkesai=dN_dksai(1)*y1+dN_dksai(2)*y2+dN_dksai(3)*y3+dN_dksai(4)*y4;
dy_deta=dN_deta(1)*y1+dN_deta(2)*y2+dN_deta(3)*y3+dN_deta(4)*y4;
dz_dkesai=dN_dksai(1)*z1+dN_dksai(2)*z2+dN_dksai(3)*z3+dN_dksai(4)*z4;
dz_deta=dN_deta(1)*z1+dN_deta(2)*z2+dN_deta(3)*z3+dN_deta(4)*z4;
%%
J=(1/4)*[-(1-eta(m)),(1-eta(m)),1+eta(m),-(1+eta(m));-(1-ksai(l)),-(1+ksai(l)),(1+ksai(l)),1-ksai(l)]*[y1,z1;y2,z2;y3,z3;y4,z4];
detJ=det(J);
for i=1:4
    dN_dy(i)=dy_deta*dN_dksai(i)-dy_dkesai*dN_deta(i);
    dN_dz(i)=dz_dkesai*dN_deta(i)-dz_deta*dN_dksai(i);
end
%%
K1e=zeros(4);
K2e=zeros(4);
K3e=zeros(4);

[K1eij]=Calcf1e(tau,dN_dy,dN_dz,detJ);         
K1e=K1e+K1eij*Wl(l)*Wm(m);
     
[K2eij]=Calcf2e(lambda,N,detJ);          
K2e=K2e+K2eij*Wl(l)*Wm(m);

if  (nz-1)*ny+1<=e&e<=Ne&m==2
    l34=sqrt((y3-y4)^2+(z3-z4)^2);  
    [K3eij]=Calcf3e(tau,k,N,l34);  
     K3e=K3e+K3eij*Wl(l);
end

%         A=XY(1,I4(4,L))-XY(1,I4(1,L));  %A为水平单元宽度        
%         if IY==NY
%            K3E=(tao*k*A/6)*[0,0,0,0
%                             0,2,1,0
%                             0,1,2,0
%                             0,0,0,0];
%         else K3E=0;
%         end
        
        Ke=K1e-K2e+K3e;                   % 生成总体单元系数矩阵 KE
                
    end
end
end