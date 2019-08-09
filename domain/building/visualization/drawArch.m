function drawArch(archCellArray,p,d,resolutions)
%% DRAW ARCH


%% START CODE


[~,idMaxRes] = max(resolutions);
idMaxRes = idMaxRes(1);

% Draw all resolutions
for iRes=1:size(resolutions,1)
    
    d.substrateDims = resolutions(iRes,:);
    offsetArch      = resolutions(idMaxRes,1) * 2;
    offsetZ         = ceil(  (iRes-1) .* resolutions(idMaxRes,1) * 1.0  );
    
    scalingToMax = max(resolutions(:))./resolutions(iRes,1);

    % Draw ground level ONCE
    %if iRes==idMaxRes
        groundMesh = ones(ceil(sqrt(length(archCellArray)))*offsetArch, ceil(sqrt(length(archCellArray)))*offsetArch, 2);
        thisOffset = (iRes-1)*(offsetZ);
        if iRes > 1; thisOffset = thisOffset + offsetArch;end
        buildingBreed_Mesh(groundMesh     ,[0 0 -2+thisOffset] );
        hold on; % KEEP THIS
    %end
    
    % Draw arch buildings
    for i = 1:length(archCellArray)
        ind = express(archCellArray{i}.members(1));
        [~, output] = buildingBreed_test(ind.wMat, ind.aMat, p, d);
        hold on; % KEEP THIS
        
        % Scale output to match largest resolution!
        output = repelem(output,scalingToMax,scalingToMax,scalingToMax);
        
        output(output(:)~=0) = output(output(:)~=0) + 1;
        
        startOffset =   [0                                            0                           offsetZ] + ...
            [(mod(i,ceil(sqrt(length(archCellArray)))))*offsetArch    0                           offsetZ] + ...
            [0                                (ceil(i/sqrt(length(archCellArray)))-1)*offsetArch  offsetZ];
        
        buildingBreed_Mesh(output,startOffset);
    end
    drawnow;
end

% Set colors and materials
numMaterials = length(unique(output(:))+1);
colorMap = parula(numMaterials+1);
colorMap(1,:) = [0 1 0];
colorMap(2,:) = [0.3 0.3 0.3];
colorMap(3,:) = [0.3 0.3 0.3];
colormap(colorMap);
material dull;% alpha('color'); alphamap('rampup');

%ax = gca; axis equal; axis tight;
view(-30,30);

lighting flat;
light('Position',[0 0 70],'Style','infinite');
camlight('right');



%% END CODE
end
