function d = domain(varargin)
%DOMAIN Get domain configuration for dropwave benchmark
RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle')); % Random number stream
warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'MATLAB:polyshape:repairedBySimplify');

d.nDims                     = 2;
d.featureMin                = [-2    -2];
d.featureMax                = [2    2];
d.selectedFeatures          = [1    2];
d.featureLabels             = {'x1','x2', 'random'};
d.categorize                = 'categorize';
d.featureRes                = [10 10];
d.debug                     = false;
d.extraMapValues            = {'random'};
d.fitnessRange              = [0 1];
d.fitfun                    = @(X) shubert4Objective(X);

d.penaltyWeight             = 0.5;

d.dof = 2;

d.ranges          = [-2 2];
d.evalFcn         = @(samples) eval_maze(samples, d, false);
d.validate        = 'validateChildren';

d.spacer = 1;
%% Individual's genome and phenotype
d.sampleInd.genome    = nan(d.dof,1);

disp("Running vElites on Shubert 4 domain");
end

