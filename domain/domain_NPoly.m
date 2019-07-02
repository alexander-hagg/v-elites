function d = domain_NPoly(varargin)
%DOMAIN_NPOLY Get domain configuration for n-polygon
RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle')); % Random number stream
warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'MATLAB:polyshape:repairedBySimplify');


d.nDims                     = 2;
d.featureMin                = [0    1];
d.featureMax                = [2.5    2];
d.categorize                = 'categorize';
d.featureLabels             = {'area','perimeter'};
d.featureRes                = [40 40];
d.debug                     = false;
d.extraMapValues            = {'random'};

d.penaltyWeight             = str2num(getenv('CFG_PWEIGHT')); if isempty(d.penaltyWeight); d.penaltyWeight = 0.5; end
disp(['Penalty weight: ' num2str(d.penaltyWeight)]);

d.dof = 4; if nargin > 0; d.dof = varargin{1}; end;
d.tmpdir = getenv('JOBTMPDIR'); if isempty(d.tmpdir); d.tmpdir='/tmp';end
disp(['tmp dir: ' d.tmpdir]);
mkdir(d.tmpdir);


d.ranges          = [-1 1];
d.evalFcn         = @(samples) eval_maze(samples, d, false);
d.validate        = 'validateChildren';
d.flipMap = true;


%% Individual's genome and phenotype
d.sampleInd.genome    = nan(d.dof,1);

%% Objective Function: Path length
d.metricFitness               = @metricFitness;
%d.fitfun                      = @(X) objective(X, d.evalFcn, d.metricFitness, [], d.penaltyWeight);
d.fitfun                      = @(X) objective(X);

disp('Domain loaded');
end

