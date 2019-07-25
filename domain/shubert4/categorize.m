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
feature(:,1) = (samples(:,1)-d.featureMin(1))./(d.featureMax(1)-d.featureMin(1));
feature(:,2) = (samples(:,2)-d.featureMin(2))./(d.featureMax(2)-d.featureMin(2));

feature(feature>1) = 1; feature(feature<0) = 0;

feature(:,3) = rand(size(feature(:,1)));

end

