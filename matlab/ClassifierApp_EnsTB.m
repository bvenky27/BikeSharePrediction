% Stub to run the auto-generated code from Classifier App for Ensemble
% TreeBagger
load 'bikeShareData.mat'

train_all = [bikes_train labels_train];
test_all = [bikes_test labels_test];
all_data = [train_all; test_all];

[trainedClassifier, validationAccuracy] = trainClassifierBaggedTreesEnsemble(train_all);
yfit = trainedClassifier.predictFcn(bikes_test);
accuracy = 0;
for t = 1:size(labels_test, 1)
    if (yfit(t) == labels_test(t))
        accuracy = accuracy+1;
    end
end

accuracy = 100*accuracy/size(labels_test, 1);