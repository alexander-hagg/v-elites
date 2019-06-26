disp("Running MAP-elites on npoly problem");
addpath(genpath('.'));
numPoints = 5;
d = domain_NPoly(numPoints*2);
p = defaultParamSet(4);

p.nChildren = 10;

%
sobSequence         = scramble(sobolset(d.dof,'Skip',1e3),'MatousekAffineOwen');
sobPoint            = 1;
initSamples         = (2*sobSequence(sobPoint:(sobPoint+p.nChildren)-1,:))-1;
fitness             = d.fitfun(initSamples);

obsMap = createMap(d.featureRes, d.dof);
[replaced, replacement] = nicheCompete(initSamples, fitness, [], obsMap, d);
obsMap = updateMap(replaced,replacement,obsMap,fitness,initSamples,[],[]);

%figure(9); viewDomainMap(obsMap,d);

[acqMap, percImproved, percValid, h, allMaps] = mapElites(d.fitfun,obsMap,p,d); 


