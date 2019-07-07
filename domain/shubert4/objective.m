function [scores,values] = objective(x)
%OBJECTIVE % Computes the value of the Drop-Wave benchmark function.
% SCORES = DROPWAVEFCN(X) computes the value of the Drop-Wave function at 
% point X. DROPWAVEFCN accepts a matrix of size M-by-2 and returns a  
% vetor SCORES of size M-by-1 in which each row contains the function value 
% for the corresponding row of X.
% For more information please visit: 
% 
% Author: Mazhar Ansari Ardeh
% Please forward any comments or bug reports to mazhar.ansari.ardeh at
% Google's e-mail service or feel free to kindly modify the repository.

    n = size(x, 2);
    
    scores = 0;
    for i = 1:n
        for j = 1:5
            scores = scores + j * cos(((j + 1) * x(:, i)) + j);
        end
    end
    scores = (scores+25)/50;
    values = x;
end

