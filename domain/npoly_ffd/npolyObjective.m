function [fitness,values,phenotypes] = npolyObjective(genomes,base)
%NPOLYOBJECTIVE 

values = [];
phenotypes = getPhenotype(genomes,base);    
for i=1:length(phenotypes)
    if phenotypes{i}.NumRegions == 0
        fitness(i) = nan;
    else
        % Symmetry
        vertices = phenotypes{i}.Vertices;
        vertices = vertices(~all(isnan(vertices)'),:);
        a = vertices(1:end/2,:);
        x = -1*(vertices(end/2+1:end,:));
        distances = hypot(a(:,1)-x(:,1),a(:,2)-x(:,2));
        fitness(i) = sum(distances);
    end
end

fitness = 1-(fitness'./5);
fitness(fitness<0) = 0;
fitness(fitness>1) = 1;

end

