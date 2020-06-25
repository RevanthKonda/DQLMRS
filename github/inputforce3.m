function u = inputforce3(n,e,r1,r,d,p,q,pd,qd,po,ro,do,A,list,co1)

    numob = length(ro);
    B = zeros(n,numob);
    u = zeros(n,2);
    uo = zeros(n,2);
    
    poso = zeros(n,2,numob);
    velo = zeros(n,2,numob);
    
    for i = 1:numob
        
        [poso(:,:,i), velo(:,:,i), B(:,i), ~] = oadjacency(p,q,po(i,:),n,r1,ro(i));
    
    end
    
    
    for i = 1:n
       
        neigh = list{i};
        num = size(neigh);
        num = num(1,2);
        pos = zeros(num,2);
        vel = zeros(num,2);
       
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
     
     cm1 = 1.1;
     cm2 = 2*sqrt(cm1);
    
     u(i,:) = c1*posinput + c2*velinput + cm1*(pd - p(i,:)) + cm2*(qd - q(i,:));
     
     
   co2 = 2*sqrt(co1);
     
     for point = 1:numob
     
        if B(i,point) > 0
            
            zo = sigmanorm(p(i,:),poso(i,:,point),e);
            doalpha = (sqrt(1 + e*do^2) - 1)/e;
            r1oalpha = (sqrt(1 + e*r1^2) - 1)/e;
            
            lo = action(zo,r1oalpha,doalpha);
            uo(i,:) = co1*lo*normdiff(p(i,:),poso(i,:,point),e) + co2*B(i,1)*(velo(i,:,point) - q(i,:));
            
        end
        
        u(i,:) = u(i,:) + uo(i,:);
       
     end
     
    end


end