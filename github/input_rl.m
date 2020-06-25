function [u, pd] = input_rl(n,e,r1,r,d,p,q,act,po,ro,do,A,list)

    u = zeros(n,2);
    uo = zeros(n,2);
    [poso, velo, B, ~] = oadjacency(p,q,po,n,r1,ro);
    
    pd = zeros(n,2);    
    
    for i = 1:n
       
        neigh = list{i};
        num = size(neigh);
        num = num(1,2);
        pos = zeros(num,2);
        vel = zeros(num,2);
        
        qd = 0;
        pd(i,:) = po + act(i,:);
       
        for j = 1:num
            
            k = neigh(j);
            
            z = sigmanorm(p(i,:),p(k,:),e);
            l = action(z,r,d);
            
            pos(j,:) = l*normdiff(p(i,:),p(k,:),e);
            vel(j,:) = A(i,k)*(q(k,:) - q(i,:));
            
        end
        
     posinput = sum(pos);
     velinput = sum(vel);
     
     c1 = 30;
     c2 = 2*sqrt(c1);
     
     cm1 = 4.4;
     cm2 = 2*sqrt(cm1);
    
     u(i,:) = c1*posinput + c2*velinput + cm1*(pd(i,:) - p(i,:)) + cm2*(qd - q(i,:));
     
     
     co1 = 2000;
     co2 = 2*sqrt(co1);
     
        if B(i,1) > 0
            
            zo = sigmanorm(p(i,:),poso(i,:),e);
            doalpha = (sqrt(1 + e*do^2) - 1)/e;
            r1oalpha = (sqrt(1 + e*r1^2) - 1)/e;
            
            lo = action(zo,r1oalpha,doalpha);
            uo(i,:) = co1*lo*normdiff(p(i,:),poso(i,:),e) + co2*B(i,1)*(velo(i,:) - q(i,:));
            
        end
        
        u(i,:) = u(i,:) + uo(i,:);
       
    end


end