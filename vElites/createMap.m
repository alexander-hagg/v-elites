function map = createMap(genomeLength, maxBins, competeDistance, infReplacement)
%createMap - Defines map struct and feature space cell divisions
%
% Syntax:  [map, edges] = createMap(featureResolution, genomeLength)
%
% Inputs:
%    featureResolution  - [1X1] - Length of genome
%    maxBins            - [1X1] - Maximum number of bins
%    competeDistance    - [1X1] - Distance within which individuals compete
%
% Outputs:
%    map  - struct with [M(1) X M(2)...X M(N)] matrices for fitness, etc
%       edges               - {1XN} cell of partitions for each dimension
%       fitness, drag, etc  - [M(1) X M(2) X M(N)] matrices of scalars
%       genes               - [M(1) X M(2) X M(N) X genomeLength]
%
% Example: 

% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Jul 2019; Last revision: 04-Jul-2019

%------------- BEGIN CODE --------------

map.config.genomeLength         = genomeLength;
map.config.maxBins              = maxBins;
map.config.competeDistance      = competeDistance;
map.config.infReplacement       = infReplacement;
map.fitness                     = [];
map.genes                       = [];
map.features                    = [];
map.areas                       = [];

%------------- END OF CODE --------------