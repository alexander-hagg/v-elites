addpath(genpath('.'));
DOMAIN = 'dropwave'; %npoly
rmpath(genpath('domain')); addpath(['domain/' DOMAIN]);

ALGORITHM = 'vElites';
rmpath('mapElites'); rmpath('vElites'); addpath(ALGORITHM);
%% Load configuration of domain and V-Elites
d = domain;
p = defaultParamSet(4);

sobSequence         = scramble(sobolset(d.dof,'Skip',1e3),'MatousekAffineOwen');
sobPoint            = 1;
initSamples         = (2*sobSequence(sobPoint:(sobPoint+p.numInitSamples)-1,:))-1;
initSamples         = initSamples.*d.ranges;
[fitness, values]   = d.fitfun(initSamples);

obsMap              = createMap(d.dof, p.maxBins, p.competeDistance);
[replaced, replacement, features] = nicheCompete(initSamples, fitness, values, obsMap, d);
obsMap = updateMap(replaced,replacement,obsMap,fitness,initSamples,features);

%[acqMap, percImproved, percValid, h, allMaps] = vElites(d.fitfun,obsMap,p,d);
[predMap, ~, ~, ~, allMaps] = vElites(d.fitfun,obsMap,p,d);
%%
filename = 'vElites.gif';
h = figure(1); clf;
for n=1:25:length(allMaps)
    viewMap(allMaps{n},d,1); title(['Voronoi Map - Gen ' int2str(n)]); caxis(d.fitnessRange);
    drawnow;
    % Capture the plot as an image
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if n == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',1);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',1);
    end
end