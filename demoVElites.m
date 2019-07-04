disp("Running V-elites on npoly problem");
addpath(genpath('.'));

%% Load configuration of domain and V-Elites
numPoints = 6;
d = domain_NPoly(numPoints*2);
p = defaultParamSet(4);

sobSequence         = scramble(sobolset(d.dof,'Skip',1e3),'MatousekAffineOwen');
sobPoint            = 1;
initSamples         = (2*sobSequence(sobPoint:(sobPoint+p.numInitSamples)-1,:))-1;
[fitness, values]   = d.fitfun(initSamples);

%
obsMap                  = createMap(d.dof, p.maxBins, p.competeDistance);
[replaced, replacement, features] = nicheCompete(initSamples, fitness, values, obsMap, d);
obsMap = updateMap(replaced,replacement,obsMap,fitness,initSamples,features);
imgHandle = viewMap(obsMap.features,d,1);

[acqMap, percImproved, percValid, h, allMaps] = vElites(d.fitfun,obsMap,p,d);

