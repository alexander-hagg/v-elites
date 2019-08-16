% demo - demo run of PRODUQD
%
% Computer Aided Ideation: Prototype Discovery using Quality-Diversity
%
% Please include the following references in any publication using this code. For Bibtex please see the end of this file.
%
%Hagg, A., Asteroth, A. and Bäck, T., 2018, September. Prototype discovery using quality-diversity. In International Conference on Parallel Problem Solving from Nature (pp. 500-511). Springer, Cham.
%Hagg, A., Asteroth, A. and Bäck, T., 2019, July. Modeling user selection in quality diversity. In Proceedings of the Genetic and Evolutionary Computation Conference (pp. 116-124). ACM.
%
% Author: Alexander Hagg
% Bonn-Rhein-Sieg University of Applied Sciences (HBRS)
% email: alexander.hagg@h-brs.de
% Aug 2019; Last revision: 16-Aug-2019

%------------- BEGIN CODE --------------
%% Configuration
clear;clc;
DOF = 16;
DOMAIN = 'npoly_ffd';
ALGORITHM = 'grid'; % 'grid', 'voronoi'
nIters = 2;
nPrototypes = 10;

addpath(genpath('.'));
iter = 1; app.selectedPrototypes = {}; app.constraints = {}; app.d = {}; app.p = {};
rmpath(genpath('domain')); addpath(genpath(['domain/' DOMAIN]));
app.d{iter} = domain(DOF);

rmpath('QD/grid'); rmpath('QD/voronoi'); addpath(['QD/' ALGORITHM]);
app.p{iter} = defaultParamSet(4);

% Initialize samples
sobSequence         = scramble(sobolset(app.d{iter}.dof,'Skip',1e3),'MatousekAffineOwen');
sobPoint            = 1;
initSamples         = range(app.d{iter}.ranges).*sobSequence(sobPoint:(sobPoint+app.p{iter}.numInitSamples)-1,:)+app.d{iter}.ranges(1);
fitfun = @(x) objective(x,app.d{iter}.fitfun,[],app.p{iter}.penaltyWeight,app.p{iter}.driftThreshold);

%% Main loop
for iter=1:nIters
    if ~isempty(app.constraints)
        disp(['Adding constraints to the fitness function']);  
        fitfun = @(x) objective(x,app.d{iter}.fitfun,app.constraints,app.p{iter}.penaltyWeight,app.p{iter}.driftThreshold);
        initSamples = [];
        for it1=1:length(app.constraints)
            initSamples = [initSamples; app.constraints{it1}.members];
        end
    end
    
    % Illumination with QD
    disp(['Illumination']);  
    [fitness, values, phenotypes]       = fitfun(initSamples); %
    obsMap                              = createMap(app.d{iter}, app.p{iter});
    [replaced, replacement, features]   = nicheCompete(initSamples, fitness, phenotypes, obsMap, app.d{iter}, app.p{iter});
    obsMap                              = updateMap(replaced,replacement,obsMap,fitness,initSamples,values,features,app.p{iter}.extraMapValues);
    [app.map{iter}, ~, ~, ~, ~]     = illuminate(fitfun,obsMap,app.p{iter},app.d{iter});
    
    % Extract prototypes
    disp(['Similarity space and prototype extraction']);    
    [app.classification{iter}, simspace] = extractClasses(app.map{iter}.genes,[],'kmedoids',nPrototypes);
        % Show classes in similarity space
        figure(3);figHandle=axes;viewClasses(app.map{iter}.genes,app.classification{iter},figHandle);
        % Show prototypes
        numRows = ceil( size(app.classification{iter}.protoX,1).^(2/3) );
        for i=1:size(app.classification{iter}.protoX,1)
            placement(i,:) = [mod(i-1,numRows) floor((i-1)/numRows)]*app.d{iter}.spacer;
        end
        figure(4);figHandle=axes;
        showPhenotype(figHandle,app.d{iter},app.classification{iter}.protoX,placement);
    
    % Selection procedure
    prompt = 'Please select a prototype by entering an integer ID: ';
    app.selectedPrototypes{iter} = input(prompt);
    % Create UDHM based on selected prototypes
    if length(app.selectedPrototypes) >= iter && ~isempty(app.selectedPrototypes{iter})
        app.constraints{iter} = setConstraints(app.classification{iter},app.selectedPrototypes{iter},[],'class');
        iter = iter + 1;        
        % Initialize configuration for next iteration
        app.d{iter} = app.d{iter-1};
        app.p{iter} = app.p{iter-1};
        % Show selection history
        %cla(app.UIAxes6);
        %app.showHistory(app.UIAxes6);
        %cla(app.UIAxes5_2);
        %app.showHistory(app.UIAxes5_2);
    end
end
%------------- END CODE --------------
