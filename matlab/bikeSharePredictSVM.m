load 'bikeShareData.mat'

modelSVM = svmtrain(labels_train, bikes_train, ['-t 2 -c 100']);
[predict_labelSVM, accuracySVM, decision_valuesSVM] = svmpredict(labels_test, bikes_test, modelSVM);