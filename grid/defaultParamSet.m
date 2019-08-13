function p = defaultParamSet(varargin)
% defaultParamSet - loads default parameters for MAP-Elites algorithm
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
% Nov 2018; Last revision: 02-Nov-2018

%------------- BEGIN CODE --------------
p.nChildren                 = 2^5;
p.mutSigma                  = 0.1;
p.nGens                     = 25;
p.numInitSamples            = 2^6;
p.selectProcedure           = 'random'; %random or curiosity

% Visualization and data management
p.display.illu              = true;
p.display.illuMod           = 25;
p.numMaps2Save              = 10;

p.selectionThreshold        = 0.99;
p.minSelectedSamples        = 50;
p.keepNonselectSeeds        = false;
p.dimreduxMethod			= 'tSNE';

% Selection
p.penaltyWeight             = 2;
p.driftThreshold            = 0.5;

p.extraMapValues            = {'fitnessAdjustment','drift'};
end


