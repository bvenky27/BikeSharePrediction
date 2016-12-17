load 'bikeShareData.mat';

NTress_values = [1:20];
for samp = 1:7
    accuraciesTB = zeros(size(NTress_values, 2), 1);
    for NT = 1:size(NTress_values, 2)
        B = TreeBagger(NTress_values(NT),bikes_train,labels_train, 'Method', 'classification', 'NumPredictorsToSample', samp);
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
    figure;
    plot(NTress_values, accuraciesTB);
    title(strcat('accuracy table for Sample: ', num2str(samp)))
end