function d = domain(varargin)
%DOMAIN Get domain configuration for dropwave benchmark
RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle')); % Random number stream
warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'MATLAB:polyshape:repairedBySimplify');

d.nDims                     = 2;
d.featureMin                = [-2    -2];
d.featureMax                = [2    2];
d.categorize                = 'categorize';
d.featureLabels             = {'x1','x2'};
d.featureRes                = [10 10];
d.debug                     = false;
d.extraMapValues            = {'random'};
d.fitnessRange              = [0 1];
d.fitfun                    = @(X) objective(X);

d.dof = 2;

d.ranges          = [-2 2];
d.evalFcn         = @(samples) eval_maze(samples, d, false);
d.validate        = 'validateChildren';


%% Individual's genome and phenotype
d.sampleInd.genome    = nan(d.dof,1);

disp("Running vElites on Shubert 4 domain");
end

