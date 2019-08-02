function feature = categorize(samples, values, d, varargin)
%categorize
%
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 02-Nov-2018
%
%------------- BEGIN CODE -------------- 

for i=1:length(values{1})
    pgon = values{1}{i};
    feature(i,1) = area(pgon);
    feature(i,2) = perimeter(pgon);
    vertexDistances = pdist2(pgon.Vertices,pgon.Vertices);
    vertexDistances(logical(eye(size(vertexDistances,1)))) = nan;
    feature(i,3) = nanmax(vertexDistances(:));
    feature(i,4) = nanmin(vertexDistances(:));
end

feature(:,1) = (feature(:,1)-d.featureMin(1))./(d.featureMax(1)-d.featureMin(1));
feature(:,2) = (feature(:,2)-d.featureMin(2))./(d.featureMax(2)-d.featureMin(2));
feature(:,3) = (feature(:,3)-d.featureMin(3))./(d.featureMax(3)-d.featureMin(3));
feature(:,4) = (feature(:,4)-d.featureMin(4))./(d.featureMax(4)-d.featureMin(4));
feature(:,5) = rand(size(feature(:,1)));

feature(feature>1) = 1; feature(feature<0) = 0;

end

