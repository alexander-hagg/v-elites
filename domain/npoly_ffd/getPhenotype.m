function [phenotypes,genomes] = getPhenotype(genomes,base)
%GETPHENOTYPE Summary of this function goes here
%   Detailed explanation goes here


for x=1:size(genomes,1)
    genome = genomes(x,:);
    if ~isnan(genome(1))
        theta = base(1,:) + 0.5*genome(1:size(base,2));
        rho = base(2,:) + genome(size(base,2)+1:end);
        [xCoords,yCoords] = pol2cart(theta,rho); 
        phenotypes{x} = polyshape(xCoords,yCoords);   
    else
        phenotypes{x} = nan;
    end
end

end

