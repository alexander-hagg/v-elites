function [fitness,values] = objective(solutions)
%OBJECTIVE Random fitness

fullGenomes = [solutions,solutions(:,1:2)];

for i=1:size(fullGenomes,1)
    pgon = polyshape(fullGenomes(i,1:2:end),fullGenomes(i,2:2:end));
    fitness(i) = pgon.NumRegions;             
end

%fitness = rand(size(solutions,1),1);
fitness = fitness';
values{1} = rand(size(solutions,1),1);

end

