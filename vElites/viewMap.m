function [figHandle, imageHandle, cHandle] = viewMap(elites, d)
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
figHandle = figure;
imageHandle = voronoi(elites(:,1),elites(:,2));

%[v,c] = voronoin(elites);
%color = {'r' 'b' 'g' 'm' 'c' 'y' 'k'} ;
%for i = 1:length(c)
%    fill(v(c{i},1),v(c{i},2),char(randsample(color,1))) ;
%    hold on;
%end

cHandle = [];

xlab = xlabel([d.featureLabels{1} '\rightarrow']);
ylab = ylabel(['\leftarrow' d.featureLabels{2} ]);

%------------- END OF CODE --------------