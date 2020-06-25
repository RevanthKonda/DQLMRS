function x = sigmanorm(qi, qj, e)

Z = qj - qi;
n = norm(Z);
x = (sqrt(1 + e*n^2) - 1)/e;

end