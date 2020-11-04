
figure(21)
for i=1:size(Yco,1)-1
    for j=1:size(Zco,2)-1
        line([Yco(i,j) Yco(i+1,j)],[Zco(i,j) Zco(i+1,j)])
        line([Yco(i,j) Yco(i,j+1)],[Zco(i,j) Zco(i,j+1)])
    end
end

axis equal
set(gca,'YDir','reverse')
% xlim([-3000 3000]);ylim([-1000 2000])
% line([0 450],[0 450])

% % 
for i=1:size(YZrho,1)-1
    for j=1:size(YZrho,2)-1

        if YZrho(i,j)==1e10
        patch([Yco(i,j) Yco(i+1,j) Yco(i+1,j+1) Yco(i,j+1)],[Zco(i,j) Zco(i+1,j) Zco(i+1,j+1) Zco(i,j+1)],'r')
        else
        patch([Yco(i,j) Yco(i+1,j) Yco(i+1,j+1) Yco(i,j+1)],[Zco(i,j) Zco(i+1,j) Zco(i+1,j+1) Zco(i,j+1)],'y')    
        end

    end
end
axis equal
set(gca,'YDir','reverse')
xlim([-1200 1200]);ylim([-500 1000]);





