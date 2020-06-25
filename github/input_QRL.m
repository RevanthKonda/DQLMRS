function u = input_QRL(n,e,r1,r,d,p,q,act,po,ro,pp,qp,rp,do,A,list) 
 
    u = zeros(n,2);
    numob = length(ro);
    nump = length(rp);
    B = zeros(n,numob);
    Bp = zeros(n,nump);
    uo = zeros(n,2);
    up = zeros(n,2);
    
    poso = zeros(n,2,numob);
    velo = zeros(n,2,numob);
    
    posp = zeros(n,2,nump);
    velp = zeros(n,2,nump);
    
    for i = 1:numob
        
        [poso(:,:,i), velo(:,:,i), B(:,i)] = oadjacency(p,q,po(i,:),n,r1,ro(i));
    
    end
    
    for i = 1:nump
        
        [posp(:,:,i), velp(:,:,i), Bp(:,i), ~,~] = padjacency(p,q,pp(i,:),qp(i,:),n,r1,rp(i),list);
    
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
     
     c1 = 300;
     c2 = 2*sqrt(c1);
     
     cm1 = 20;
     cm2 = 2*sqrt(cm1);
     
    
     u(i,:) = c1*posinput + c2*velinput + cm1*(act(i,:) - p(i,:)) + cm2*(- q(i,:));
     
     co1 = 1500;
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
     
     cp1 = 3*co1;
     cp2 = 2*sqrt(cp1);
     
      for point = 1:nump
     
        if Bp(i,point) > 0
            
            zp = sigmanorm(p(i,:),posp(i,:,point),e);
            dpalpha = (sqrt(1 + e*do^2) - 1)/e;
            r1palpha = (sqrt(1 + e*r1^2) - 1)/e;
            
            lp = action(zp,r1palpha,dpalpha);
            up(i,:) = cp1*lp*normdiff(p(i,:),posp(i,:,point),e) + cp2*Bp(i,1)*(velp(i,:,point) - q(i,:));
            
        end
        
        u(i,:) = u(i,:) + up(i,:);
       
     end
     

       
    end


end