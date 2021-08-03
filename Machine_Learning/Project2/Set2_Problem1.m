%% Create data
data = rand(1, 1000);
save('problem1_data');
%% Using the Gaussian Kernel
load problem1_data.mat; close all;

x = linspace(-1, 2, 2000); %points to evaluate the pdf at
ideal_pdf_values = x >= 0 & x <= 1;
h = [1e-1, 1e-2, 1e-3, 1e-4];
pdf_values = zeros(length(h), length(x));

for i = 1:length(h)
    pdf_values(i, :) = approx_pdf(data, x, h(i), @K_gauss);
end

figure(1)
plot(x, ideal_pdf_values, 'LineWidth', 2);
hold on;
plot(x, pdf_values', 'LineWidth', 2);
xlabel('x'); ylabel('f(x)'); legend([{'ideal'}, compose('h = %g', h)]);
hold off;
%% Using the Laplacian Kernel
load problem1_data.mat; close all;

x = linspace(-1, 2, 2000); %points to evaluate the pdf at
ideal_pdf_values = x >= 0 & x <= 1;
h = [5e-1, 1e-1, 5e-2, 1e-2];
pdf_values = zeros(length(h), length(x));

for i = 1:length(h)
    pdf_values(i, :) = approx_pdf(data, x, h(i), @K_laplace);
end

figure(1)
plot(x, ideal_pdf_values, 'LineWidth', 2);
hold on;
plot(x, pdf_values', 'LineWidth', 2);
xlabel('x'); ylabel('f(x)'); legend([{'ideal'}, compose('h = %g', h)]);
hold off;
%% Function Definitions
function pdf_values = approx_pdf(realisations, x, h, kern_funct)
    pdf_values = zeros(1, length(x));

    for i = 1:length(x)
        dif = x(i) - realisations;
        dif = kern_funct(dif, h);
        pdf_values(i) = mean(dif);
    end

end

function [K] = K_gauss(x, h)
    K = exp(-x.^2 / (2 * h)) / sqrt(2 * pi * h);
end

function [K] = K_laplace(x, h)
    K = exp(-abs(x) / h) / (2 * h);
end
