function [poso, velo ,B] = oadjacency(p,q,po,n,r,ro)

D = zeros(n,1);
B = zeros(n,1);
B1 = zeros(n,1);
poso = zeros(n,2);
velo = zeros(n,2);

for i = 1:n
        
    
        mu = ro/norm(p(i,:) - po);
        a = (p(i,:) - po)/norm(p(i,:) - po);
        P = 1 - a*transpose(a);
        poso(i,:) = mu*p(i,:) + (1 - mu)*po;
        velo(i,:) = mu*P*q(i,:);
        
        D(i,1) = norm(p(i,:) - poso(i,:));
        
        if D(i,1) < r
            
            B(i,1) = bump(D(i,1)/r);
            
        end
        
        
end

end