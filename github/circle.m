function circle(p,n,r)


theta = 0:0.01:2*pi;
x = r.*cos(theta);
y = r.*sin(theta);

for i = 1:n
   
       plot(x + p(i,1),y + p(i,2),'g');
       hold on;
    
end
 
hold on;


end