% DEMTWOS1 Model the twos data with a 2-D RBF GPLVM with Gaussian noise.

% GPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'twos';
experimentNo = 1;

% load data
[Y, lbls] = gplvmLoadData(dataSetName);

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

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'image', [8 8], 1, 1, 1)

% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'image', [8 8], 1, 1, 1)

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')
