load hw2 - 2data.mat;
x = [stars; circles]';
%target values of fbar
labels = [ones(length(stars), 1); -ones(length(circles), 1)];
h = 1;
lambda = 10;

K_matrix = zeros(length(x));

for i = 1:length(x)

    for j = 1:length(x)
        K_matrix(i, j) = K_gauss(x(:, i), x(:, j), h);
    end

end

%Loss minimisation optimal coefficients
ysum = zeros(1, size(x, 2));

for i = 1:length(x)
    ysum = ysum + labels(i) * K_matrix(i, :);
end

coeffs = ysum / (K_matrix * K_matrix + lambda * K_matrix);
coeffs = coeffs';

%% PLOT CURVE
mins = min(x, [], 2);
maxs = max(x, [], 2);
x1_range = linspace(mins(1), maxs(1), 200)';
x2_range = linspace(mins(2), maxs(2), 1000)';
x2_opt = zeros(length(x1_range), 1);
tmp = zeros(length(x2_range), 1);

for i = 1:length(x1_range)

    for j = 1:length(x2_range)
        tmp(j) = Fbar([x1_range(i); x2_range(j)], x, coeffs, h);
    end

    [~, index] = min(abs(tmp));
    x2_opt(i) = x2_range(index);
end

close all
scatter(stars(:, 1), stars(:, 2), 66, '*');
hold on;
scatter(circles(:, 1), circles(:, 2), 66);
plot(x1_range, x2_opt, 'LineWidth', 0.5, 'Color', 'k');
title(sprintf('h = %d \nλ = %g', h, lambda)); xlabel('x_1'); ylabel('x_2');
xlim([mins(1) maxs(1)]); ylim([mins(2) maxs(2)]);

%% Function definitions
function y = Fbar(x, known_points, coeffs, h)
    y = coeffs' * K_gauss(x, known_points, h);
end

function [K] = K_gauss(x, y, h)
    % y = known realisations, x = vector to evaluate Gaussian kernel at
    dif = x - y;
    K = zeros(size(dif, 2), 1);

    for i = 1:size(dif, 2)
        K(i) = exp(-dif(:, i)' * dif(:, i) / h);
    end

end
