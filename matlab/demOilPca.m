% DEMOILPCA Model the oil data with PCA.

% GPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil';

% load data
[Y, lbls] = gplvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
options.prior.type = 'normuni';
options.prior = priorParamInit(options.prior);
numActive = 100;

% Initialise X with PCA.
X = gplvmPcaInit(Y, 2);

symbols = getSymbols(3);
figure, hold on
ax = axes('position', [0.05 0.05 0.9 0.9]);
hold on
for i = 1:size(X, 1)
  labelNo = find(lbls(i, :));
  plot(X(i, 1), X(i, 2), symbols{labelNo})
end
set(ax, 'fontname', 'arial');
set(ax, 'fontsize', 20);


capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName 'Pca.mat'], 'X');
