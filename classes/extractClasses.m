function [classification,simX,stats] = extractClasses(X,varargin)
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

clusterMethod           = 'dbscan';
if nargin > 3
    clusterMethod = varargin{2};
    numClusters = varargin{3};
end

% Reshape data
if ndims(X) > 2
    X = reshape(X,size(X,1)*size(X,2),[]);
    X = X(all(~isnan(X')),:);
end

if nargin > 1 && ~isempty(varargin{1})
    simX = varargin{1};
else
    simX             = getSimSpace(X);
end

if strcmp(clusterMethod,'dbscan')
    coreneighbours      = max(2 * numDims_DR,3); %Rule of thumb
    [~,t_distances]     = knnsearch(simX,simX,'K',coreneighbours+1);
    t_distances(:,1)    = [];
    t_distances         = sort(t_distances(:));
    [maxVal ,~]         = getElbow(t_distances);
    epsilon             = maxVal;
    [~,labels,cen] = dbscan(simX', epsilon, coreneighbours);
    
elseif strcmp(clusterMethod,'kmedoids')
    [labels,cen] = kmedoids(simX,numClusters);
end

stats.valGPLUS = m_gplus(pdist2(simX,simX),labels);
stats.valGPLUS_ORG = m_gplus(pdist2(X,X),labels);


if strcmp(clusterMethod,'dbscan')
    labels = labels + 1; % Get rid of zero label
end

% Prototypes and classes
for iii=1:length(labels)
    ii = labels(iii);
    Xclass = X(labels==ii,:); simXclass = simX(labels==ii,:);
    
    id = ismember(simXclass,cen(ii,:),'rows');
    classification.protoX(ii,:) = Xclass(id,:); classification.protoSimX(ii,:) = simXclass(id,:);
end

classification.X = X;
classification.simX = simX;
classification.labels = labels;

end
