function [fitness,values] = objective(solutions)
%OBJECTIVE Random fitness

fitness = rand(size(solutions,1),1);
values{1} = rand(size(solutions,1),1);

end

