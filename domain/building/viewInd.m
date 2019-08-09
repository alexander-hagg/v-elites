function viewInd(ind,d)

cppnParams = expressCppn(ind,d);
cppnFoil = ffdRaeY(cppnParams);
fPlot(cppnFoil,'LineWidth',3);hold on;
cntlPlot(cppnParams);
axis square; 
