function [A,A1] = adjacency(p,n,r)

D = zeros(n,n);
A = zeros(n,n);
A1 = zeros(n,n);

for i = 1:n
    for j = 1:n
        
        D(i,j) = norm(p(i,:) - p(j,:));
        
        if D(i,j) < r
            
            A(i,j) = bump(D(i,j)/r);
            A1(i,j) = 1;
            
        end
        
        if i == j
           
            A(i,j) = 0;
            A1(i,j) = 0;
            
        end
        
    end
end

end