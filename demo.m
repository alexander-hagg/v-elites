addpath(genpath('.'));
DOMAIN = 'npoly'; %npoly dropwave shubert4
rmpath(genpath('domain')); addpath(['domain/' DOMAIN]);

ALGORITHM = 'voronoi';
rmpath('grid'); rmpath('voronoi'); addpath(ALGORITHM);
% Load configuration of domain and V-Elites
d = domain;
p = defaultParamSet(4);

sobSequence         = scramble(sobolset(d.dof,'Skip',1e3),'MatousekAffineOwen');
sobPoint            = 1;
initSamples         = range(d.ranges).*sobSequence(sobPoint:(sobPoint+p.numInitSamples)-1,:)+d.ranges(1);
[fitness, values]   = d.fitfun(initSamples);

obsMap              = createMap(d.dof, p);
[replaced, replacement, features] = nicheCompete(initSamples, fitness, values, obsMap, d);
obsMap = updateMap(replaced,replacement,obsMap,fitness,initSamples,features);

profile on
[predMapRANDOM, ~, ~, ~, allMapsRANDOM] = illuminate(d.fitfun,obsMap,p,d);
profile off
profile viewer
%%

figure(2);viewDomainMap(predMapRANDOM,d);
%%
shapeScale = 1;
randScale = 10;
figure(3);viewDomainSimspace(predMapRANDOM,d,shapeScale,randScale);

%% GIF
filename = 'vElites.gif';
h = figure(1); clf;
for n=1:25:length(allMapsRANDOM)
    subplot(2,1,1);
    viewMap(allMapsRANDOM{n},d,1); title(['Random Map - Gen ' int2str(n)]); caxis(d.fitnessRange);
    %subplot(2,1,2);
    %viewMap(allMapsBIN{n},d,1); title(['Bin Map - Gen ' int2str(n)]); caxis(d.fitnessRange);
    drawnow;
    % Capture the plot as an image
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if n == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',0,'DelayTime',0.3);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime',0.3);
    end
end