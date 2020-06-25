function s = unevensigmoid(z)

    a = 5;
    b = 5;
    c = sqrt((a - b)^2)/sqrt(4*a*b); 
    
    s = ((a + b)*sigmoid(z + c) + (a - b))/2;
    
end