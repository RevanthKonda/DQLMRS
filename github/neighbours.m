function list = neighbours(A,n)

for i = 1:n
    
    b = [];
    k = 0;
    
    for j = 1:n
       
        if A(i,j) > 0
        
            for k = k + 1
                
                b(k) = j;
                
            end
            
        end  
        
       list{i,1}  = b;
       
    end
end

end