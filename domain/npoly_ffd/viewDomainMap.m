function viewDomainMap(obsMap,d)
%VIEWDOMAINMAP view solutions in map space
%   Detailed explanation goes here

if ndims(obsMap.genes)==2
    genomes = obsMap.genes;
    coordinates = obsMap.features;
else
    genomes = reshape(obsMap.genes,size(obsMap.genes,1)*size(obsMap.genes,2),[]);
    coordinates = 'bla';
end

fullGenomes = [genomes,genomes(:,1:2)];

hold off;

mapScale = 200;
for genomeID=1:size(fullGenomes,1)
    genome = fullGenomes(genomeID,:);
    if ~isnan(genome(1))        
        pgon = polyshape(genome(1:2:end),genome(2:2:end));
        pgon.Vertices(:,1) = pgon.Vertices(:,1) + mapScale*coordinates(genomeID,1);
        pgon.Vertices(:,2) = pgon.Vertices(:,2) + mapScale*coordinates(genomeID,2);
        plot(pgon,'FaceColor','green'); hold on;
        %drawnow;
    end
end
axis([0 mapScale 0 mapScale]);
xlabel(d.featureLabels{1});
ylabel(d.featureLabels{2});

