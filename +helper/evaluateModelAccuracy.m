function accuracy = evaluateModelAccuracy(dataFile, trainedNetwork)
    [X, Y] = helper.loadData(dataFile);
    Y_pred = predict(trainedNetwork, X);
    residual = Y - Y_pred;
    accuracy = 1 - sqrt(mean(residual.^2));
end