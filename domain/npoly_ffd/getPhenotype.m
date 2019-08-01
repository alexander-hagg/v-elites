function [phenotypes,genomes] = getPhenotype(genomes,base)
%GETPHENOTYPE Summary of this function goes here
%   Detailed explanation goes here


for x=1:size(genomes,1)
    genome = genomes(x,:);
    if ~isnan(genome(1))
        theta = base(1,:) + 0.2*genome(1:size(base,2));
        rho = base(2,:) + genome(size(base,2)+1:end);
        [xCoords,yCoords] = pol2cart(theta,rho); 
        xCoords(end+1) = xCoords(1);
        yCoords(end+1) = yCoords(1);
        phenotypes{x} = polyshape(xCoords,yCoords);        
    end
end

end

