function [Mean2] = ProtypoDianysma(x, c)

    [Nchar, Npatterns] = size(x);
    Nclasses = max(c);
    Mean2 = zeros(Nchar, Nclasses);

    for k = 1:Nclasses
        classx = [];

        for j = 1:Npatterns

            if (c(j) == k)
                classx = [classx x(:, j)];
            end

        end

        if (isempty(classx))
            Mean2(:, k) = nan(Nchar, 1);
            continue;
        end

        dist = [];

        for i = 1:size(classx, 2)
            tempdist = 0;

            for j = 1:size(classx, 2)
                tempdist = tempdist + (classx(:, i) - classx(:, j))' * (classx(:, i) - classx(:, j));
            end

            dist(i) = tempdist;
        end

        Mean2(:, k) = classx(:, ArgMin(dist));
    end

end
