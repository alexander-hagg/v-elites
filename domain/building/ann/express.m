function genome = express(genome)
%EXPRESS - Converts population genomes into weight and activation matrices
%
% Syntax:  pop = express(pop);
%
% Inputs:
%    pop - population struct with blank  wMat and aMat matrices
%
% Outputs:
%    pop - population struct with filled wMat and aMat matrices
%
%
% Other m-files required: getNodeOrder
% See also: FFNet,  afunct

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Aug 2015; Last revision: 06-Mar-2018

%------------- BEGIN CODE --------------
[order, wMat]  = getNodeOrder(genome);
aMat           = genome.nodes(3,order);
genome.aMat = aMat;
genome.wMat = wMat;

%------------- END OF CODE --------------













