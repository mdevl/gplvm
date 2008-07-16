% DEMSWISSROLL1 Model the face data with a 2-D GPLVM.

% GPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'swissRoll';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
numActive = 100;

% Fit the GP latent variable model
noiseType = 'gaussian';
selectionCriterion = 'entropy';
kernelType = {'rbf', 'bias', 'white'};
model = gplvmFit(Y, 2, options, kernelType, noiseType, selectionCriterion, numActive, lbls);

% Save the results.
[X, kern, noise, ivmInfo] = gplvmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

% Display results
gplvmScatterPlotColor(model, model.y(:, 2));