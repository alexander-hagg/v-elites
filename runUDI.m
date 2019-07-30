%runUDI - Example usage script of User Driven Illumination 
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Jun 2019; Last revision: 18-Jun-2019


%------------- BEGIN CODE --------------

%% ------------- EXPERIMENT SETUP --------------
clear;clc;
domainname = 'FOILFFD';
systemInit;
d = ffd_Domain('/tmp/foilffd'); 
p = defaultParamSet(d);
p.nInitialSamples   = 64;
p.nAdditionalSamples= 16;
p.nTotalSamples     = 512;

%% ------------- EXPERIMENT STARTUP --------------
% Fix initial sample set to compare models
d.initialSampleSource   = 'initialSampleSource.mat';
if ~exist(d.initialSampleSource,'file')
    [observation, value]    = initialSampling(d,p.nInitialSamples);
    save(d.initialSampleSource,'observation','value');
end
d.loadInitialSamples    = true;

% Fix Sobol generator to compare models
d.commonSobolGen = scramble(sobolset(d.nDims,'Skip',1e3),'MatousekAffineOwen');

% Initialize surrogate models
for target=1:d.numSurrogateModels; d.params{target}     = feval(['params' d.surrogateName], d.dof); end

%% ------------- EXPERIMENT LOOP --------------
output = sail(p,d);


%% ------------- EXPERIMENT ANALYSIS --------------
X = reshape(output.predMap(end).genes,size(output.predMap(end).genes,1)*size(output.predMap(end).genes,2),[]);
X = X(~any(isnan(X')),:);

[ estimatedLabels, reducedParSpace, t_distances, epsilon, coreneighbours, stats ] = dimReducedClustering( X, 'tSNE', 2 );
%net = selforgmap([5 5]);
%[net,tr] = train(net,X');
%y = net(X');
%estimatedLabels = vec2ind(y);

%% Visualization
set(0,'DefaultFigureWindowStyle','docked')
clusterMap = output.predMap(end).fitness; clusterMap(~isnan(output.predMap(end).fitness(:))) = estimatedLabels;
figure(5); viewMap(clusterMap,d);title('Genetic Clusters');


%%
%mapViewer(output.predMap(end),d)





%------------- END CODE --------------
