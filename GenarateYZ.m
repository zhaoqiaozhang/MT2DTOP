function [Nd,Ne,YZ,Me,Yco,Zco]=GenarateYZ(ny,nz,Y,Z,Eleva,Nair)
Nd=(ny+1)*(nz+1);
Ne=ny*nz;
YZ=zeros(2,nz);

for iy=1:ny+1;
    for iz=1:1;
        h=(ny+1)*(iz-1)+iy;
        YZ(1,h)=Y(iy);
        YZ(2,h)=Z(1)-2000;  
    end
end
for iy=1:ny+1;
    for iz=nz+1:nz+1; 
        h=(ny+1)*(iz-1)+iy;       
        YZ(1,h)=Y(iy);
        YZ(2,h)=Z(nz+1)+2000;  
    end
end

% %vally
% for iy=1:ny+1;
%     for iz=2:nz;
%         h=(ny+1)*(iz-1)+iy;
%         YZ(1,h)=Y(iy);
%         YZ(2,h)=Z(iz);
%         Gc(iy)=Eleva(iy)-Z(Nair+1); 
%         YZ(2,h)=YZ(2,h)-Gc(iy) ;
%     end
% end

%Hill
for iy=1:ny+1;
    for iz=2:nz;
        h=(ny+1)*(iz-1)+iy;
        YZ(1,h)=Y(iy);
        YZ(2,h)=Z(iz);
        Gc(iy)=Eleva(iy)-Z(Nair+1); 
        YZ(2,h)=YZ(2,h)+Gc(iy) ;
    end
end

Me=zeros(4,Ne);
for iy=1:ny;
    for iz=1:nz;
        e=(iz-1)*ny+iy;
        N1=(iz-1)*(ny+1)+iy;
        Me(1,e)=N1;
        Me(2,e)=N1+1;
        Me(3,e)=N1+ny+2;
        Me(4,e)=N1+ny+1;
    end
end

for iy=1:ny+1
    for iz=1:nz+1
        h=(ny+1)*(iz-1)+iy;
       Yco(iz,iy)=Y(iy);
       Zco(iz,iy)=YZ(2,h);
    end
end




