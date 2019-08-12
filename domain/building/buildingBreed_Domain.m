function d = buildingBreed_Domain
%buildingBreed_Domain - Domain parameters for the buildingBreed domain
%
%
% Syntax:  d = xor_Domain
%
% Inputs:
%    nInputs - number of inputs in XOR neural network
%    input2 - Description
%    input3 - Description
%
% Outputs:
%    output1 - Description
%    output2 - Description
%
% Example: 
%    Line 1 of example
%    Line 2 of example
%    Line 3 of example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Aug 2015; Last revision: 25-Sep-2017

%------------- Input Parsing ------------

%------------- BEGIN CODE --------------

d.name = 'buildingBreed';
rmpath( genpath('domains')); addpath(genpath(['domains/' d.name '/']));

% Functions
d.fitFun   = 'buildingBreed_FitnessFunc' ;
d.stop     = 'buildingBreed_StopCriteria';
d.indVis   = 'buildingBreed_IndVis';
d.init     = 'buildingBreed_Initialize';

% Initial Network Topology
d.inputs  = 3;
d.outputs = 1;
d.activations = [1 ones(1,d.inputs) 14]; % Bias, Linear inputs, Ladder/Multistep
%d.actRange = [1 2 3 4 10 11]; % linear, unsigned step, Unsigned higher slope sigmoid, Gaussian, squared, cos
d.actRange = [1 2 3 4 10 11]; % linear, Unsigned higher slope sigmoid, Gaussian, squared, cos
d.weightCap = 2;

% Substrate
d.substrateDims = [25 25 25]; 

%------------- END OF CODE --------------
