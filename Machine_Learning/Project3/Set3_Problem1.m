clear;close all;
load('hw3-1data.mat');
labels = [ones(1, 100) 2 * ones(1, 100)];
%% Erwtima a
rng(31415);
predLabelsA = kmeans(X', 2, 'Display', 'final', ...
    'EmptyAction', 'error', 'MaxIter', 1000, ...
    'Replicates', 10, 'Start', 'sample');

figure(1);
plotconfusion(labels - 1, predLabelsA' - 1);
figure(2);
plotPredictions(X, labels, predLabelsA');
%% Erwtima b
rng(31415);
X_augmented = [X; X(1, :) .* X(1, :) + X(2, :) .* X(2, :)];
predLabelsB = kmeans(X_augmented', 2, 'Display', 'final', ...
    'EmptyAction', 'error', 'MaxIter', 1000, ...
    'Replicates', 10, 'Start', 'sample');

figure(1);
plotconfusion(labels - 1, predLabelsB' - 1);
figure(2);
plotPredictions(X, labels, predLabelsB');
