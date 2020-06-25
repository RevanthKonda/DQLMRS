function netplot(px,py,n)

for i = 1:n
   
    plot(px(i,:),py(i,:),'k','Linewidth',2);
    hold on;

end
end