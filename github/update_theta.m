function theta = update_theta(theta_prev,states_prev,rewards,act_index,max_value,connections,num_rbf)
    
    alpha = 0.5;
    gamma = 0.8;
    w = 0.2;
    
    n = length(states_prev);
    theta = theta_prev;
    num = num_rbf*4;

    for i = 1:n
        
        O = phi(states_prev(i,:),act_index(i));
        Q_rbf = O*theta_prev(:,i);
        theta_prev(:,i) = theta_prev(:,i) + alpha*(rewards(i) + gamma*max_value(i) - Q_rbf)*O';
        
    end
    
    for i = 1:n
        
        if ~isempty(connections{i})

            Q_neigh = zeros(num,1);

            for j = 1:length(connections{i})

                k = connections{i}(j);
                Q_neigh = Q_neigh + theta_prev(:,k);

            end

            theta(:,i) = w*theta_prev(:,i) + (1-w)*Q_neigh./length(connections{i});
        else
            
            theta(:,i) = theta_prev(:,i);
            
        end
        
    end
         
end