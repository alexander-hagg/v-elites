disp("Running MAP-elites on npoly problem");
addpath(genpath('.'));

%%
numPoints = 16;
d = domain_NPoly(numPoints*2);
p = defaultParamSet(4);

numInitSamples = 2000;

%
sobSequence         = scramble(sobolset(d.dof,'Skip',1e3),'MatousekAffineOwen');
sobPoint            = 1;
%initSamples         = (2*sobSequence(sobPoint:(sobPoint+numInitSamples)-1,:))-1;
initSamples         = (sobSequence(sobPoint:(sobPoint+numInitSamples)-1,:))-0.5;
[fitness, values]   = d.fitfun(initSamples);

obsMap = createMap(d.featureRes, d.dof);
[replaced, replacement] = nicheCompete(initSamples, fitness, values, obsMap, d);
obsMap = updateMap(replaced,replacement,obsMap,fitness,initSamples,[],[]);
[acqMap, percImproved, percValid, h, allMaps] = mapElites(d.fitfun,obsMap,p,d);



%%
orgGenomes = reshape(acqMap.genes,size(acqMap.genes,1)*size(acqMap.genes,2),[]);
genomes = orgGenomes(~any(isnan(orgGenomes')),:);
% include initial samples
genomes = [genomes;initSamples];
[phenotypes,bitmaps] = getPhenotype(genomes);


%[classification,stats] = extractClasses(genomes);

[simX, mapping]  = compute_mapping(genomes, 'tSNE', 2);
K = 20;
[labels, C] = kmedoids(simX, K);




%% Visualization
figure(3);
viewMap(acqMap.fitness, d, acqMap.edges,'flip');
colormap(parula(16));
caxis([1 10]);  %REMOVE THIS
title(['Original Fitness Gen ' int2str(p.nGens) '/' int2str(p.nGens)]);

figure(4);
cmap = hsv(length(unique(labels)));
scatter(simX(:,1),simX(:,2),16,cmap(labels,:),'filled');

figure(5);
classMap = nan(size(acqMap.fitness));
classMap(~any(isnan(orgGenomes'))) = labels(1:end-numInitSamples);
viewMap(classMap, d, acqMap.edges,'flip');
colormap(hsv(K));
title(['Class Map Gen ' int2str(p.nGens) '/' int2str(p.nGens)]);

figure(6); viewDomainMap(acqMap,d);
title(['Generation: ' int2str(p.nGens)]);
grid on;

%% Plot shapes in similarity space
% Move shapes
movedPhenotypes = phenotypes;
scaleFactor = 1.5;
for i=1:length(phenotypes)
    movedPhenotypes{i}.Vertices = movedPhenotypes{i}.Vertices + simX(i,:)*scaleFactor;
end

figure(7);
h = plotShapes(movedPhenotypes,numInitSamples);
legend([h(1),h(2)],'initial samples','elites')

%% Voronoi
values{1} = phenotypes(1:end-numInitSamples);
featureValues = categorize(genomes(1:end-numInitSamples,:), values , d);
voronoi(featureValues(:,1),featureValues(:,2))
%[V,C] = voronoin()
