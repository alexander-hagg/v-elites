function viewDomainSimspace(obsMap,d)
%VIEWDOMAINMAP view solutions in map space
%   Detailed explanation goes here

if ndims(obsMap.genes)==2
    genomes = obsMap.genes;
else
    genomes = reshape(obsMap.genes,size(obsMap.genes,1)*size(obsMap.genes,2),[]);
end
fullGenomes = [genomes,genomes(:,1:2)];

pcaDims = 1000; perplexity = 30; alg = 'svd'; theta = .2; % Appropriate values for theta are between 0.1 and 0.7 (quality/speed trade off)
reducedGenotypes = fast_tsne(fullGenomes, 2, min(pcaDims,size(fullGenomes,2)), perplexity, theta, alg);
coordinates = reducedGenotypes;

hold off;

mapScale = 10;
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
%axis([0 mapScale 0 mapScale]);
%xlabel(d.featureLabels{1});
%ylabel(d.featureLabels{2});

