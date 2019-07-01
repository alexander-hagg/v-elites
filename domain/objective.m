function [fitness,values] = objective(solutions)
%OBJECTIVE Random fitness

fullGenomes = [solutions,solutions(:,1:2)];

for i=1:size(fullGenomes,1)
    xCoords = fullGenomes(i,1:2:end); 
    yCoords = fullGenomes(i,2:2:end);
    %k = convhull(xCoords,yCoords);
    %pgon{i} = polyshape(xCoords(k),yCoords(k));
    pgon{i} = polyshape(xCoords,yCoords);
    
    fitness(i) = pgon{i}.NumRegions + pgon{i}.NumHoles;
end

fitness = fitness';
values{1} = pgon;

end

