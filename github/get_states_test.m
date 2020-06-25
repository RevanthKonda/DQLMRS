function state = get_states_test(n,direction)

    state = zeros(n,2);
    s = size(direction);
    
    if length(s) <= 2
        num = 1;
    else
        num = s(3);
    end
    
    
    for j = 1:num
        if isequal(direction(:,:,j),zeros(15,2)) ~= 1
            for i = 1:n

                state(i,:) = direction(i,:,j)/norm(direction(i,:,j));

            end
        end
    end

end