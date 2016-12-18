% Since the fitcsvm is only for binary classification and we need multi
% class classification, the libsvm module is used.

load 'bikeShareData.mat'

modelSVM = svmtrain(labels_train, bikes_train, ['-t 2 -c 100']);
[predict_labelSVM, accuracySVM, decision_valuesSVM] = svmpredict(labels_test, bikes_test, modelSVM);