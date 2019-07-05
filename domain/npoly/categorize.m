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
    feature(i,2) = log(perimeter(pgon));
end

feature(:,1) = (feature(:,1)-d.featureMin(1))./(d.featureMax(1)-d.featureMin(1));
feature(:,2) = (feature(:,2)-d.featureMin(2))./(d.featureMax(2)-d.featureMin(2));

feature(feature>1) = 1; feature(feature<0) = 0;

end

