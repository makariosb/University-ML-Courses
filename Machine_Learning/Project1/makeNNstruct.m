function [nn] = makeNNstruct(dimInput, hiddenNeurons, dimOutput)
    %Initialises weights of neural network using Xavier inialisation and sets
    %the initial biases to zero, weights {A,B}, biases {a,b}.
    % input:
    %     dimInput: input vector number of features(rows)
    %     hiddenNeurons: number of hidden layer neurons
    %     dimOutput: neural network output vector dimensions
    % output:
    %     nn: neural network structure with initialised weights and biases as fields.

    nn = struct();
    nn.A = randn(hiddenNeurons, dimInput);
    nn.A = nn.A / sqrt(sum(size(nn.A)));
    nn.a = zeros(hiddenNeurons, 1);

    nn.B = randn(dimOutput, hiddenNeurons);
    nn.B = nn.B / sqrt(sum(size(nn.B)));
    nn.b = zeros(dimOutput, 1);
end
