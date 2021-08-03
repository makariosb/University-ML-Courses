function [gradA, grada, gradB, gradb] = computeGradient(nn, input, outputs, label, costfunc)
    %Computes neural network parameter gradients for given outputs and cost function
    %input:
    % nn: neural network structure with parameter matrices a,A,b,B
    % input: input vector that is used for gradient computation
    % label: input vector target class depending on hypothesis(0-1), used for cost function partial derivative computation
    % costfun: string from 'ce','exp','hinge' that describes wich cost function to use
    %output:
    % gradA: network weight matrix A gradient
    % grada: network bias matrix a gradient
    % gradB: network weight matrix B gradient
    % gradb: network bias matrix b gradient
    % the dimensons of the output gradients are the same as the according matrices

    u = outputs.u;

    switch costfunc
        case 'ce' %cross entropy
            dl = not(label) * 1 / (1 - u) + label * (-1 / u);
            dg = logsig(outputs.h2) * logsig(-outputs.h2);
        case 'exp' %exponential
            dl = not(label) * 0.5 * exp(0.5 * u) + label * (-0.5 * exp(-0.5 * u));
            dg = 1;
        case 'hinge'
            %         dl = not(label) * heaviside(u+1) + label * (-heaviside(-u+1));
            dl = not(label) * (u >= -1) + label * (-(u <= 1));
            dg = 1;
    end

    d2 = dl * dg; %dL/du * g'(h2)
    gradb = d2;
    gradB = d2 * outputs.z';

    d1 = d2 * nn.B * diag((outputs.h1 >= 0)); %reludot
    grada = d1';
    gradA = d1' * input';

end
