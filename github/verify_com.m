function ro = verify_com(pd,pcom)

    n = length(pd);
    check = zeros(n,1);
    dist = pd - pcom;
    
    for i = 1:n
        
        if norm(dist(i,:)) <= 15
            check(i,1) = 1;
        else
            check(i,1) = 0;
        end
        
    end
    
    ro = int16(isequal(check,zeros(n,1)));


end