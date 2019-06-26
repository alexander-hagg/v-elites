function feature = categorize(samples, d, varargin)
%categorize
%
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 02-Nov-2018
%
%------------- BEGIN CODE -------------- 

fullGenomes = [samples,samples(:,1:2)];
for i=1:size(fullGenomes,1)
    pgon = polyshape(fullGenomes(i,1:2:end),fullGenomes(i,2:2:end));
    feature(i,1) = area(pgon);
    feature(i,2) = perimeter(pgon);
end

feature(:,1) = (feature(:,1)-d.featureMin(1))./(d.featureMax(1)-d.featureMin(1));
feature(:,2) = (feature(:,2)-d.featureMin(2))./(d.featureMax(2)-d.featureMin(2));

feature(feature>1) = 1; feature(feature<0) = 0;

end

