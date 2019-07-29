function showExample(figHandle,d,varargin)
%SHOWEXAMPLE Summary of this function goes here

genome = randn(1,2*d.dof); 
if nargin>2
    if ~isempty(varargin{1})
        genome = varargin{1}; 
    end
end

boundAxes = false;
if nargin>3
    boundAxes = varargin{2};
end

numRows = ceil(sqrt(size(genome,1)));
hold(figHandle,'off');
for i=1:size(genome,1)
    pgon = polyshape(genome(i,1:2:end),genome(i,2:2:end));
    pgon.Vertices(end+1,1) = pgon.Vertices(1,1);
    pgon.Vertices(end+1,2) = pgon.Vertices(1,2);
    pgon.Vertices(:,1) = pgon.Vertices(:,1) + (mod(i-1,numRows))*d.spacer;
    pgon.Vertices(:,2) = pgon.Vertices(:,2) + ((floor((i-1)/numRows)))*d.spacer;
    plot(figHandle,pgon,'FaceColor','green'); 
    hold(figHandle,'on');
end
    
if boundAxes
    axis(figHandle,[d.phenotypeAxisRanges d.phenotypeAxisRanges]);
end
end

