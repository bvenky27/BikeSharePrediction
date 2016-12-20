load 'bikeShareData.mat';

% Plot accuracies for fixed random forest hyper parameter m = 7 and
% changing number of trees from 1 to 40
optNumPredict = 7;
NTress_values = [1:40];
accuraciesTB = zeros(size(NTress_values, 2), 1);
for NT = 1:size(NTress_values, 2)
    B = TreeBagger(NTress_values(NT),bikes_train,labels_train, 'Method', 'classification', 'NumPredictorsToSample', optNumPredict);
    accuracyTB = 0;
    predictedTBCells = predict(B, bikes_test);
    predictedTBChar = cell2mat(predictedTBCells);
    for t = 1:size(labels_test, 1)
        if (str2double(predictedTBChar(t)) == labels_test(t))
            accuracyTB = accuracyTB + 1;
        end
    end
    accuraciesTB(NT) = 100*accuracyTB/size(labels_test, 1);
end
plot(NTress_values, accuraciesTB);
title('TreeBagger - NTrees vs Accuracies');
% Stabilized at NTrees = 15