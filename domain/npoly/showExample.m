function showExample(figHandle,d,varargin)
%SHOWEXAMPLE Summary of this function goes here

genome = randn(2*d.dof,1); if nargin>2; genome = varargin{1}; end

spacer = 3;
numRows = ceil(sqrt(size(genome,1)));
numCols = floor(sqrt(size(genome,1)));
hold(figHandle,'off');
for i=1:size(genome,1)
    pgon = polyshape(genome(i,1:2:end),genome(i,2:2:end));
    pgon.Vertices(end+1,1) = pgon.Vertices(1,1);
    pgon.Vertices(end+1,2) = pgon.Vertices(1,2);
    pgon.Vertices(:,1) = pgon.Vertices(:,1) + (mod(i,numRows))*spacer;
    pgon.Vertices(:,2) = pgon.Vertices(:,2) + ((floor(i/numCols)))*spacer;
    plot(figHandle,pgon,'FaceColor','green'); 
    hold(figHandle,'on');
    drawnow;
end
    
%axis(figHandle,[-5 5 -5 5]);
end

