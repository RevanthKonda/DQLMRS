function center = coordinates(n,max)

    center = zeros(1,n);
    del = round(max/n , 1);
    
    for i = 2:n
       
        center(i) = center(i-1) + del;
        
    end

end