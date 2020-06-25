function [act, act_index, max_value] = action_choice(list,n,states,theta)

    epsilon = rand(1);
    
    for i = 1:n
       
        if epsilon < 0.00
            
            act_index(i) = round(4 - 3.5*rand(1));
            act(i,:) = list{act_index(i)};
        
        else
            
            state = states(i,:);
            
            Q = zeros(4,1);

            Q(1) = phi(state,1)*theta(:,i);
            Q(2) = phi(state,2)*theta(:,i);
            Q(3) = phi(state,3)*theta(:,i);
            Q(4) = phi(state,4)*theta(:,i);

            
            [max_value(i),act_index(i)] = max(Q);
            act(i,:) = list{act_index(i)};
            %act(i,:) = list(act_index(i),:);

        end

    end
    
    
end