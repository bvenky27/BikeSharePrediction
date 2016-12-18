load 'bikeShareData.mat';

NTress_values = [10];
sample_Values = [3:12];
accuraciesTB = zeros(size(sample_Values, 2), 1);
for samp = 1:size(sample_Values, 2)
    for NT = 1:size(NTress_values, 1)
        B = TreeBagger(NTress_values(NT),bikes_train,labels_train, 'Method', 'classification', 'NumPredictorsToSample', sample_Values(samp));
        accuracyTB = 0;
        predictedTBCells = predict(B, bikes_test);
        predictedTBChar = cell2mat(predictedTBCells);
        for t = 1:size(labels_test, 1)
            if (str2double(predictedTBChar(t)) == labels_test(t))
                accuracyTB = accuracyTB + 1;
            end
        end
        accuraciesTB(samp) = 100*accuracyTB/size(labels_test, 1);
    end
end
plot(sample_Values, accuraciesTB);