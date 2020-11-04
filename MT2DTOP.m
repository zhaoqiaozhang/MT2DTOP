%% zhaoqiaozhang@sina.com
clc
clear
tic
%parameter constant
eps=1/(36*pi)*1e-9 ;miu=4*pi*1e-7;

% f=logspace(-1,3,21);
f=[0.1 0.15 0.25 0.4 0.7 1 1.5 2 4 7 10 16 26 40 63 100 160 250 400 630 1000];

%load model
model_vally

[Nd,Ne,YZ,Me,Yco,Zco]=GenarateYZ(ny,nz,Y,Z,Eleva,Nair) ; 
wange
sigma=zeros(Ne,1);
for iy=1:ny;
    for iz=1:nz;
        e=(iz-1)*ny+iy;
        sigma(e)=1/YZrho(iz,iy);
    end
end


tol=1e-15;
maxit=1000;
for ii=1:length(f);  
    w=2*pi*f(ii); 
    %%
    %TE mode
    [K]=CalcTE(w,ny,nz,Nd,Ne,YZ,Me,sigma);
    [K,P]=updateTopBoundary(K,ny,Nd);
    [U,err,iter] = ilubicgstab(K, P,maxit,tol);
    disp(['TE-' num2str(f(ii))  'Hz  -' num2str(ii) '  -' num2str(err(end)) '  -' num2str(iter)])
    E(ii,:)=U;   
    %% 
    %TM mode
    [K]=CalcTM(w,ny,nz,Nd,Ne,YZ,Me,sigma,Nair);
    [K,P]=updateTopBoundary(K,ny,Nd);
    [U,err,iter] = ilubicgstab(K, P,maxit,tol);
    disp(['TM-' num2str(f(ii))  'Hz  -' num2str(ii) '  -' num2str(err(end)) '  -' num2str(iter)])
    H(ii,:)=U;   
end

for nf=1:size(f,2)
    for iy=1:ny+1   
        for iz=1:nz+1        
            h=(ny+1)*(iz-1)+iy;     
            Ex1(iz,iy,nf)=E(15,h);   
        end        
    end
    
    for iy=1:ny+1  
        for iz=1:nz+1        
            h=(ny+1)*(iz-1)+iy;     
            Hx1(iz,iy,nf)=H(15,h);    
        end
    end
end





% Post processing
node=Nair*(ny+1)+1:(Nair+1)*(ny+1);
loop=0;
for j=1:length(node)
    loop=loop+1;
    %TE
    u1=E(:,node(j));                                                   
    u2=E(:,node(j)+(ny+1));
    u3=E(:,node(j)+2*(ny+1));
    u4=E(:,node(j)+3*(ny+1));
    l=(YZ(2,node(j)+3*(ny+1))-YZ(2,node(j)));                                    
    du=1/(2*l)*(-11*u1+18*u2-9*u3+2*u4);
    Hy=du./(sqrt(-1)*(2*pi*f')*miu);
    aZxy(:,loop)=(u1./Hy);                                 
    arhoxy(:,loop)=1./((2*pi*f')*miu).*abs(aZxy(:,loop)).^2; 
    faixy(:,loop)=-180/pi*atan(imag(aZxy(:,loop))./real(aZxy(:,loop)));
%TM
    u1=H(:,node(j));                                                   
    u2=H(:,node(j)+(ny+1));
    u3=H(:,node(j)+2*(ny+1));
    u4=H(:,node(j)+3*(ny+1));
    l=(YZ(2,node(j)+3*(ny+1))-YZ(2,node(j))); 
    du=1/(2*l)*(-11*u1+18*u2-9*u3+2*u4);
    sigma1=1/rho(2);
    Ey=du/sigma1;
    aZyx(:,loop)=1*(Ey./u1);
    arhoyx(:,loop)=1./((2*pi*f')*miu).*abs(aZyx(:,loop)).^2;
    faiyx(:,loop)=-180/pi*atan(imag(aZyx(:,loop))./real(aZyx(:,loop)));   
    %%    
rhoxy(:,loop)=arhoxy(:,loop).*((pi/2/faixy(:,loop)-1)');
Dxy(:,loop)=sqrt(arhoxy(:,loop)./(2*pi*f')/miu)+Eleva(loop);

rhoyx(:,loop)=arhoyx(:,loop).*((pi/2/faiyx(:,loop)-1)');
Dyx(:,loop)=sqrt(arhoyx(:,loop)./(2*pi*f')/miu)+Eleva(loop);
end


[YY,ff]=meshgrid(Y,f);
ZZco=(Zco(1:end-1,:)+Zco(2:end,:))/2;
YYco=Yco(1:end-1,:);

%%»­Í¼
imageMT

