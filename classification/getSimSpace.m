function simX = getSimSpace(X)
%GETSIMSPACE Summary of this function goes here
%   Detailed explanation goes here

% Reshape data
if ndims(X) > 2
    X = reshape(X,size(X,1)*size(X,2),[]);
    X = X(all(~isnan(X')),:);
end

numDims_DR              = 2;
numDims_ORG             = size(X,2);
numSamples              = size(X,1);
perplexity              = min(floor(numSamples*0.33),50);
speedQualitytradeOff    = 0.3;

simX = fast_tsne(X, numDims_DR, numDims_ORG, perplexity, speedQualitytradeOff);

end

