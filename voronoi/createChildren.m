function [children,selection] = createChildren(map, p, d)
%createChildren - produce new children through mutation of map elite
%
% Syntax:  children = createChildren(map,p)
%
% Inputs:
%   map - Population struct
%    .fitness
%    .genes
%    .<additional info> (e.g., drag, lift, etc)
%   p   - SAIL hyperparameter struct
%    .nChildren - number of children created
%    .mutSigma  - sigma of gaussian mutation applied to children
%   d   - Domain description struct
%    .dof       - Degrees of freedom (genome length)
%
% Outputs:
%   children - [nChildren X genomeLength] - new solutions
%
%

% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Jul 2019; Last revision: 04-Jul-2019

%------------- BEGIN CODE --------------

% Remove empty bins from parent pool
parentPool = map.genes;

% Choose parents and create mutation
if strcmp(p.selectProcedure,'random')
    selection = randi([1 size(parentPool,1)], [p.nChildren 1]);
elseif strcmp(p.selectProcedure,'bin')
    % Setup tournament selection
    selection = randi([1 size(parentPool,1)], [p.nChildren 2]);
    areas = map.areas(selection);    
    [~,sorted] = sort(areas,2,'descend');
    idx = sub2ind(size(areas), (1:size(sorted,1))', sorted(:,1));
    
    selection = selection(idx);    
end
parents = parentPool(selection, :);

% Apply mutation
mutation = randn(p.nChildren,d.dof) .* p.mutSigma;
children = parents + mutation;
children(children>d.ranges(2)) = d.ranges(2); children(children<d.ranges(1)) = d.ranges(1);



%------------- END OF CODE --------------