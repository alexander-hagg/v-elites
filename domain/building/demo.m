
%------------- BEGIN CODE --------------


d = buildingBreed_Domain;
%d.weightCap = 2;

nHidden = 5;
ind = buildingBreed_example(d,nHidden);

%
fig(1) = figure(1);hold off;

drawBuilding(ind,d);

view(-70,10);

axis([-1 d.substrateDims(1)+1 -1 d.substrateDims(2)+1 -1 d.substrateDims(3)+1]);
ax.FontSize = 16;
grid on;


%%

%fig(1).Renderer = 'painters';
save2pdf([pdfFileName],fig(1),300);



%%


%% Change domain and hyperparameters
% addAllToPath; d = swingUp_Domain;
% p.maxGen = 50;    % Let's not make this demo last too long
% matNeat(p,d);
%
% %% Run NEAT experiments on single computer
% addAllToPath; d = twoPole_Domain;
% p1 = matNeat;  % Calling without arguments will return default parameters
% p1.displayMod = 0; % Don't waste time plotting
% p1.name = 'default';
%
% % Create another set of hyperparameters
% p2 = p1;
% p2.addConnProb = p2.addConnProb/2;
% p2.addNodeProb = p2.addNodeProb/2;
% p2.mutConnProb = p2.mutConnProb/2;
% p2.name = 'halfMut';
%
% % Run multiple experiments and save results
% nExp = 3;
% for iExp = 1:nExp
%     rec1(iExp) = matNeat(p1,d); %#ok<SAGROW>
%     rec2(iExp) = matNeat(p2,d); %#ok<SAGROW>
% end
% save('data.mat','p1','p2','rec1','rec2') % Save data for analyis
%
% %% Run NEAT experiments on cluster
% % Save hyperparameter and domain structs to file
% d = twoPole_Domain;
% p = p1; save([p.name '.mat'], 'p','d');
% p = p2; save([p.name '.mat'], 'p','d');
%
% % Run this function through your clusters scheduler, it will save the
% % results to disk when the experiment is completed.
% % e.g.: qsub -N NeatExperiment -v hypName=halfMut,jobID=1 sb_hpc_neat.sh
% hpc_neat(p1.name,'1')

%% Run using OpenAI gym domains
% OpenAI Gym environments can be used through an http interface, though it
% is quite slow. When/if MuJuCo begins supporting MATLAB natively this
% can be fixed. For now, follow the installation instructions on:
%   https://github.com/openai/gym
%   https://github.com/openai/gym-http-api
%   https://github.com/openai/mujoco-py
%
% Once installed, before starting optimization in MATLAB you must first
% start a http server. In a terminal from the halfCheetah_src folder run:
%   python gym_http_server.py
%
% Then continue normally:
% addAllToPath; d = halfCheetah_Domain;
% matNeat(p,d);

%------------- END OF CODE --------------