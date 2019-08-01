function showExample(figHandle,d,varargin)
%SHOWEXAMPLE Summary of this function goes here

genome = randn(1,2*d.dof); 
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

for i=1:size(genome,1)
    pgon = polyshape(genome(i,1:2:end),genome(i,2:2:end));
    pgon.Vertices(end+1,1) = pgon.Vertices(1,1);
    pgon.Vertices(end+1,2) = pgon.Vertices(1,2);
    % Change placement if necessary
    if exist('placement','var') && ~isempty(placement)
        pgon.Vertices = pgon.Vertices + placement(i,:);
    end
    plot(figHandle,pgon,'FaceColor','green'); 
    hold(figHandle,'on');
end
end

