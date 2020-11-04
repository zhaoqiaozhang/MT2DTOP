figure(1)
subplot(321)
contourf(YY,log(ff),arhoxy,20);
xlim([-2000 2000])
% set(gca,'YDir','reverse'); 
subplot(323)
contourf(YY,log(ff),faixy,20);
xlim([-2000 2000])
% set(gca,'YDir','reverse'); 
subplot(325)
contourf(YY,Dxy,-rhoxy,20);
xlim([-2000 2000]);ylim([-550 2000])
set(gca,'YDir','reverse'); 
xlim([-2000 2000])
set(gca,'YDir','reverse'); 

subplot(322)
contourf(YY,log(ff),arhoyx,20);
xlim([-2000 2000])
% set(gca,'YDir','reverse'); 
subplot(324)
contourf(YY,log(ff),faiyx,20);
xlim([-2000 2000])
% set(gca,'YDir','reverse'); 
subplot(326)
contourf(YY,Dyx,-rhoyx,20);
xlim([-2000 2000]);ylim([-550 2000])
set(gca,'YDir','reverse','FontName','Times New Roman','FontSize',8); 