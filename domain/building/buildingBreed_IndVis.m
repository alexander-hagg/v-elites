function buildingBreed_IndVis(ind,p,d)
%swingUp_indVis - Visualize individual performance in swing-up domain
%
%
% Syntax:  dswingUp_indVis(ind)
%
% Author: Adam Gaier
% Bonn-Rhein-Sieg University of Applied Sciences (BRSU)
% email: adam.gaier@h-brs.de
% Dec 2017; Last revision: 05-Dec-2017

%------------- Input Parsing ------------

%------------- BEGIN CODE --------------

%% Elite Surface Approximation
[fitness, output] = buildingBreed_test(ind.wMat, ind.aMat, p, d);
subplot(3,2,[1 2 3 4]);
hold off;
h = buildingBreed_Mesh(output);
grid on; material metal; alpha('color'); alphamap('rampup');    
view(30,30);hold off;axis equal; axis tight; title('CPPN Output'); caxis([0 1])
axis([1 1+d.substrateDims(1) 1 1+d.substrateDims(2) 1 1+d.substrateDims(3)]);

%% Elite Network
subplot(3,2,6);
G = digraph(ind.wMat);
h = plot(G,'Layout','layered','Direction','right','Sources',1:d.inputs+1);
h.NodeLabel(1:4) = {'Bias', 'X', 'Y', 'Z'};
h.NodeLabel(end) = {'Output'};
yticks('');xticks('');
title('ANN');

%------------- END OF CODE --------------
