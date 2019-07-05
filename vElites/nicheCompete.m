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

percImprovement = 0;




% Get distance to elites
if ~isempty(map.genes)
    eliteDistance = pdist2(features,map.features);
else
    eliteDistance = [];
end

% Get distance between candidates
distances = [eliteDistance pdist2(features,features)];
distances(distances==0) = nan; %TODO: this is a hack to prevent comparisons of a candidate with itself

% Compete if needed
competing = distances < map.config.competeDistance;
competition = ([map.fitness; fitness]'.*competing);

% Add competing candidates that improve the map
won = fitness > competition;
takehome = won;
takehome(~competing) = 1; % Add non-competing
replacement = all(takehome'==1);

% if ~isempty(map.genes)
%     figure(2);hold off;
%     h(1) = scatter(map.features(:,1),map.features(:,2),64,'k','filled');
%     hold on;
%     h(2) = scatter(features(:,1),features(:,2),'b','filled');
%     h(3) = scatter(features(any(competing'==1),1),features(any(competing'==1),2),'r','filled');
%     wonIDs = logical(any(competing'==1).*replacement);
%     h(4) = scatter(features(wonIDs,1),features(wonIDs,2),'g','filled');
%     legend(h,'Elites', 'Candidates', 'Competing Candidates', 'Won');
%     axis([0 1 0 1]);
%     grid on;
%     drawnow;
% end


%% TODO cells removed
%disp('No max bins implemented yet');
replaced = false(length(map.fitness),1);
if ~isempty(map.genes)
    % only remove elites from the map here
    
    % Get all distances
    removalCandidates = distances;
    % Only distances that were won by new candidates
    removalCandidates = removalCandidates.*won;
    % Ignore non-competitions
    removalCandidates(removalCandidates==0) = nan;
    % Get only candidate distances from map
    removalCandidates = removalCandidates(:,1:end-length(fitness));
    [~, nn] = min(removalCandidates');
    removeIDs = nn(logical(replacement.*~all(isnan(removalCandidates'))));
    replaced(removeIDs) = 1;
end

%% TODO MAX BINS
%p.maxBins

%% OLD CODE
%[bestIndex, bestBin] = getBestPerCell(newInds,fitness, values, d, map.edges);
%mapLinIndx = sub2ind(d.featureRes,bestBin(:,1),bestBin(:,2));

% Compare to already existing samples
%improvement = ~(fitness (bestIndex) >= map.fitness(mapLinIndx)); % comparisons to NaN are always false
%improvement(isnan(fitness(bestIndex))) = false;
%replacement = bestIndex (improvement);
%replaced    = mapLinIndx(improvement);
%------------- END OF CODE --------------