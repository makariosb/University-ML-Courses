function [Alphabet] = KMeansVector(Vector, Alphabet)
    % Determine Alphabet of Vectors
    Npatterns = size(Vector, 2);
    KM = size(Alphabet, 2);

    for i = 1:KM
        Dist = zeros(1, Npatterns);

        for j = 1:Npatterns
            Dist(j) = (Vector(:, j) - Alphabet(:, i))' * (Vector(:, j) - Alphabet(:, i));
        end

        mindex = ArgMin(Dist);
        Alphabet(:, i) = Vector(:, mindex);
        Vector(:, mindex) = []; %remove selected vector
        Npatterns = Npatterns -1;
    end
