function [map, percImproved, percValid, h, allMaps, percFilled] = illuminate(fitnessFunction,map,p,d,varargin)
%mapElites - Multi-dimensional Archive of Phenotypic Elites algorithm
%
% Syntax:  map = mapElites(fitnessFunction, map, p, d);
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

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: adam.gaier@h-brs.de
% Jun 2016; Last revision: 02-Aug-2017

%------------- BEGIN CODE --------------

% View Initial Map
h = [];
if nargin > 4
    figHandle = varargin{1}; 
else
    figHandle = figure(1);
end

if p.display.illu
    cla(figHandle); viewMap(map, d, figHandle); title(figHandle,'Fitness');    
    caxis(figHandle,[0 1]);
    drawnow;
end

iGen = 1;
while (iGen <= p.nGens)
    %% Create and Evaluate Children
    % Continue to remutate until enough children which satisfy geometric constraints are created
    children = []; parentMapIDs = [];
    while size(children,1) < p.nChildren
        if strcmp(p.selectProcedure,'random')
            newChildren = createChildren(map, p, d);
        elseif strcmp(p.selectProcedure,'curiousness')
            [newChildren,newParentMapIDs] = createChildren(map, p, d);
        end
        validInds = feval(d.validate,newChildren,d);
        children = [children ; newChildren(validInds,:)] ; %#ok<AGROW>
        if strcmp(p.selectProcedure,'curiousness'); parentMapIDs = [parentMapIDs ; newParentMapIDs(validInds,:)] ; end
    end
    children = children(1:p.nChildren,:);
    
    % Constrain solutions to selected class(es)
    if isfield(p,'constraints') && strcmp(p.constraints.type,'posterior') && ~isnan(p.constraints.threshold)
        isValid = applyConstraints(children, p.constraints);
        if size(isValid,1) > 1  % Multiple classes were selected
            isValid = sum(isValid);
        end
        children(~isValid,:) = []; % Remove invalid children
        percValid(iGen) = sum(isValid)/length(isValid);
    else
        percValid(iGen) = 1;
    end
    [fitness, values] = fitnessFunction(children);
    
    %% Add Children to Map
    [replaced, replacement, features] = nicheCompete(children,fitness,values,map,d,p);
    percImproved(iGen) = length(replaced)/p.nChildren;
    %map = updateMap(replaced,replacement,map,fitness,children,...
    %    values,d.extraMapValues);
    map = updateMap(replaced,replacement,map,fitness,children,features);    
    
    allMaps{iGen} = map;
    percFilled(iGen) = sum(~isnan(map.fitness(:)))/(size(map.fitness,1)*size(map.fitness,2));
    
    %% View New Map
    if p.display.illu && (~mod(iGen,p.display.illuMod) || (iGen==p.nGens))
        cla(figHandle);
        viewMap(map, d, figHandle);   
        title(figHandle,['Fitness Gen ' int2str(iGen) '/' int2str(p.nGens)]); 
        caxis(figHandle,[0 1]);
        %figure(2); viewDomainMap(map,d);
        %title(['Generation: ' int2str(iGen)]);
        %grid on;
        drawnow;
    end
    if ~mod(iGen,25) || iGen==1
        disp([char(9) 'Illumination Generation: ' int2str(iGen) ' - Map Coverage: ' num2str(100*percFilled(iGen)) '% - Improvement: ' num2str(100*percImproved(iGen))]);
    end        
    iGen = iGen+1;
end
if percImproved(end) > 0.05; disp('Warning: MAP-Elites finished while still making improvements ( >5% / generation )');end


%------------- END OF CODE --------------
