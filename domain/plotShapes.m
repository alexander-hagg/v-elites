function h = plotShapes(phenotypes,numInitSamples)
%PLOTSHAPES Summary of this function goes here
%   Detailed explanation goes here

hold off;
for x=1:length(phenotypes)
    if x > length(phenotypes) - numInitSamples + 1
        clr = 'red';
        legendID = 1;
    else 
        clr = 'green';
        legendID = 2;
    end
    xCoords = phenotypes{x}.Vertices(~isnan(phenotypes{x}.Vertices(:,1)),1);
    yCoords = phenotypes{x}.Vertices(~isnan(phenotypes{x}.Vertices(:,2)),2);
    h(legendID) = fill(xCoords,yCoords,clr); hold on;
end

