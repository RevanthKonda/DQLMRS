function obstacle(p,r)

t = 0:0.1:2.2*pi;
num = length(r);

    for i = 1:num

        fill(r(i)*cos(t) + p(i,1),r(i)*sin(t) + p(i,2),'k')
        %plot(r(i)*cos(t) + p(i,1),r(i)*sin(t) + p(i,2),'.','MarkerEdgeColor','k')
        hold on;
        
    end 

end