function showExample(figHandle,d,varargin)
%SHOWEXAMPLE Summary of this function goes here

genome = d.ranges(2)*(2*rand(1,d.dof)-1); 
if nargin>2
    if ~isempty(varargin{1})
        genome = varargin{1}; 
    end
end

if nargin>3
    if ~isempty(varargin{2})
        placement = varargin{2}; 
    end
end

selectionLabels = ones(1,size(genome,1));
if nargin>4
    if ~isempty(varargin{3})
        selectionLabels = varargin{3}; 
    end
end

colors = {'red','green'};
pgon = getPhenotype(genome,d.base);
for i=1:size(genome,1)
    % Change placement if necessary
    if exist('placement','var') && ~isempty(placement)
        if isa(pgon{i},'polyshape')
            pgon{i}.Vertices = pgon{i}.Vertices + placement(i,:);
        end
    end
    if isa(pgon{i},'polyshape')
        plot(figHandle,pgon{i},'FaceColor',colors{selectionLabels(i)}); 
    end
    hold(figHandle,'on');
end
end

