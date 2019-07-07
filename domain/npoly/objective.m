function [fitness,values] = objective(solutions)
%OBJECTIVE Random fitness

fullGenomes = [solutions,solutions(:,1:2)];

for i=1:size(fullGenomes,1)
    xCoords = fullGenomes(i,1:2:end); 
    yCoords = fullGenomes(i,2:2:end);
    %k = convhull(xCoords,yCoords);
    pgon{i} = polyshape(xCoords,yCoords);
    
    fitness(i) = pgon{i}.NumRegions + pgon{i}.NumHoles;
end

fitness = 1-(fitness'./10);
fitness(fitness<0) = 0;
values{1} = pgon;

end

