% Configuration
DOF = 16;
DOMAIN = 'npoly_ffd';
ALGORITHM = 'grid'; % 'grid', 'voronoi'
NITERS = 2;

addpath(genpath('.'));
app.iter = 1; app.selectedPrototypes = {}; app.constraints = {}; app.d = {}; app.p = {};
rmpath(genpath('domain')); addpath(genpath(['domain/' DOMAIN]));
app.d{app.iter} = domain(DOF);

rmpath('QD/grid'); rmpath('QD/voronoi'); addpath(['QD/' ALGORITHM]);
app.p{app.iter} = defaultParamSet(4);

for iter=1:NITERS
    app.iter = iter;
    if isempty(app.constraints)
        app.fitfun = @(x) objective(x,app.d{app.iter}.fitfun,[],app.p{app.iter}.penaltyWeight,app.p{app.iter}.driftThreshold);
    else
        app.fitfun = @(x) objective(x,app.d{app.iter}.fitfun,app.constraints{app.iter},app.p{app.iter}.penaltyWeight,app.p{app.iter}.driftThreshold);
    end
    
    if isempty(app.constraints)
        sobSequence         = scramble(sobolset(app.d{app.iter}.dof,'Skip',1e3),'MatousekAffineOwen');
        sobPoint            = 1;
        initSamples         = range(app.d{app.iter}.ranges).*sobSequence(sobPoint:(sobPoint+app.p{app.iter}.numInitSamples)-1,:)+app.d{app.iter}.ranges(1);
    else
        % Get seeds
        initSamples = [];
        for it1=1:length(app.constraints)
            initSamples = [initSamples; app.constraints{it1}.members];
        end
    end
    [fitness, values, phenotypes]   = app.fitfun(initSamples);
    
    obsMap              = createMap(app.d{app.iter}, app.p{app.iter});
    [replaced, replacement, features] = nicheCompete(initSamples, fitness, phenotypes, obsMap, app.d{app.iter}, app.p{app.iter});
    obsMap              = updateMap(replaced,replacement,obsMap,fitness,initSamples,values,features,app.p{app.iter}.extraMapValues);
    [app.map{app.iter}, ~, ~, ~, ~] = illuminate(app.fitfun,obsMap,app.p{app.iter},app.d{app.iter});
end