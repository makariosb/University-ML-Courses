function [Rc, Ru, Mean] = ProtypoDian(x, c)
    %#
    %#  [Rc,Ru,Rep] = ClassMinDistEuclOne(x,c)
    %#  Pattern Recognition:
    %#      Distance measure:      Euclidian
    %#      Prototypes:            One Center
    %#      Classification rule:   Minimum Distance
    %#
    %#  Input
    %#      x: Pattern Vectors
    %#      c: Classes
    %#  Output
    %#      Rc: Correct classification rate using the C-method
    %#      Ru: Correct classification rate using the U-method
    %#      Rep:Number of Pattern vectors on each class
    %#

    NumOfClass = max(c);
    NumOfPatterns = size(x, 2); %columns(x) ;
    Mean = zeros(size(x, 1), NumOfClass); % Ncharacteristics x Nclasses
    Rep = zeros(NumOfClass, 1);

    %#
    %#  Mean
    %#

    Rc = zeros(NumOfClass, 1);

    for j = 1:NumOfPatterns
        k = c(j);
        Rep(k, 1) = Rep(k, 1) + 1;
        Mean(:, k) = Mean(:, k) + x(:, j);
    end

    for j = 1:NumOfClass
        Mean(:, j) = Mean(:, j) / Rep(j, 1);
    end

    %Pick Vectors
    for j = 1:Npatterns

        for i = 1:NumofClass
            Dist(i)
        end

    end

    %#
    %#  C-Error
    %#

    for i = 1:NumOfPatterns

        for j = 1:NumOfClass
            Dist(j) = (x(:, i) - Mean(:, j))' * (x(:, i) - Mean(:, j)); %square apoklisi apo mesi
        end

        Rec = ArgMin(Dist);

        if (Rec == c(i))
            Rc(Rec) = Rc(Rec) + 1;
        end

    end

    %#
    %#  U-Error
    %#

    Ru = zeros(NumOfClass, 1);

    for j = 1:NumOfPatterns
        k = c(j);
        Mt = Mean(:, k);
        Mean(:, k) = Rep(k, 1) / (Rep(k, 1) - 1) * (Mean(:, k) - x(:, j) / Rep(k, 1)); %to mean xwris to xj

        for i = 1:NumOfClass
            Dist(i) = (x(:, j) - Mean(:, i))' * (x(:, j) - Mean(:, i));
        end

        Rec = ArgMin(Dist);

        if (Rec == k)
            Ru(Rec) = Ru(Rec) + 1;
        end

        Mean(:, k) = Mt;
    end
