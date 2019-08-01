function showExample(figHandle,d,varargin)
%SHOWEXAMPLE Summary of this function goes here

genome = randn(1,d.dof); 
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

pgon = getPhenotype(genome,d.base);
for i=1:size(genome,1)
    % Change placement if necessary
    if exist('placement','var') && ~isempty(placement)
        pgon{i}.Vertices = pgon{i}.Vertices + placement(i,:);
    end
    plot(figHandle,pgon{i},'FaceColor','green'); 
    hold(figHandle,'on');
end
end

