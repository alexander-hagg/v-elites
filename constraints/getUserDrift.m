function [drift,simspaceModelPredictions] = getUserDrift(X,constraints)
%CONSTRAINTPENALTY Calculate constraint penalty
% penalty between 0 and 1
drift = zeros(size(X,1),1);

[~,classDistances,~,simspaceModelPredictions] = applyConstraints(X, constraints);
classBinary = false(size(classDistances,1),1);
classBinary(constraints.selectedClasses) = 1;
if sum(classBinary)==1
    distSELECTED = classDistances(classBinary,:);
else
    distSELECTED = min(classDistances(classBinary,:));
end
if sum(~classBinary)==1
    distNONSELECTED = classDistances(~classBinary,:);
else
    distNONSELECTED = min(classDistances(~classBinary,:));
end

if ~isempty(distNONSELECTED) % If not all classes are selected    
    drift = distSELECTED./(distSELECTED+distNONSELECTED); 
    drift = reshape(drift,length(drift),1); % Make sure it is a col vector    
end
end

