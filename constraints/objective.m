function [adjustedFitness, values] = objective(X, evalFcn, constraintSet, penaltyWeight, driftThreshold, varargin)
%OBJECTIVE Generic objective function
%
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 02-Nov-2018
%
%------------- BEGIN CODE --------------
vis = false;
if nargin > 5
    figHandle = varargin{1};
    vis = true;
end
if nargin > 6
    fitness = varargin{2};
    values = varargin{3};
else
    [fitness,values] = evalFcn(X);
end

fitnessAdjustment = ones(size(X,1),1);
outOfBounds = false(size(X,1),1);
if ~isempty(constraintSet)
    for iT=1:length(constraintSet)
        if ~isempty(constraintSet{iT})
        [drift,simspaceModelPredictions] = getUserDrift(X,constraintSet{iT});
        thisOutOfBounds = drift > driftThreshold;
        outOfBounds(thisOutOfBounds) = true;
        fitnessAdjustment = fitnessAdjustment .* (1-drift);
        if vis
            if iT==1; cla(figHandle); end
            xOffset = 50*(iT-1);
            scatter(figHandle,xOffset+constraintSet{iT}.model.trainOutput(:,1),constraintSet{iT}.model.trainOutput(:,2),16,[0.5 0.5 0.5],'filled');
            hold(figHandle,'on');
            classMembers = constraintSet{iT}.classLabels==constraintSet{iT}.selectedClasses;
            if size(classMembers,2) > 1; classMembers = any(classMembers'); end
            scatter(figHandle,xOffset+constraintSet{iT}.model.trainOutput(classMembers,1),constraintSet{iT}.model.trainOutput(classMembers,2),16,[0 0 1],'filled');
            scatter(figHandle,xOffset+simspaceModelPredictions(:,1),simspaceModelPredictions(:,2),16,[0 1 0],'filled');
            scatter(figHandle,xOffset+simspaceModelPredictions(outOfBounds,1),simspaceModelPredictions(outOfBounds,2),32,[1 0 0],'filled');
            axis(figHandle,'equal');
            if iT==length(constraintSet); drawnow;end            
        end
        end
    end
end

values{end+1} = fitness';
values{end+1} = fitnessAdjustment';

adjustedFitness = fitness .* fitnessAdjustment.^(penaltyWeight);
adjustedFitness(outOfBounds) = nan;

end

