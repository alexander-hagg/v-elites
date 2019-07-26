function showExample(figHandle,d,varargin)
%SHOWEXAMPLE Summary of this function goes here

genome = randn(2*d.dof,1); if nargin>2; genome = varargin{1}; end

%title(figHandle,[int2str(d.dof) '-Polygon']);
pgon = polyshape(genome(1:2:end),genome(2:2:end));
pgon.Vertices(:,1) = pgon.Vertices(:,1);
pgon.Vertices(:,2) = pgon.Vertices(:,2);
plot(figHandle,pgon,'FaceColor','green'); 
    
axis(figHandle,[-5 5 -5 5]);
end

