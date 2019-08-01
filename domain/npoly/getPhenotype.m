function [phenotypes,genomes] = getPhenotype(genomes)
%GETPHENOTYPE Summary of this function goes here
%   Detailed explanation goes here

genomes = [genomes,genomes(:,1:2)];

for x=1:size(genomes,1)
    genome = genomes(x,:);
    if ~isnan(genome(1))
        xCoords = genome(1:2:end); 
        yCoords = genome(2:2:end);
        phenotypes{x} = polyshape(xCoords,yCoords);
    end
end

end

