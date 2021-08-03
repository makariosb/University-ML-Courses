function [] = plotPredictions(X, labels, predLabels)
    clf('reset'); %clear current figure
    x1 = X(:, labels == 1);
    x2 = X(:, labels == 2);
    predLabels = predLabels(:)'; %make it a line vector
    x1_pred = X(:, predLabels == 1);
    x2_pred = X(:, predLabels == 2);
    mSize = 12;
    plot(x1(1, :), x1(2, :), 'b.', 'LineStyle', 'none', 'MarkerSize', mSize);
    hold on;
    plot(x2(1, :), x2(2, :), 'r.', 'LineStyle', 'none', 'MarkerSize', mSize);
    plot(x1_pred(1, :), x1_pred(2, :), 'bo', 'LineStyle', 'none', 'MarkerSize', mSize);
    plot(x2_pred(1, :), x2_pred(2, :), 'ro', 'LineStyle', 'none', 'MarkerSize', mSize);

    xlabel 'x_1'; ylabel 'x_2';
    legend("group 0", "group 1", "predictions 0", "predictions 1");
    figure(gcf);
end
