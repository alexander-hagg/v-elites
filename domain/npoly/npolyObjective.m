function [fitness,values] = npolyObjective(genomes)
%NPOLYOBJECTIVE 

pgon = getPhenotype(genomes);    
for i=1:length(pgon)
    fitness(i) = pgon{i}.NumRegions + pgon{i}.NumHoles;
end

fitness = 1-(fitness'./10);
fitness(fitness<0) = 0;
values{1} = pgon;

end

