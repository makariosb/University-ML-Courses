clc; clear; close all;
%Erwtima 1
[x, c] = ReadWine(178);
% Erwtima 2
m = mean(x, 2);
s = sqrt(var(x, 0, 2));

for i = 1:size(x, 2)
    x(:, i) = (x(:, i) - m) ./ s;
end

%[Recs,Sums,hidweights,outweights] = MlpEbp1LBias(x,c,5,0.1,1e4,1e3);
%sfalma = 100 - Recs(end)
% Erwtima 3
Lr = linspace(1e-2, 1, 100);
corr = [];
epochs = [];

for i = 1:length(Lr)
    [Recs, Sums] = MlpEbp1LBias(x, c, 5, Lr(i), 1e4, 1000);
    corr(i) = Recs(1, end);
    epochs(i) = length(Recs);
end

figure()
plot(Lr, 100 - corr);
ylabel('% Error'); xlabel('Lr'); title('%Error = f(Lr)');

figure()
plot(Lr, epochs * 1e3);
ylabel('Iterations'); xlabel('Lr'); title('Iterations until Convergence');
