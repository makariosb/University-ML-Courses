%% a
clc;
clear;
close all;
A = [1 1 1; 2 2 2; 1 1 1];
B = [2 23 1; 4 6 3; 6 -26 5];

E = (A * B') * A' + B - A * B
F = (A .* B) + 3 * B
%% a3
A = [1 2 3 -9 5 6; 2 2 3 5 2 7; 1 4 1 3 1 1];
B = (A' * A) \ A' % ?

%% b
clc;
clear;
close all;

A = [5 -2 3 -1; 1 2 -3 0; -3 1 0 -2; 4 3 -1 5];
b = [6; 9; -1; -7];

x = A \ b

%% c
clc;
clear;
close all;

figure('Name', 'f(x) Plot')
ezplot('tan(1+exp(x^2))', [0, 1]);
figure('Name', 'g(x) Plot')
ezplot('x^3 + sin(x^2) + 5', [0, 1]);

%% d
clc; clear; close all;
file = fopen('data.dat', 'r');
A = [];

for i = 0:4
    temp = fscanf(file, '%d %d\n', [2, 5]);
    A = [A temp'];
end

fclose(file);
A

%% d2
clc;
close all;
figure('Name', 'Apeikoniseis');
n = 1;

for i = 1:2:8
    subplot(2, 2, n);
    scatter(A(:, i), A(:, i + 1))
    title(sprintf('Category %d', n));
    xlabel('x');
    ylabel('y');
    n = n + 1;
end

%% d3
clc;
close all;
figure('Name', 'Apeikoniseis Mazi');
n = 1;
markerz = ['d' '+' 'p' 'o'];

for i = 1:2:8
    scatter(A(:, i), A(:, i + 1), 'Marker', markerz(n))
    hold on
    n = n +1;
end

xlabel('x');
ylabel('y');
legend('Cat1', 'Cat2', 'Cat3', 'Cat4');

%% d4
clc;
close all;
cat = 1;

for i = 1:2:8
    figure('Name', sprintf('Categ %d', cat));
    cat = cat +1;
    n = 1;

    for j = 1:2:8

        if (j == i)
            continue
        end

        subplot(2, 2, n);
        scatter(A(:, i), A(:, i + 1), 'marker', 'x')
        hold on
        scatter(A(:, j), A(:, j + 1), 'marker', 'd')
        title(sprintf('with cat %d', (j + 1) / 2));
        n = n +1;
    end

end
