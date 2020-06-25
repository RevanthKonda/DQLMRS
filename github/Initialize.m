function p = Initialize(n,upper_limit,lower_limit)

    p = zeros(n,2);
    
    for i = 1:n
    
        p(i,:) = (upper_limit - lower_limit).*rand(1,2) + lower_limit;  
    
    end

end