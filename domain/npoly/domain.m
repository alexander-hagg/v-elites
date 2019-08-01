function d = domain()
%DOMAIN_NPOLY Get domain configuration for n-polygon
RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle')); % Random number stream
warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'MATLAB:polyshape:repairedBySimplify');

d.nDims                     = 2;
d.featureMin                = [0    1];
d.featureMax                = [0.7    3];
d.selectedFeatures          = [1    2];
d.featureLabels             = {'area','perimeter','random'};
d.categorize                = 'categorize';
d.featureRes                = [40 40];
d.debug                     = false;
d.extraMapValues            = {'random'};
d.fitnessRange              = [0 1];
d.fitfun                    = @(X) npolyObjective(X);

d.penaltyWeight             = 0.5;
d.maxPenaltyWeight          = 10;

disp(['Penalty weight: ' num2str(d.penaltyWeight)]);

d.dof = 6;
d.tmpdir = getenv('JOBTMPDIR'); if isempty(d.tmpdir); d.tmpdir='/tmp';end
disp(['tmp dir: ' d.tmpdir]);
mkdir(d.tmpdir);


d.ranges          = [-1 1];
d.evalFcn         = @(samples) eval_maze(samples, d, false);
d.validate        = 'validateChildren';
d.flipMap = true;

d.spacer = 2;

%% Individual's genome and phenotype
d.sampleInd.genome    = nan(d.dof,1);


d.description{1} = ['N-poly domain'];
d.description{2} = '';
d.description{3} = ['Description:      n-polygons, with n currently set to ' int2str(d.dof)];
d.description{4} = ['Representation:   sequence of (x,y) pairs.'];
d.description{5} = ['Fitness function: minimize number of holes and disconnected components.'];
end

