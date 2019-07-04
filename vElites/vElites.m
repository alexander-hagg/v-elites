function [map, percImproved, percValid, h, allMaps, percFilled] = vElites(fitnessFunction,map,p,d)
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
if p.display.illu
    figure(1); clf;
    h(1) = viewMap(map.features,d,1); title('Voronoi Map');
    drawnow;
end

iGen = 1;
while (iGen < p.nGens)
    %% Create and Evaluate Children
    % Continue to remutate until enough children which satisfy geometric constraints are created
    children = []; 
    while size(children,1) < p.nChildren
        disp('Still randomly selecting!');
        newChildren = createChildren(map, p, d);
        %validInds = feval(d.validate,newChildren,d);
        %children = [children ; newChildren(validInds,:)] ; %#ok<AGROW>
        children = [children ; newChildren] ; %#ok<AGROW>
    end
    children = children(1:p.nChildren,:);
    
    [fitness, values] = fitnessFunction(children); %% TODO: Speed up without anonymous functions
    
    %% Add Children to Map
    [replaced, replacement, features] = nicheCompete(children, fitness, values, map, d);

%    [replaced, replacement] = nicheCompete(children,fitness,values,map,d);
%    percImproved(iGen) = length(replaced)/p.nChildren;
%    map = updateMap(replaced,replacement,map,fitness,children,...
%        values,d.extraMapValues);
    
%    allMaps{iGen} = map;
%    percFilled(iGen) = sum(~isnan(map.fitness(:)))/(size(map.fitness,1)*size(map.fitness,2));
    
%     %% View New Map
%     if p.display.illu && (~mod(iGen,p.display.illuMod) || (iGen==p.nGens-1))
%         figure(1);
%         viewMap(map.fitness, d, map.edges,'flip');
%         colormap(h(1),parula(16));
%         caxis([1 10]);  %REMOVE THIS
%         title(['Original Fitness Gen ' int2str(iGen) '/' int2str(p.nGens)]); 
%         
%         figure(2); viewDomainMap(map,d);
%         title(['Generation: ' int2str(iGen)]);
%         grid on;
%         drawnow;
%     end
%         
%     iGen = iGen+1;
%     if ~mod(iGen,25) || iGen==2
%         disp([char(9) 'Illumination Generation: ' int2str(iGen) ' - Map Coverage: ' num2str(100*percFilled(iGen-1)) '% - Improvement: ' num2str(100*percImproved(iGen-1))]);
%     end
end
%if percImproved(end) > 0.05; disp('Warning: MAP-Elites finished while still making improvements ( >5% / generation )');end


%------------- END OF CODE --------------
