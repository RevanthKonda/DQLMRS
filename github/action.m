function s = action(z, r, d)


    s = bump(z/r)*unevensigmoid(z - d);


end