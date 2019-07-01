function feature = categorize(samples, values, d, varargin)
%categorize
%
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 02-Nov-2018
%
%------------- BEGIN CODE -------------- 
imSize = 256;
    
for i=1:length(values{1})
    pgon = values{1}{i};
    feature(i,1) = area(pgon);
    feature(i,2) = perimeter(pgon);
    
    % Rescale and get pixel mask
    %xCoords = (pgon.Vertices(:,1)+1)*(imSize/2);
    %yCoords = (pgon.Vertices(:,2)+1)*(imSize/2);
    %bw = poly2mask(xCoords,yCoords,imSize,imSize); % Sample pixels from nPoly
    %[B,L] = bwboundaries(bw);
    %sizes = cellfun('size',B,1);
    %[~,largestBlob] = max(sizes);
    %boundary = B{largestBlob};
    %distances = pdist2(boundary,boundary);
    %feature(i,2) = max(distances(:))./min(distances(distances(:)>0));
end

feature(:,1) = (feature(:,1)-d.featureMin(1))./(d.featureMax(1)-d.featureMin(1));
feature(:,2) = (feature(:,2)-d.featureMin(2))./(d.featureMax(2)-d.featureMin(2));

feature(feature>1) = 1; feature(feature<0) = 0;

end

