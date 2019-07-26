function showExample(figHandle,d,varargin)
%SHOWEXAMPLE Summary of this function goes here

genes = [0,0]; if nargin>2; genes = varargin{1}; end
%title(figHandle,'Benchmark');
scatter(figHandle,genes(1),genes(2),[],[0 0 0],'filled');
axis(figHandle,[-5 5 -5 5]);
end

