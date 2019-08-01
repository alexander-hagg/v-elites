function [replaced, replacement, features, percImprovement] = nicheCompete(newInds,fitness,values,map,d,p)
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

percImprovement = 0;


% Get distance to elites
if ~isempty(map.genes)
    eliteDistance = pdist2(features(:,d.selectedFeatures),map.features(:,d.selectedFeatures));
else
    eliteDistance = [];
end

% Get distance between candidates
distances = [eliteDistance pdist2(features(:,d.selectedFeatures),features(:,d.selectedFeatures))];
distances(distances==0) = nan; %TODO: this is a hack to prevent comparisons of a candidate with itself

% Compete if needed
%fitnessScaling = 1./(1+fitness*30);
%fitnessScaling = 1./(fitness/sum(fitness));
competing = distances < map.config.competeDistance;%.*fitnessScaling;
competition = ([map.fitness; fitness]' .* competing);
competition(~competing) = nan;

% Add competing candidates that improve the map
won = fitness > competition;
takehome = won;
takehome(~competing) = 1; % Add non-competing
replacement = all(takehome'==1);


%% TODO cells removed
%disp('No max bins implemented yet');
replaced = false(length(map.fitness),1);
if ~isempty(map.genes)
    % only remove elites from the map here
    distanceCompetition = (distances .* competing);
    distanceCompetition(~competing) = nan;
    
    % Get all distances
    %removalCandidates = distances;
    % Only distances that were won by new candidates
    removalCandidates = distanceCompetition.*won;
    % Ignore non-competitions
    removalCandidates(removalCandidates==0) = nan;
    % Get only candidate distances from map
    removalCandidates = removalCandidates(:,1:end-length(fitness));
    [~, nn] = min(removalCandidates');
    removeIDs = nn(~all(isnan(removalCandidates')));
    %removeIDs = nn(logical(replacement));
    %removeIDs = nn(logical(replacement.*~all(isnan(removalCandidates'))));
    %removeIDs(all(competing'==0)) = [];
    if ~isempty(removeIDs); replaced(removeIDs) = 1;end
end

%% TODO MAX BINS
%p.maxBins
%------------- END OF CODE --------------