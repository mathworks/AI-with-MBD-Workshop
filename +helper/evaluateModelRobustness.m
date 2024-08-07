function maxDeviation = evaluateModelRobustness(dataFile, trainedNetwork, perturbation)
[X, ~] = helper.loadData(dataFile);
Y_pred = predict(trainedNetwork, X);
dlX = dlarray(X,'BC');
XLower = dlX-perturbation;
XUpper = dlX+perturbation;
[YLower,YUpper] = estimateNetworkOutputBounds(trainedNetwork,XLower,XUpper);
YLower = extractdata(YLower)';
YUpper = extractdata(YUpper)';
maxDeviation = max([abs(YLower-Y_pred);abs(YUpper-Y_pred)]);
end