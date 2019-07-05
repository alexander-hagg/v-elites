addpath(genpath('.'));
DOMAIN = 'dropwave'; %npoly
rmpath(genpath('domain')); addpath(['domain/' DOMAIN]);

ALGORITHM = 'vElites';
rmpath('mapElites'); rmpath('vElites'); addpath(ALGORITHM);
%% Load configuration of domain and V-Elites
d = domain;
p = defaultParamSet(4);

sobSequence         = scramble(sobolset(d.dof,'Skip',1e3),'MatousekAffineOwen');
sobPoint            = 1;
initSamples         = (2*sobSequence(sobPoint:(sobPoint+p.numInitSamples)-1,:))-1;
initSamples         = initSamples.*d.ranges;
[fitness, values]   = d.fitfun(initSamples);

obsMap              = createMap(d.dof, p.maxBins, p.competeDistance);
[replaced, replacement, features] = nicheCompete(initSamples, fitness, values, obsMap, d);
obsMap = updateMap(replaced,replacement,obsMap,fitness,initSamples,features);

%[acqMap, percImproved, percValid, h, allMaps] = vElites(d.fitfun,obsMap,p,d);
[predMap, ~, ~, ~, ~] = vElites(d.fitfun,obsMap,p,d);

%%
