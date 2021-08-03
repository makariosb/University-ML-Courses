clc; clear; close all;
% c=1 ygeia c=2 oxi ygeia
[x, c] = ReadLiver(345);
[Nchars, Npatterns] = size(x);
x1 = x(:, c == 1);
x2 = x(:, c == 2);

%% Erwtima 2-3
%afou kathe fora pou to trexoume ksekina apo diaforetikoys random
%syntelestes kai pote den bgainei me to break (dioti den einai grammikws
%diaxwrisima ta deigmata pou exoume), einai tyxaio to pososto epityxias pou
%tha exei analoga me to poses max epanalipseis tou exoume dwsei.
[Rc, Rep, W] = Perceptron(x1, x2, 0.1, 1500);
% Vari
W
%Sfalma
err = 1 - Rc / Rep

%% Erwtima 4
close all; clc;
rates = linspace(0.1, 2, 40);
LrError = zeros(1, length(rates));
Nreps = 10;
tempError = zeros(1, Nreps);

for i = 1:length(rates)

    for j = 1:Nreps
        [Rc, Rep] = Perceptron(x1, x2, rates(i), 150);
        tempError(j) = 1 - Rc / Rep;
    end

    LrError(i) = min(tempError);
end

figure('name', 'Error = f(Lr)');
scatter(rates, LrError);
xlabel('Lr');
ylabel('Error');
%%
rates = linspace(0.1, 2, 40);
Nloops = zeros(1, length(rates));
Nreps = 10;
NloopsTemp = zeros(1, Nreps);

for i = 1:length(rates)

    for j = 1:Nreps
        NloopsTemp(j) = TestLr(x1, x2, 0.30, rates(i), 50000);
    end

    Nloops(i) = min(NloopsTemp);
end

figure('name', 'Nloops = f(Lr)');
scatter(rates, Nloops);
xlabel('Lr');
ylabel('Nloops');
