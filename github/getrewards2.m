function r = getrewards2(connections,n,dan)

r = zeros(n,1);

for i = 1:n
    
    if dan(i) == 0
        
        r(i) = length(connections{i});
    
        if r(i) > 6
        
            r(i) = 6;
        
        end
        
    else
        
        r(i) = dan(i)*(-5);

        
    end
end
    
end