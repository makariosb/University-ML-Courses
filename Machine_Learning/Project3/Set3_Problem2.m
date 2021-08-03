%%
clear;close all;
load('hw3-1data.mat');
labels = [ones(1, 100) 2 * ones(1, 100)];
%% Erwtima a
rng(31415); %for reproducibility
model = fitgmdist(X', 2, 'CovarianceType', 'full', ...
    'Options', statset('Display', 'final', 'MaxIter', 1000, 'TolFun', 1e-6), ...
    'Replicates', 10, 'Start', 'randSample');
mus = model.mu;
sigmas = model.Sigma;
w = model.ComponentProportion;
fprintf('------------\nAlgorithm converged after %d iterations with log-likelihood %0.2f\n', ...
    model.NumIterations, -model.NegativeLogLikelihood);

for i = 1:2
    fprintf('--Component %d--\nProportion: %0.4f\nMean: %d\n', i, w(i));
    disp(mus(i, :));
    disp('Covariance Matrix:');
    disp(sigmas(:, :, i));
end

% Predict
predLabelsA = model.cluster(X');
predLabelsAinv = not(predLabelsA - 1) + 1;

if (sum(labels == predLabelsA') < sum(labels == predLabelsAinv')) %adjust prediction labels
    predLabelsA = predLabelsAinv;
end

figure(1)
plotconfusion(labels - 1, predLabelsA' - 1);
figure(2);
plotPredictions(X, labels, predLabelsA');

%% Erwtima b
rng(31415); %for reproducibility
Mus = zeros(2, 2);
Sigmas = zeros(2, 2, 2);
Sigmas(:, :, 1) = rand() * eye(2);
Sigmas(:, :, 2) = rand() * eye(2);
modelB = gmdistribution(Mus, Sigmas, [0.5 0.5]);
datanorms = X(1, :) .* X(1, :) + X(2, :) .* X(2, :);
cost = log(prod(modelB.pdf(X'), 'all')); %total log-likelihood
prevcost = 0;
i = 0;

while abs(cost - prevcost) > 1e-6
    i = i + 1;
    prevcost = cost;
    q = modelB.posterior(X');
    qsum = sum(q, 1);
    Sigmas(:, :, 1) = datanorms * q(:, 1) * eye(2) / (2 * qsum(1));
    Sigmas(:, :, 2) = datanorms * q(:, 2) * eye(2) / (2 * qsum(2));
    modelB = gmdistribution(Mus, Sigmas, [0.5 0.5]);
    pdfvals = modelB.pdf(X');
    cost = sum(log(pdfvals), 'all');
end

fprintf('------------\nAlgorithm converged after %d iterations with log-likelihood %0.2f\n', ...
    i, cost);

for i = 1:2
    fprintf('--Component %d--\nProportion: %0.2f\n', i, 1/2);
    disp('Covariance Matrix:');
    disp(Sigmas(:, :, i));
end

% Predict
predLabelsB = modelB.cluster(X');
predLabelsBinv = not(predLabelsB - 1) + 1;

if (sum(labels == predLabelsB') < sum(labels == predLabelsBinv')) %adjust prediction labels
    predLabelsB = predLabelsBinv;
end

figure(1)
plotconfusion(labels - 1, predLabelsB' - 1);
figure(2);
plotPredictions(X, labels, predLabelsB');
