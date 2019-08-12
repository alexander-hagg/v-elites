function drawBuilding(arch,d)
%% DRAWBUILDING
    
ind = express(arch);
[~, output] = buildingBreed_test(ind.wMat, ind.aMat, d);
buildingBreed_Mesh(output);

material dull;
view(-30,30);

lighting flat;
light('Position',[0 0 70],'Style','infinite');
camlight('right');



%% END CODE
end
