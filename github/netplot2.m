function netplot2(px,py,m,n)

p = zeros(n,m);

for i = 1:n
   for j = 1:m
      
       p(i,j) = norm([px(i,j),py(i,j)]);
       
   end
end

for i = 1:n
   
    plot(1:m,p(i,:));
    hold on;

end
end