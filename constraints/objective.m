function [adjustedFitness, values] = objective(X, evalFcn, constraintSet, penaltyWeight, varargin)
%OBJECTIVE Generic objective function
%
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 02-Nov-2018
%
%------------- BEGIN CODE --------------  

if nargin > 5
    fitness = varargin{1};
    values = varargin{2};
else
    [fitness,values] = evalFcn(X);
end
        
penalty = ones(size(X,1),1);
if ~isempty(constraintSet)
    for iT=1:length(constraintSet)
        penalty = penalty .* (1-constraintPenalty(X,constraintSet{iT}));
    end
end

values{end+1} = fitness';
values{end+1} = penalty';
adjustedFitness = fitness .* penalty;
end

