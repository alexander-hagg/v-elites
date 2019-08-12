function [fitness, output] = buildingBreed_test( wMat, aMat, d, varargin)

%% Substrate is input vector
substrateDims = d.substrateDims;
output = nan(substrateDims);

[X,Y,Z] = meshgrid(linspace(-1,1,substrateDims(1)),linspace(-1,1,substrateDims(2)),linspace(-1,1,substrateDims(3)));
input = [X(:) Y(:) Z(:)];

output(:) = FFNet(wMat,aMat,[ones(size(input,1),1) input],d);

fitness = rand;
