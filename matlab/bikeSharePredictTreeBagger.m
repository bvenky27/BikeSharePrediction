% Implemented TreeBagger for RANDOM FOREST MODEL and ensemble methods.
% Variations are ran with changing the number of features to search at the
% split point i.e., the hyper parameter of the random forest model to make
% it similar to the functionality of the Bootstrap aggregation.

% Will take almost half day to run
% Very slow

load 'bikeShareData.mat'

NTress_values = [1:200];
accuraciesTB = zeros(size(NTress_values, 2), 1);
for NT = 1:size(NTress_values, 2)
    B = TreeBagger(NTress_values(NT),bikes_train,labels_train, 'Method', 'classification');
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

plot(NTress_values, accuraciesTB); % highest at 182 with accuracy of ~80%