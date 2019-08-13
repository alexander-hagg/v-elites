function feature = categorize(samples, phenotypes, d, varargin)
%categorize
%
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 02-Nov-2018
%
%------------- BEGIN CODE -------------- 

for i=1:length(phenotypes)
    pgon = phenotypes{i};
    feature(i,1) = area(pgon);
    feature(i,2) = perimeter(pgon);
    vertices = pgon.Vertices(all(~isnan(pgon.Vertices)'),:);    
    vertices = unique(vertices,'rows','stable');
    y = interppolygon([vertices],125,'linear');
    vertexDistances = pdist2(y,y);
    %vertexDistances = pdist2(vertices,vertices);
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

