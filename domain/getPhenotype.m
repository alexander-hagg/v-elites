function [phenotypes,bitmaps,genomes] = getPhenotype(genomes)
%GETPHENOTYPE Summary of this function goes here
%   Detailed explanation goes here

genomes = [genomes,genomes(:,1:2)];

for x=1:size(genomes,1)
    genome = genomes(x,:);
    if ~isnan(genome(1))
        phenotypes{x} = polyshape(genome(1:2:end),genome(2:2:end));
        bitmaps{x} = poly2mask(genome(1:2:end),genome(2:2:end),256,256);
    end
end

end

