function d = ffd_Domain(tmpdir)
%ffd_Domain - Feed Forward Deformation Airfoil Domain Parameters 
%
%Returns struct with default for all settings of the FFD airfoil domain
%including hyperparameters, and strings indicating functions for
%representation and evaluation.
%
% Syntax:  d = ffd_Domain;
%
% Example: 
%    output = sail(sail,ffd_Domain);
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: sail, runSail

% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Jun 2017; Last revision: 20-Aug-2017

%------------- BEGIN CODE --------------
d.name = 'FFD';
%rmpath( genpath('domains'));
addpath(genpath('domains/foilFFD/'));
d.tmpdir = tmpdir;

% Scripts
d.preciseEvaluate   = 'ffd_PreciseEvaluate';
d.categorize        = 'ffd_Categorize';
d.createAcqFunction = 'ffd_CreateAcqFunc';
d.validate          = 'ffd_ValidateChildren';

% Alternative initialization
d.loadInitialSamples = false;
d.initialSampleSource= '';

% Genotype to Phenotype Expression
d.dof       = 10;
d.express   = @(x) ffdRaeY(x);
d.base      = loadBaseAirfoil(d.express, d.dof, d.tmpdir);
d.fitnessPenalty_Area = true;

% Feature Space
d.featureRes    = [25 25];
d.nDims         = length(d.featureRes);
d.featureMin    = [0.0440 0.1500];
d.featureMax    = [0.1588 0.5175];
d.featureLabels = {'Z_{up}','X_{up}'}; % {X label, Y label}

% Acquisition function
d.varCoef       = 20; % variance weight
d.muCoef        = 1; % mean weight 
d.prevMaxVar    = []; % keep track of previous maximum variances

% Domain Specific Map Values
d.extraMapValues = {'cD','cL','confidence'};

% Default Surrogate Model
d.surrogateName = 'GP';





%------------- END OF CODE --------------




















