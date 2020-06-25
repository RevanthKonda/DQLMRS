function rho = bump(z)
    
    h = 0.2;

    if z < h
        rho = 1;
    end
    
    if z > h
        rho = (1 + cos(pi*(z-h)/(1-h)))/2;
    end
    
    if z > 1;
        rho = 0;
    end

end