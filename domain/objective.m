function [fitness,values] = objective(solutions)
%OBJECTIVE Random fitness

fullGenomes = [solutions,solutions(:,1:2)];

for i=1:size(fullGenomes,1)
    %pgon{i} = polyshape(fullGenomes(i,1:2:end),fullGenomes(i,2:2:end));
    %pgon{i} = convhull(pgon{i});
    xCoords = fullGenomes(i,1:2:end); 
    yCoords = fullGenomes(i,2:2:end);
    k = convhull(xCoords,yCoords);
    pgon{i} = polyshape(xCoords(k),yCoords(k));
    fitness(i) = pgon{i}.NumRegions + pgon{i}.NumHoles;
end

fitness = fitness';
values{1} = pgon;

end

