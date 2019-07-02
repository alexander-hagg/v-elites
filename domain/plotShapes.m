function plotShapes(phenotypes)
%PLOTSHAPES Summary of this function goes here
%   Detailed explanation goes here

hold off;
for x=1:length(phenotypes)
    plot(phenotypes{x},'FaceColor','green'); hold on;
end

