function dir = getdirection(direction)
% 
%     s = size(direction);
%     if length(s) > 2
%         n = s(1,3);
%     else
%         n = 1;
%     end
    
    n = 1;
    dir = zeros(1,2);
    
    for i = 1:n
        mag = abs(direction(:,:,i));
        s = sign(direction(:,:,i));

        if mag(1,1) > mag(1,2)

            if s(1,1) > 0

                dir(i,:) = [1,0];

            else

                dir(i,:) = [-1,0];

            end

        else

            if s(1,2) > 0

                dir(i,:) = [0,1];

            else

                dir(i,:) = [0,-1];

            end

        end
        
        if norm(mag) == 0
           
            dir(i,:) = 0;
            
        end
    end
    
    if nnz(dir) ~= n && norm(dir) ~= 0

        d = dir;
        dummy = 0;

        for i = 1:n

            if dir(i)~=0
                dummy = i;
            end

        end

        dir(1,1) = d(1,dummy);
        dir(1,2) = 0;

    end
  

end