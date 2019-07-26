function [figHandle, imageHandle, cHandle] = viewMap(mapMatrix, d, varargin)
%computeFitness - Computes fitness with penalties from drag, lift, area
%
% Syntax:  viewMap(predMap.fitness, d)
%
% Inputs:
%   mapMatrix   - [RXC]  - scalar value in each bin (e.g. fitness)
%   d           - struct - Domain definition
%
% Outputs:
%   figHandle   - handle of resulting figure
%   imageHandle - handle of resulting map image
%
%
% Example:
%    p = sail;
%    d = af_Domain;
%    output = sail(d,p);
%    d.featureRes = [50 50];
%    predMap = createPredictionMap(output.model,p,d);
%    viewMap(predMap.fitness,d)
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: createMap, updateMap, createPredictionMap

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: adam.gaier@h-brs.de
% Jun 2016; Last revision: 20-Aug-2017

%------------- BEGIN CODE --------------
if nargin > 2; figHandle = varargin{1}; else; figHandle = figure;end

mapRes = size(mapMatrix.fitness);
for i=1:length(mapRes)
    edges{i} = linspace(0,1,mapRes(i)+1); %#ok<AGROW>
end

yOffset = [0.5 -0.0 0];
imgHandle = imagesc(figHandle,flipud(rot90(mapMatrix.fitness))); 
if nargin > 3
    if strcmp(varargin{1},'flip')
        imgHandle = imagesc(figHandle,fliplr(rot90(rot90(mapMatrix.fitness)))); fitPlot = gca;
    end
end

set(imgHandle,'AlphaData',~isnan(imgHandle.CData)*1)
xlab = xlabel(figHandle,[d.featureLabels{1} '\rightarrow']);
ylab = ylabel(figHandle,['\leftarrow' d.featureLabels{2} ]);
%set(ylab,'Rotation',0,'Position',get(ylab,'Position')-yOffset)



xticklabels = num2str(edges{2}',2);
if length(xticklabels)>10
    keep = false(1,length(xticklabels));
    keep(1:round(length(xticklabels)/10):length(xticklabels)) = true;
    xticklabels(~keep,:)= ' ';
end

yticklabels = num2str(edges{1}(end:-1:1)',2);
if length(yticklabels)>10
    keep = false(1,length(yticklabels));
    keep(1:round(length(yticklabels)/10):length(yticklabels)) = true;
    yticklabels(~keep,:)= ' ';
end
xticklabels = {}; yticklabels = {};
set(figHandle,...
    'XTickLabel',xticklabels,...
    'XTick', linspace(0.5,d.featureRes(2)+0.5,d.featureRes(2)+1), ...
    'YTickLabel',yticklabels,...
    'YTick', linspace(0.5,d.featureRes(1)+0.5,d.featureRes(1)+1),...
    'xgrid', 'on', 'ygrid', 'on', 'gridlinestyle', '-',...
    'xcolor', 'k', 'ycolor', 'k'...
    )

cHandle = colorbar(figHandle);
axis(figHandle,'square');
%figHandle = fitPlot; 
imageHandle = imgHandle;

%------------- END OF CODE --------------