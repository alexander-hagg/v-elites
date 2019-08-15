function [adjustedFitness, values, phenotypes] = objective(X, evalFcn, constraintSet, penaltyWeight, driftThreshold, varargin)
%OBJECTIVE User constrained objective function
% This objective function allows adding user constraints, as soft and hard
% constraints
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Aug 2019; Last revision: 15-Aug-2018
%
%------------- BEGIN CODE --------------
vis = false;
if nargin > 5
    figHandle = varargin{1};
    vis = true;
end

[fitness,values,phenotypes] = evalFcn(X);

offSetScalar = 1.1;

fitnessAdjustment = ones(size(X,1),1);
outOfBounds = false(size(X,1),1);
drift = zeros(size(X,1),1);
if ~isempty(constraintSet)
    for iT=1:length(constraintSet)
        if ~isempty(constraintSet{iT})
        [drift(:,iT),simPredCoords] = getUserDrift(X,constraintSet{iT});
        thisOutOfBounds = drift(:,iT) > driftThreshold;
        outOfBounds(thisOutOfBounds) = true;
        fitnessAdjustment = fitnessAdjustment .* (1-drift(:,iT));
        if vis
            if iT==1; cla(figHandle); end
            xOffset = offSetScalar*(iT-1);
            simCoords = constraintSet{iT}.model.trainOutput;
            limits = [min([simCoords;simPredCoords]);max([simCoords;simPredCoords])];
            simCoords = (simCoords-limits(1,:))./range(limits);
            simPredCoords = (simPredCoords-limits(1,:))./range(limits);
            scatter(figHandle,xOffset+simCoords(:,1),simCoords(:,2),16,[0.5 0.5 0.5],'filled');
            hold(figHandle,'on');
            classMembers = constraintSet{iT}.classLabels==constraintSet{iT}.selectedClasses;
            if size(classMembers,2) > 1; classMembers = any(classMembers'); end
            scatter(figHandle,xOffset+simCoords(classMembers,1),simCoords(classMembers,2),16,[0 0 1],'filled');
            scatter(figHandle,xOffset+simPredCoords(:,1),simPredCoords(:,2),16,[0 1 0],'filled');
            scatter(figHandle,xOffset+simPredCoords(outOfBounds,1),simPredCoords(outOfBounds,2),32,[1 0 0],'filled');
            rectangle(figHandle,'Position',[xOffset,0,1,1]);
            text(figHandle,0.25+xOffset,1.05,['Selection: ' int2str(iT)]);
            axis(figHandle,'equal');
            axis(figHandle,[-(offSetScalar-1) offSetScalar*length(constraintSet) -(offSetScalar-1) 1+(offSetScalar-1)]);
            if iT==length(constraintSet); drawnow;end            
        end
        end
    end
end

values{end+1} = fitnessAdjustment';
values{end+1} = drift';
values{end+1} = phenotypes;

adjustedFitness = (fitness .* fitnessAdjustment'.^(penaltyWeight))';
adjustedFitness(outOfBounds) = nan;

end

