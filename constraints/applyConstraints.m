function [isValid,classDistances,selectedClasses] = applyConstraints(examples, constraints)
%APPLYCONSTRAINTS Summary of this function goes here
% Detailed explanation goes here
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 15-Jan-2019

%------------- BEGIN CODE --------------
model = constraints.model; sigma = constraints.threshold; classLabels = constraints.classLabels; selectedClasses = constraints.selectedClasses;
[outputs,confOutputs] = predictSimspace(examples,model);

% Get distances to all class members
for i=1:max(classLabels)
    memberIDs = (classLabels==i);
    
    if constraints.dimreduction
        members = model.trainOutput(memberIDs,:);
        if size(members,1)==1
            classDistances(i,:) = pdist2(outputs,members);
        else
            classDistances(i,:) = min(pdist2(outputs,members)');
        end
    else
        members = model.trainInput(memberIDs,:);
        if size(members,1)==1
            classDistances(i,:) = pdist2(examples,members);
        else
            classDistances(i,:) = min(pdist2(examples,members)');
        end
    end
end

classVariance = sqrt(max(confOutputs'));
classMembership = bsxfun(@le,classDistances-min(classDistances),sigma*classVariance);
isValid = classMembership(selectedClasses,:);
end

