function viewDomainMap(obsMap,d)
%VIEWDOMAINMAP Summary of this function goes here
%   Detailed explanation goes here

genomes = reshape(obsMap.genes,size(obsMap.genes,1)*size(obsMap.genes,2),[]);
fullGenomes = [genomes,genomes(:,1:2)];

sizMapX = size(obsMap.genes,1);
sizMapY = size(obsMap.genes,2);

hold off;

for x=1:sizMapX
    for y=1:sizMapY
        genomeID = (y-1)*size(obsMap.genes,2)+x;
        genome = fullGenomes(genomeID,:);
        if ~isnan(genome(1))
            
            xCoords = genome(1:2:end); 
            yCoords = genome(2:2:end);
            k = convhull(xCoords,yCoords);
            pgon = polyshape(xCoords(k),yCoords(k));
    
            %pgon = polyshape(genome(1:2:end),genome(2:2:end));
            
            
            pgon.Vertices(:,1) = pgon.Vertices(:,1) + x*3;
            pgon.Vertices(:,2) = pgon.Vertices(:,2) - y*3;
            plot(pgon,'FaceColor','green'); hold on;
        end
    end
end
axis([0 3*sizMapX+1 -3*sizMapY+1 0]);

