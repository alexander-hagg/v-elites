disp("Running MAP-elites on npoly problem");
addpath(genpath('.'));
numPoints = 8;
d = domain_NPoly(numPoints*2);
p = defaultParamSet(4);

numInitSamples = 500;

%
sobSequence         = scramble(sobolset(d.dof,'Skip',1e3),'MatousekAffineOwen');
sobPoint            = 1;
initSamples         = (2*sobSequence(sobPoint:(sobPoint+numInitSamples)-1,:))-1;
[fitness, values]   = d.fitfun(initSamples);

obsMap = createMap(d.featureRes, d.dof);
[replaced, replacement] = nicheCompete(initSamples, fitness, values, obsMap, d);
obsMap = updateMap(replaced,replacement,obsMap,fitness,initSamples,[],[]);

[acqMap, percImproved, percValid, h, allMaps] = mapElites(d.fitfun,obsMap,p,d);

%% Visualization
figure(3);
viewMap(acqMap.fitness, d, acqMap.edges,'flip');
colormap(parula(16));
caxis([1 10]);  %REMOVE THIS
title(['Original Fitness Gen ' int2str(iGen) '/' int2str(p.nGens)]);

figure(4); viewDomainMap(acqMap,d);
title(['Generation: ' int2str(iGen)]);
grid on;
