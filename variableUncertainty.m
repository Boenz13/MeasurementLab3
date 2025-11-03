function [uncV] = variableUncertainty(V)

    n = length(V);
    stdV = std(V, 0); 
    uncV = stdV / sqrt(n);

end
