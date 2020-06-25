function p = phi(state,action_index)

    len = length(state);
    p = zeros(1,len*4);
    a = zeros(1,len);

    for i = 1:len

        a(i) = state(i);
    
    end

    p((action_index-1)*len + 1 : (action_index-1)*len + len) = a;  
   
end



