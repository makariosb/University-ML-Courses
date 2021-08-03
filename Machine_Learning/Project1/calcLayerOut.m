function [outputs] = calcLayerOut(nn, x, costFunction)
    %Calculates all neural network layer outputs and returns them as
    %a structure.
    % input:
    %     nn: structure containing neural network weights and biases
    %     x: input vector
    %     costFunction: string from 'ce','exp','hinge' that describes wich cost
    %     function is used, in order to use the appropriate activation function
    %     at the output layer.
    % output:
    %     outputs: structure containing all the neural network layer outputs (before
    %     and after activation function application)

    outputs = struct();
    outputs.h1 = nn.A * x + nn.a;
    outputs.z = (outputs.h1 >= 0) .* outputs.h1; %ReLU
    outputs.h2 = nn.B * outputs.z + nn.b;

    switch costFunction
        case 'ce' %cross entropy
            outputs.u = logsig(outputs.h2);
        otherwise
            outputs.u = outputs.h2;
    end

end
