function d = normdiff(qi,qj,e)


    d = (qj - qi)/sqrt(1 + e*norm(qj - qi)^2);


end