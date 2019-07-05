function d = domain()
%DOMAIN_NPOLY Get domain configuration for n-polygon
RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle')); % Random number stream
warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'MATLAB:polyshape:repairedBySimplify');


d.nDims                     = 2;
d.featureMin                = [0    1];
d.featureMax                = [1    3];
d.categorize                = 'categorize';
d.featureLabels             = {'area','perimeter'};
d.featureRes                = [40 40];
d.debug                     = false;
d.extraMapValues            = {'random'};
d.fitnessRange              = [-10 -1];
d.fitfun                    = @(X) objective(X);


d.penaltyWeight             = str2num(getenv('CFG_PWEIGHT')); if isempty(d.penaltyWeight); d.penaltyWeight = 0.5; end
disp(['Penalty weight: ' num2str(d.penaltyWeight)]);

d.dof = 16;
d.tmpdir = getenv('JOBTMPDIR'); if isempty(d.tmpdir); d.tmpdir='/tmp';end
disp(['tmp dir: ' d.tmpdir]);
mkdir(d.tmpdir);


d.ranges          = [-1 1];
d.evalFcn         = @(samples) eval_maze(samples, d, false);
d.validate        = 'validateChildren';
d.flipMap = true;


%% Individual's genome and phenotype
d.sampleInd.genome    = nan(d.dof,1);

disp("Running vElites on npoly domain");
end
