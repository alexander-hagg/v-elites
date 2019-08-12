function [map, percImproved, percValid, h, allMaps, percFilled] = illuminate(fitnessFunction,map,p,d,varargin)
%vElites - Voronoi Archive of Phenotypic Elites algorithm
%
% Syntax:  map = vElites(fitnessFunction, map, p, d);
%
% Inputs:
%   fitnessFunction - funct  - returns fitness of vector of individuals
%   map             - struct - initial solutions in F-dimensional map
%   p               - struct - Hyperparameters for algorithm, visualization, and data gathering
%   d               - struct - Domain definition
%
% Outputs:
%   map    - struct - population archive
%   percImproved    - percentage of children which improved on elites
%   percValid       - percentage of children which are valid members of
%   selected classes
%   h      - [1X2]  - axes handle, data handle
%   allMap          - all maps created in sequence
%   percFilled      - percentage of map filled
%
%
% See also: createChildren, getBestPerCell, updateMap

% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Jul 2019; Last revision: 04-Jul-2019

%------------- BEGIN CODE --------------

% View Initial Map
h = [];
if nargin > 4
    figHandle = varargin{1};
else
    figHandle = figure(1);
end

if nargin > 5
    figHandleMedianFit = varargin{2};
else
    figHandleMedianFit = figure(2);
end

if nargin > 6
    figHandleMedianDrift = varargin{3};
else
    figHandleMedianDrift = figure(3);
end

if p.display.illu
    cla(figHandle);
    viewMap(map,d,figHandle); title(figHandle,'Fitness'); caxis(figHandle,[0 1]);
    cla(figHandleMedianFit);
    cla(figHandleMedianDrift);
    drawnow;
end

percImproved = 0;
percValid = 0;
h = 0;
percFilled = 0;

iGen = 1;
while (iGen <= p.nGens)
    %% Create and Evaluate Children
    % Continue to remutate until enough children which satisfy geometric constraints are created
    children = [];
    while size(children,1) < p.nChildren
        newChildren = createChildren(map, p, d);
        %validInds = feval(d.validate,newChildren,d);
        %children = [children ; newChildren(validInds,:)] ; %#ok<AGROW>
        children = [children ; newChildren] ; %#ok<AGROW>
    end
    children = children(1:p.nChildren,:);
    
    [fitness, values] = fitnessFunction(children); %% TODO: Speed up without anonymous functions
    
    %% Add Children to Map
    [replaced, replacement, features] = nicheCompete(children, fitness, values, map, d);
    map = updateMap(replaced,replacement,map,fitness,children,values,features,p.extraMapValues);
    %    percImproved(iGen) = length(replaced)/p.nChildren;
    
    allMaps{iGen} = map;
    %    percFilled(iGen) = sum(~isnan(map.fitness(:)))/(size(map.fitness,1)*size(map.fitness,2));
    fitnessMean(iGen) = nanmedian(map.fitness);
    driftMean(iGen) = nanmedian(map.drift);
    
    %% View New Map
    if p.display.illu && (~mod(iGen,p.display.illuMod) || (iGen==p.nGens))
        cla(figHandle);
        viewMap(map,d,figHandle);
        title(figHandle,['Fitness Gen ' int2str(iGen) '/' int2str(p.nGens)]);
        caxis(figHandle,[0 1]);
        
        cla(figHandleMedianFit);
        plot(figHandleMedianFit,fitnessMean,'LineWidth',2);
        axis(figHandleMedianFit,[0 iGen 0 1]);
        grid(figHandleMedianFit,'on');
        
        cla(figHandleMedianDrift);
        plot(figHandleMedianDrift,driftMean,'LineWidth',2);
        axis(figHandleMedianDrift,[0 iGen 0 1]);
        grid(figHandleMedianDrift,'on');
        
        drawnow;
    end
    if ~mod(iGen,25) || iGen==1
        %disp([char(9) 'Illumination Generation: ' int2str(iGen) ' - Map Coverage: ' num2str(100*percFilled(iGen-1)) '% - Improvement: ' num2str(100*percImproved(iGen-1))]);
        disp([char(9) 'Illumination Generation: ' int2str(iGen) ]);
    end
    iGen = iGen+1;
end
%if percImproved(end) > 0.05; disp('Warning: MAP-Elites finished while still making improvements ( >5% / generation )');end


%------------- END OF CODE --------------
