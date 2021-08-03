%In this script there are the bits of code that were used for
%Problem 1 data generation and Problem 2 data cleaning/formatting.
%%
%x1~N(0,1)
x1_test = randn(2, 1e6);
x1_train = randn(2, 200);

%x2~ 0.5 {N(1,1) + N(-1,1)}
x2_test = [];

for i = 1:1e6

    if rand() < 0.5 %me pithanotita 0.5
        x2_test = [x2_test randn(2, 1) * 1 + 1]; %N(1,1)
    else
        x2_test = [x2_test randn(2, 1) * 1 - 1]; %N(-1,1)
    end

end

x2_train = [];

for i = 1:200

    if rand() < 0.5 %me pithanotita 0.5
        x2_train = [x2_train randn(2, 1) * 1 + 1]; %N(1,1)
    else
        x2_train = [x2_train randn(2, 1) * 1 - 1]; %N(-1,1)
    end

end

%% save problem 1 dataset
save('data', 'x*');
%% MNIST Import
%read files and normalize data
[trainImgs, trainLabels] = readMNIST('train-images.idx3-ubyte', 'train-labels.idx1-ubyte', 60e3, 0);
[testImgs, testLabels] = readMNIST('t10k-images.idx3-ubyte', 't10k-labels.idx1-ubyte', 10e3, 0);

%%
%reshape to 784x1 vectors
trainImgs = reshape(trainImgs, 28 * 28, 60e3);
testImgs = reshape(testImgs, 28 * 28, 10e3);
%keep 0 and 8 only
x0_test = testImgs(:, testLabels == 0);
x0_train = trainImgs(:, trainLabels == 0);
x1_test = testImgs(:, testLabels == 8);
x1_train = trainImgs(:, trainLabels == 8);
%% save problem 2 dataset
save('mnist', 'x*');
%% plot data histograms
clear;load data;
histogram(x0_test, 'Normalization', 'pdf')
hold on;
histogram(x1_test, 'Normalization', 'pdf')
