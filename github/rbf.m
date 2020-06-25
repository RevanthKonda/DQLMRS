function phi = rbf(c,p,sigma)

    l = norm(c - p);
    a = (l/(sqrt(2)*sigma))^2;
    phi = exp(-a);

end