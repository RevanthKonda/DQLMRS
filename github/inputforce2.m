function u = inputforce2(n,e,r,d,p,q,pd,qd,A,list)

    u = zeros(n,2);
    
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
       
    end


end