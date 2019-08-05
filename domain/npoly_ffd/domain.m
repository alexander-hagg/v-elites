function d = domain(dof)
%DOMAIN_NPOLY Get domain configuration for n-polygon
RandStream.setGlobalStream(RandStream('mt19937ar','Seed','shuffle')); % Random number stream
warning('off', 'MATLAB:MKDIR:DirectoryExists');
warning('off', 'MATLAB:polyshape:repairedBySimplify');

if strcmp(dof,'default')
    d.dof = 12; 
else
    d.dof = dof;
end

d.nDims                     = 2;
d.featureMin                = [0      1.75   0.2    0   0];
d.featureMax                = [2.75   6.5    2    0.3   1];
d.selectedFeatures          = [1    2];
d.featureLabels             = {'area','perimeter','maxspan','minspan','random'};
d.categorize                = 'categorize';
d.featureRes                = [40 40];
d.debug                     = false;
d.extraMapValues            = {'random'};
d.fitnessRange              = [0 1];

t = 0:2*pi/(d.dof/2):2*pi;
t(end) = [];
x1 = 0.5*cos(t);
y1 = 0.5*sin(t);
[theta,rho] = cart2pol(x1,y1);
d.base = [theta;rho];

d.fitfun                    = @(X) npolyObjective(X,d.base);

d.penaltyWeight             = 2;

d.ranges          = [-0.7 0.7];
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
d.description{5} = ['Fitness function: maximize radial symmetry.'];
end

