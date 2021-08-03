function [Nloops] = TestLr(x1, x2, TargetError, Lr, MaxRep)
    %Returns the Number of loops required to get a Target ErrorRate
    % % currError = 1;
    % % Nloops = 100;
    % % while(1)
    % %     [Rc,Rep] = Perceptron(x1,x2,Lr,Nloops);
    % %     currError = 1-Rc/Rep;
    % %     if (currError<=TargetError)
    % %         break
    % %     end
    % %     Nloops = Nloops + 50;
    % % end

    NumOfP1 = columns(x1);
    NumOfP2 = columns(x2);
    Weights = 2 * rand(rows(x1) + 1, 1) - 1;
    Rep = [NumOfP1, NumOfP2];
    TotPat = sum(Rep);
    Rc = zeros(2, 1);

    if (rows(x1) ~= rows(x2))
        printf('Error in vectors x1, x2\n');
    end

    %#
    %#  C-Error
    %#
    baseLr = Lr;

    for j = 1:MaxRep

        if (rand() > 0.5)
            k = floor(rand() * NumOfP1 + 1);
            Pat = [x1(:, k); 1];
            Score = Weights' * Pat;
            %an anikei sthn cat1 tote prepei score>=0
            if (Score < 0)
                Weights = Weights + Lr * Pat;
            end

        else
            k = floor(rand() * NumOfP2 + 1);
            Pat = [x2(:, k); 1];
            Score = Weights' * Pat;
            %an anikei sthn cat2 tote prepei score<0
            if (Score >= 0)
                Weights = Weights - Lr * Pat;
            end

        end

        Rc = zeros(2, 1);

        for i = 1:NumOfP1

            if (Weights' * [x1(:, i); 1] >= 0)
                Rc(1) = Rc(1) + 1;
            end

        end

        for i = 1:NumOfP2

            if (Weights' * [x2(:, i); 1] < 0)
                Rc(2) = Rc(2) + 1;
            end

        end

        %disp(sprintf( '%8d', sum(Rc) ));
        %fflush(stdout) ;
        if (1 - sum(Rc) / sum(Rep) <= TargetError)
            Nloops = j;
            break;
        end

    end

    Rc = sum(Rc);
    Rep = sum(Rep);

end
