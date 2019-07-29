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

scatter(figHandle,genome(1),genome(2),[],[0 0 0],'filled');

if boundAxes
    axis(figHandle,[d.phenotypeAxisRanges d.phenotypeAxisRanges]);
end

end

