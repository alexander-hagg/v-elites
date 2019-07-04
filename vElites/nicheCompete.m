function [replaced, replacement, features, percImprovement] = nicheCompete(newInds,fitness,values,map,d)
%nicheCompete - results of competition with map's existing elites
%
% Syntax:  [replaced, replacement] = nicheCompete(newInds,fitness,map,p)
%
% Inputs:
%   newInds - [NXM]     - New population to compete for niches
%   fitness - [NX1]     - Fitness values fo new population
%   map     - struct    - Population archive
%   d       - struct    - Domain definition
%
% Outputs:
%   replaced    - [NX1] - Linear index of map cells to recieve replacements
%   replacement - [NX1] - Index of newInds to replace current elites in niche
%
% Example:

% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Jul 2019; Last revision: 04-Jul-2019

%------------- BEGIN CODE --------------
features = feval(d.categorize, newInds, values, d);
replacement = false(size(newInds,1),1);

%%TODO
replaced = false(length(map.fitness),1);
percImprovement = 0;

% Get distance to elites
if ~isempty(map.genes)   
    distances = pdist2(features,map.features);
else
    distances = [];
end
% Compete if needed
%TODO Competition with old elites

% Get distance between candidates
distances = [distances pdist2(features,features)];
distances(distances==0) = 99; %TODO: this is a hack to prevent comparisons of a candidate with itself

% Compete if needed
competing = distances < map.config.competeDistance;
competition = fitness' < (fitness.*competing);
won = all(competition(any(competing==1),:)'==0);
% Add competing candidates that improve the map
replacement(any(competing==1)) = won;

% Add non-competing candidates
noncompeting = all(competing==0);
replacement(noncompeting) = 1;


%%TODO  do not delete old elites but merge


%% OLD CODE
%[bestIndex, bestBin] = getBestPerCell(newInds,fitness, values, d, map.edges);
%mapLinIndx = sub2ind(d.featureRes,bestBin(:,1),bestBin(:,2));

% Compare to already existing samples
%improvement = ~(fitness (bestIndex) >= map.fitness(mapLinIndx)); % comparisons to NaN are always false
%improvement(isnan(fitness(bestIndex))) = false;
%replacement = bestIndex (improvement);
%replaced    = mapLinIndx(improvement);
%------------- END OF CODE --------------