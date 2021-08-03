function [Rc, Ru] = Errors(Mean, x, c)
    %ERRORS Summary of this function goes here
    %   Detailed explanation goes here

    %%% Rc Computation
    [Nchar, Npatterns] = size(x);
    Nclasses = max(c);
    Rc = zeros(Nclasses, 1);

    for i = 1:Npatterns

        for j = 1:Nclasses
            Dist(j) = (x(:, i) - Mean(:, j))' * (x(:, i) - Mean(:, j)); %square apoklisi apo mesi
        end

        Rec = ArgMin(Dist);

        if (Rec == c(i))
            Rc(Rec) = Rc(Rec) + 1;
        end

    end

    %%% Ru Computation (leaving one out)
    Ru = zeros(Nclasses, 1);

    for j = 1:Npatterns
        tempx = [];
        tempc = [];

        if (j == 1)
            tempx = x(:, 2:end);
            tempc = c(:, 2:end);
        elseif (j == Npatterns)
            tempx = x(:, 1:(end - 1));
            tempc = c(:, 1:(end - 1));
        else
            tempx = [x(:, 1:(j - 1)) x(:, (j + 1):end)];
            tempc = [c(:, 1:(j - 1)) c(:, (j + 1):end)];
        end

        tempmean = ProtypoDianysma(tempx, tempc); %ypolog. protypa dianysmatwn xwris stoixeio xi
        k = c(j); %correct class
        %Mt = Mean(:,k) ;
        for i = 1:Nclasses
            Dist(i) = (x(:, j) - tempmean(:, i))' * (x(:, j) - tempmean(:, i));
        end

        Rec = ArgMin(Dist);

        if (Rec == k)
            Ru(Rec) = Ru(Rec) + 1;
        end

        %Mean(:,k) = Mt ;
    end

end
