function connect(p,poso,B,n)

for i = 1:n
    
    if B(i,1) > 0
        
        line([p(i,1),poso(i,1)],[p(i,2),poso(i,2)],'color','blue');
        hold on;
        
    end
    
end
end