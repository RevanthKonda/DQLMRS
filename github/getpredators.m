function n = getpredators(Bpse)    
    
    n = 0;
    
    for i = 1:length(Bpse)

        if Bpse(i) ~= 0

           n = n+1;

        end

    end

end