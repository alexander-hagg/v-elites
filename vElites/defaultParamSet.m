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

p.nChildren                 = 30;
p.mutSigma                  = 0.1;
p.nGens                     = 2^10;
p.numInitSamples            = 2^4;
p.selectProcedure           = 'random';
p.maxBins                   = 2^3;
p.competeDistance           = 0.1;

% Visualization and data management
p.display.illu              = false;
p.display.illuMod           = 1;

end


%------------- END OF CODE --------------