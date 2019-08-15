function d = domain(dof)
%domain - Get domain configuration for n-polygon
%
% Syntax:  d = domain(dof)
%
% Inputs:
%    dof        - [1] - Set number of degrees of freedom
%
% Outputs:
%    d          - cell - Domain configuration
%
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Nov 2018; Last revision: 15-Aug-2019
%
%------------- BEGIN CODE -------------- 

RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle')); % Random number stream
warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'MATLAB:polyshape:repairedBySimplify');

if strcmp(dof,'default')
    d.dof = 12; 
else
    d.dof = dof;
end

d.nDims                     = 2;
d.featureMin                = [0   1.75   0.5      0      0];
d.featureMax                = [4   15     3        0.05   1];
d.selectedFeatures          = [1    2];
d.featureLabels             = {'area','perimeter','maxspan','minspan','random'};
d.categorize                = 'categorize';
d.debug                     = false;
d.fitnessRange              = [0 1];

t = 0:2*pi/(d.dof/2):2*pi;
t(end) = [];
x1 = 0.5*cos(t);
y1 = 0.5*sin(t);
[theta,rho] = cart2pol(x1,y1);
d.base = [theta;rho];

d.fitfun                    = @(X) npolyObjective(X,d.base);

d.ranges          = [-1 1];
d.evalFcn         = @(samples) eval_maze(samples, d, false);
d.validate        = 'validateChildren';
d.flipMap = true;

d.spacer = 2.5;

%% Individual's genome and phenotype
d.sampleInd.genome      = nan(d.dof,1);
d.sampleHighFit         = zeros(1,d.dof);
d.sampleLowFit          = 0.5*ones(1,d.dof);
d.sampleLowFit(end) = -0.5;
d.sampleLowFit(end-2) = 0.3;
d.sampleLowFit(end-3) = -0.4;
d.sampleLowFit(end-4) = -0.6;
d.sampleLowFit(1) = -0.5;

% Contains description text that is shown to the user
d.description{1} = ['N-poly domain'];
d.description{2} = '';
d.description{3} = ['Description:      n-polygons, with n currently set to ' int2str(d.dof)];
d.description{4} = ['Representation:   sequence of (x,y) pairs.'];
d.description{5} = ['Fitness function: maximize radial symmetry.'];
end

%------------- END CODE -------------- 