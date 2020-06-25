function [posp, velp ,Bp ,Bpse, dan, direction] = padjacency2(p,q,po,qo,n,r,ro,connections)

D = zeros(n,1);
Bp = zeros(n,1);
Bpse = zeros(n,1);
posp = zeros(n,2);
velp = zeros(n,2);
direction = zeros(n,2);
%dan = zeros(n,1);

for i = 1:n
        
    
        mu = ro/norm(p(i,:) - po);
        a = (p(i,:) - po)/norm(p(i,:) - po);
        P = 1 - a*transpose(a);
        posp(i,:) = mu*p(i,:) + (1 - mu)*po ;%+ 2*rand(1,2);
        velp(i,:) = mu*P*q(i,:) + (1 - mu)*qo;
        
        D(i,1) = norm(p(i,:) - posp(i,:));
        
        if D(i,1) < r
            
            Bp(i,1) = bump(D(i,1)/r); 
            %dan(i,1) = 1;
   
        end
        
        if D(i,1) < r+30
            
            Bpse(i,1) = 1;
            direction(i,:) = a;
            
        end
        
end

Bpse = consensus3(Bpse,connections);
direction = [consensus3(direction(:,1),connections),consensus3(direction(:,2),connections)];
dan = consensus3(Bp,connections);


end