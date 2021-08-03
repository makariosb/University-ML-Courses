clc; clear; close all;
% c=1 ygeia c=2 oxi ygeia
[x, c] = ReadDiabetes(768);
[Nchars, Npatterns] = size(x);
x1 = x(:, c == 1);
x2 = x(:, c == 2);

%% Erwtima 2-3

[Rc, Rep, W] = HoKa(x1, x2, 0.01, 10000);
% Vari
W
%Sfalma
err = 1 - sum(Rc) / sum(Rep)

%% Erwtima 4
close all; clc;
rates = linspace(0.1, 4, 30);
LrError = zeros(1, length(rates));
Nreps = 10;
tempError = zeros(1, Nreps);

for i = 1:length(rates)

    for j = 1:Nreps
        [Rc, Rep] = HoKa(x1, x2, rates(i), 800);
        tempError(j) = 1 - sum(Rc) / sum(Rep);
    end

    LrError(i) = mean(tempError);
end

figure('name', 'Error = f(Lr)');
scatter(rates, LrError);
xlabel('Lr');
ylabel('Error');
%%
rates = linspace(0.1, 2, 10);
Nloops = zeros(1, length(rates));
Nreps = 5;
NloopsTemp = zeros(1, Nreps);

for i = 1:length(rates)
    fprintf('calculating lr = %1.2f\n', rates(i));

    for j = 1:Nreps
        NloopsTemp(j) = TestLr(x1, x2, 0.2267, rates(i), 500);
    end

    Nloops(i) = ceil(mean(NloopsTemp));
end

figure('name', 'Nloops = f(Lr)');
scatter(rates, Nloops);
xlabel('Lr');
ylabel('Nloops');
