function d = domain(varargin)
%DOMAIN Get domain configuration for dropwave benchmark
RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle')); % Random number stream
warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'MATLAB:polyshape:repairedBySimplify');

d.nDims                     = 2;
d.featureMin                = [-5    -5];
d.featureMax                = [5    5];
d.selectedFeatures          = [1    2];
d.featureLabels             = {'x1','x2', 'random'};
d.categorize                = 'categorize';
d.featureRes                = [10 10];
d.debug                     = false;
d.extraMapValues            = {'random'};
d.fitnessRange              = [0 1];
d.fitfun                    = @(X) dropwaveObjective(X);

d.penaltyWeight             = 0.5;

d.dof = 2;

d.ranges          = [-5 5];
d.evalFcn         = @(samples) eval_maze(samples, d, false);
d.validate        = 'validateChildren';
d.flipMap = true;

d.spacer = 1;
%% Individual's genome and phenotype
d.sampleInd.genome    = nan(d.dof,1);

d.description{1} = ['Dropwave domain'];
d.description{2} = '';
d.description{3} = ['Description:      benchmark domain, with DOF set to ' int2str(d.dof)];
d.description{4} = ['Representation:   sequence of (x,y) pairs.'];
d.description{5} = ['Fitness function: Dropwave function.'];
end

