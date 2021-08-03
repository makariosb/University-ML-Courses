%1.b
%logos pithanofaneias f1(x1,x2)/f0(x1,x2)><1
clear;close all;load data;
labels = [zeros(1, 1e6) ones(1, 1e6)]; %classes of data (0-1)
testVecs = [x0_test x1_test];

%compute f0(x1,x2) for every vector [x1;x2] f0~N(0,1)
f0 = normpdf(testVecs, 0, 1);
f0 = f0(1, :) .* f0(2, :); %fi(x1,x1) = fi(x1) * fi(x2)

%compute f1(x1,x2) for every vector [x1;x2] f1~ 0.5 {N(1,1) + N(-1,1)}
f1 = 0.5 * (normpdf(testVecs, 1, 1) + normpdf(testVecs, -1, 1));
f1 = f1(1, :) .* f1(2, :);

%compute Likelihood Ratio
ratio = f1 ./ f0;
predictions = ratio >= 1; %if ratio>=1 => 1 else 0

plotconfusion(labels, predictions);
%correct 64.7% false 35.3%

%% 1.c Neural network training by pairs
clear;load data; %or load mnist

inputSize = size(x0_train, 1); %input vector rows
Neurons = 20; %hiddenLayer size
epochs = 10000;
Ntrain = min(size(x0_train, 2), size(x1_train, 2)); %number of training examples (pairs)
nn = makeNNstruct(inputSize, Neurons, 1);
Loss = zeros(Ntrain, 1);
meanLossPerEpoch = zeros(epochs, 1);
mu = 1e-3; %learning rate
costfun = 'exp';

for i = 1:epochs
    ind = randperm(Ntrain); %shuffle indexes
    Li = 1; %reset epoch loss vector index

    for j = ind
        outputs0 = calcLayerOut(nn, x0_train(:, j), costfun);
        [gradA0, grada0, gradB0, gradb0] = computeGradient(nn, x0_train(:, j), outputs0, 0, costfun);
        outputs1 = calcLayerOut(nn, x1_train(:, j), costfun);
        [gradA1, grada1, gradB1, gradb1] = computeGradient(nn, x1_train(:, j), outputs1, 1, costfun);
        %IMPORTANT change cost function according to costfun above
        %function definitions at the bottom of this script
        Loss(Li) = exponential(outputs0.u, outputs1.u);
        Li = Li + 1;
        nn.A = nn.A - mu * (gradA0 + gradA1);
        nn.a = nn.a - mu * (grada0 + grada1);
        nn.B = nn.B - mu * (gradB0 + gradB1);
        nn.b = nn.b - mu * (gradb0 + gradb1);
    end

    meanLossPerEpoch(i) = mean(Loss);
end

figure(1);
h = plot(meanLossPerEpoch, 'LineWidth', 2);
set(gca, 'FontSize', 16, 'FontWeight', 'bold')
xlabel('Epoch'); ylabel('Mean Loss');
%% evaluate predictions
labels = [zeros(1, size(x0_test, 2)) ones(1, size(x1_test, 2))]; %classes of data (0-1)
testVecs = [x0_test x1_test];
outputs = -1 * ones(1, size(testVecs, 2)); %neural net outputs

for i = 1:size(testVecs, 2)
    out = calcLayerOut(nn, testVecs(:, i), costfun);
    outputs(i) = out.u;
end

switch costfun %use appropriate threshold for each costfunction
    case 'ce' %cross entropy
        predictions = outputs >= 0.5;
    case 'exp' %exponential
        predictions = outputs >= 0;
    case 'hinge'
        predictions = outputs >= 0;
end

figure(2);
plotconfusion(labels, predictions);

%%
function [loss] = ce(u0, u1)
    loss = -log(1 - u0) + -log(u1);
end

function [loss] = exponential(u0, u1)
    loss = exp(0.5 * u0) + exp(-0.5 * u1);
end

function [loss] = hinge(u0, u1)
    loss = max(1 + u0, 0) + max(1 - u1, 0);
end
