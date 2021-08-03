function [Nloops] = TestLr(x1, x2, TargetError, Lr, MaxRep)
    Nloops = 1;
    Npatterns = columns(x1) + columns(x2);

    while (Nloops < MaxRep)
        [Rc, ~, ~] = HoKa(x1, x2, Lr, Nloops);

        if (1 - sum(Rc) / Npatterns <= TargetError)
            break;
        end

        Nloops = Nloops + 1;
    end

end
