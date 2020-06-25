function p = consensus3(measurement,connections)

n = length(connections);
it = 50;
v = 0.5;

mi = zeros(n,it);
mi(:,1) = measurement;

for i = 2:it       
    for j = 1:n

       neigh = connections{j};
       k = length(neigh);
       mj = 0;
       z = 0;

       for l = 1:k 
           if mi(neigh(l),i-1)~=0

                mj = mj + mi(neigh(l),i-1);

           else

               z = z + 1;

           end
       end

       k = k - z;
        
           if k == 0

               mi(j,i) = mi(j,i-1);

           else 
               if mi(j,i-1) ~= 0

                   mi(j,i) = v*mi(j,i-1)  +   (1 - v)*mj/k;

               else

                   mi(j,i) = mj/k;

               end

           end
           


    end
end

p = mi(:,it);
                
end
