function ind = buildingBreed_example(d,nHidden)
%BUILDINGBREED_EXAMPLE Summary of this function goes here
%   Detailed explanation goes here

% Create Nodes
ind.nodes(1,:) = [1:(d.inputs+nHidden+d.outputs+1)];
% Bias, Inputs, Hidden,  Outputs
ind.nodes(2,:) = [4, ones(1,d.inputs), 3*ones(1,nHidden), 2*ones(1,d.outputs)]; 

acts = randi(length(d.actRange),1,nHidden);
ind.nodes(3,:) = [d.activations(1:1+d.inputs) d.actRange(acts) d.activations(d.outputs)];

% Create Connections
numberOfConnections = (d.inputs+1)*nHidden + nHidden*d.outputs;
ins = [1:d.inputs+1]; % IDs of input nodes
hiddens = max(ins) + (1:nHidden);
outs = d.inputs+1 + nHidden + [1:d.outputs];

ind.conns(1,:) = [1:numberOfConnections];
ind.conns(2,:) = [repmat(ins,1,length(hiddens)) repmat(hiddens,1,length(outs))];        % Once source for every destination
ind.conns(3,:) = [sort(repmat(hiddens,1,length(ins))) sort(repmat(outs,1,length(hiddens)))]'; % Destinations
ind.conns(4,:) = nan (1,numberOfConnections);       % Weights
ind.conns(5,:) = ones(1,numberOfConnections);       % Innovation Numbers


% Initialize struct values
ind.birth = 1;
ind.species = 0;
ind.aMat = [];
ind.wMat = [];

%% Create Population of base individuals with varied weights
nConns = length(ind.conns(4,:));
ind.conns(1,:) = 1:nConns;

rawWeight = randn(1, nConns);
rawWeight(rawWeight>d.weightCap) = d.weightCap;
rawWeight(rawWeight<-d.weightCap) = -d.weightCap;
ind.conns(4,:) = rawWeight;

%% Create Innovation Record
%innovation          = zeros(5,nConns);
%innovation(4,end)   = ind.nodes(1,end);
%innovation([1:3],:) = ind.conns([1:3],:);

end

