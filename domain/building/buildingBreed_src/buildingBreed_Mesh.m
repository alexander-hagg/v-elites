function [ h ] = buildingBreed_Mesh( netOutput,startOffset )
%BUILDINGBREED_MESH Summary of this function goes here
%   Detailed explanation goes here

voxelSurf(netOutput,false);
h = gca; % Get the handle of the figure
h.Children(1).Vertices = startOffset + h.Children(1).Vertices;
end
% ------------------------------Code Ends Here-------------------------------- %