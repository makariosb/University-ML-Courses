clc; clear; close all;
%b = 1, g = 2
[x, c] = ReadIonosphere(351);
[Nchar, Npatterns] = size(x);
x1 = []; %paradeigmata b
x2 = []; %paradeigmata g

for i = 1:size(x, 2)

    if (c(i) == 1)
        x1 = [x1 x(:, i)];
    else
        x2 = [x2 x(:, i)];
    end

end

%% erwtima 2
pragm = [];
ideato = [];

for k = 1:100
    x1mean = KMeans(x1, 3, 1e-16);
    x2mean = KMeans(x2, 3, 1e-16);
    %% erwtima 3
    means = [x1mean x2mean];
    meanscat = [1 1 1 2 2 2];
    Rc = 0;

    for i = 1:Npatterns

        for j = 1:size(means, 2)
            dist(j) = (x(:, i) - means(:, j))' * (x(:, i) - means(:, j));
        end

        [mindist, argmin] = min(dist);

        if (meanscat(argmin) == c(i))
            Rc = Rc + 1;
        end

    end

    IdeatoMinError = (Npatterns - Rc) / Npatterns;
    %kathe fora diaforetiko afou kathe fora poy ftiaxnoyme kentra syglinei
    %se topiko elaxisto pou dimiourgeitai me vasi tyxaia arxika kentra

    %% erwtima 4
    x1vec = KMeansVector(x1, x1mean);
    x2vec = KMeansVector(x2, x2mean);

    %% erwtima 5
    vecs = [x1vec x2vec];
    meanscat = [1 1 1 2 2 2];
    Rc = 0;

    for i = 1:Npatterns

        for j = 1:size(vecs, 2)
            dist(j) = (x(:, i) - vecs(:, j))' * (x(:, i) - vecs(:, j));
        end

        [mindist, argmin] = min(dist);

        if (meanscat(argmin) == c(i))
            Rc = Rc + 1;
        end

    end

    PragmatikoMinError = (Npatterns - Rc) / Npatterns;

    pragm = [pragm PragmatikoMinError];
    ideato = [ideato IdeatoMinError];
end

ideatoMesoSfalma = mean(ideato)
pragmatikoMesoSfalma = mean(pragm)
