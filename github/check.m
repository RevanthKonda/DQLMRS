function A = check(Q)

    l = max(Q,[],'all');
    
    if l > 10000
        
        A = 0.01*Q;
        
    else
        
        A = Q;
        
    end

end