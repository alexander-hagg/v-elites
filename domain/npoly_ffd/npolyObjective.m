function [fitness,values] = npolyObjective(genomes,base)
%NPOLYOBJECTIVE 

pgon = getPhenotype(genomes,base);    
for i=1:length(pgon)
    if pgon{i}.NumRegions == 0
        fitness(i) = nan;
    else
        fitness(i) = pgon{i}.NumRegions + pgon{i}.NumHoles;
    end
end

fitness = 1-(fitness'./10);
fitness(fitness<0) = 0;
values{1} = pgon;

end

