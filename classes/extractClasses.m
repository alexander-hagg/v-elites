function [classification,stats] = extractClasses(X,varargin)
%extractClasses Extract classes, determine prototypes based on fitness,
%add extra columns
%
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 02-Nov-2018
%
%------------- BEGIN CODE --------------

mapMethod               = 'tSNE'; % Configure dimensionality reduction
numClusterTrials        = 1;
clusterMethod           = 'dbscan';

if nargin > 2
    clusterMethod = varargin{1};
    numClusters = varargin{2};
end

if ndims(X) > 2
    X = reshape(X,size(X,1)*size(X,2),[]);
    X = X(all(~isnan(X')),:);
end

numDims_DR              = 2;
minGPLUS                = 1e-4;
numDims_ORG             = size(X,2);
numSamples              = size(X,1);
perplexity              = min(floor(numSamples*0.33),50);
speedQualitytradeOff    = 0.3;

for t=1:numClusterTrials
    %[simX{t}, mapping]  = compute_mapping(X, mapMethod, numDims_DR);
    simX{t}             = fast_tsne(X, numDims_DR, numDims_ORG, perplexity, speedQualitytradeOff);
    
    if strcmp(clusterMethod,'dbscan')
        coreneighbours      = max(2 * numDims_DR,3); %Rule of thumb
        [~,t_distances]     = knnsearch(simX{t},simX{t},'K',coreneighbours+1);
        t_distances(:,1)    = [];
        t_distances         = sort(t_distances(:));
        [maxVal ,~]         = getElbow(t_distances);
        epsilon             = maxVal;
        [~,labels{t},cen{t}] = dbscan(simX{t}', epsilon, coreneighbours);
        
    elseif strcmp(clusterMethod,'kmedoids')
        [labels{t},cen{t}] = kmedoids(simX{t},numClusters);
    end
    
    stats.valGPLUS(t) = m_gplus(pdist2(simX{t},simX{t}),labels{t});
    stats.valGPLUS_ORG(t) = m_gplus(pdist2(X,X),labels{t});
end



% GPLUS = 0 when only one cluster is found
%simX(~stats.valGPLUS_ORG>minGPLUS) = []; labels(~stats.valGPLUS_ORG>minGPLUS) = []; cen(~stats.valGPLUS_ORG>minGPLUS) = []; stats.valGPLUS_ORG(~stats.valGPLUS_ORG>minGPLUS) = [];
%[~, stats.minGPLUSID] = min(stats.valGPLUS_ORG);

[~,GPLUS_order] = sort(stats.valGPLUS_ORG);
prevalid = GPLUS_order(1);
validClustering = stats.valGPLUS_ORG>minGPLUS;
GPLUS_order = GPLUS_order(validClustering);
if ~isempty(GPLUS_order)
    stats.minGPLUSID = GPLUS_order(1);
else
    disp('Extract classes, all clustering runs too low GPLUS, taking best invalid one');
    stats.minGPLUSID = prevalid;
end

simX = simX{stats.minGPLUSID}; labels = labels{stats.minGPLUSID}; cen = cen{stats.minGPLUSID};
if strcmp(clusterMethod,'dbscan')
    labels = labels + 1; % Get rid of zero label
end

% Prototypes and classes
for iii=1:length(labels)
    ii = labels(iii);
    Xclass = X(labels==ii,:); simXclass = simX(labels==ii,:);
    if size(simXclass,1) > 1
        [~,~,~,~,id] = kmedoids(simXclass,1);
        classification.protoX(ii,:) = Xclass(id,:); classification.protoSimX(ii,:) = simXclass(id,:);
    else
        classification.protoX(ii,:) = Xclass; classification.protoSimX(ii,:) = simXclass;
    end
end

classification.X = X;
classification.simX = simX;
classification.labels = labels;

end
