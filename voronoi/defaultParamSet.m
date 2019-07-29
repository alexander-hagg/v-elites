function p = defaultParamSet(varargin)
% defaultParamSet - loads default parameters for V-Elites algorithm
%
% Syntax:  p = defaultParamSet(ncores)
%               ncores - number of parallel workers (one child per worker for efficiency)
%
% Outputs:
%   p      - struct - parameter struct
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Jul 2019; Last revision: 04-Jul-2019

%------------- BEGIN CODE --------------

p.nChildren                 = 2^5;
p.mutSigma                  = 0.1;
p.nGens                     = 25;
p.numInitSamples            = 2^5;
p.selectProcedure           = 'random'; % random bin
p.maxBins                   = 2^3; % not used yet
p.competeDistance           = 0.0005;
p.infReplacement            = 1;

% Visualization and data management
p.display.illu              = false;
p.display.illuMod           = 100;

end


%------------- END OF CODE --------------