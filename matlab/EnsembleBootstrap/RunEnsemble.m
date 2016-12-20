% Code for implementation of ensemble random forest using fitctree

load 'bikeShareData.mat';

m = 100; % number of sub-sample spaces that has to be created
%n = 20000; % size of individual sub-sample space
p = 7; % parameter of random forest model - not used here

train_all = [bikes_train labels_train];
Coeffs = cell(m, 1);
models = cell(m, 1);
for k = 1:m
    n = randi([15000 40000], 1, 1); % size of individual sub-sample space
    subspace_train = datasample(train_all, n);
    labels_test_pca = subspace_train(:, 13);
    subspace_train = subspace_train(:, 1:12);
    model = fitctree(subspace_train, labels_test_pca, 'SplitCriterion', 'deviance');
    % Comment above line and Uncomment below to run fitctree with optimized
    % parameters - takes approximately 2 hours to run and produces accuracy
    % of 81.6
    %model = fitctree(subspace_train(:, 1:12), subspace_train(:, 13), 'OptimizeHyperParameters', 'auto');
    models{k} = model;
end
accuracy = 0;
y = zeros(size(labels_test, 2), 1);
for t = 1:size(labels_test, 1)
    y_model = zeros(m, 1);
    for k = 1:m
        y_model(k, 1) = predict(models{k}, bikes_test(t, :));
    end
    y(t, 1) = mode(y_model);
    if y(t, 1) == labels_test(t)
        accuracy = accuracy + 1;
    end
end

% Accuracy without Optimizing hyper parameters - 79.5%
% Accuracy with Optimizing hyper parameters - 81.6%
accuracy = 100*accuracy/size(labels_test, 1); 


featureNames = cell(12, 1);
featureNames{1} = 'Season';
featureNames{2} = 'Year';
featureNames{3} = 'Month';
featureNames{4} = 'Day';
featureNames{5} = 'Hour' ;
featureNames{6} = 'DayOfWeek' ;
featureNames{7} = 'humidity' ;
featureNames{8} = 'windSpeed' ;
featureNames{9} = 'cloudCover' ;
featureNames{10} = 'temperature'; 
featureNames{11} = 'Summary'; 
featureNames{12} = 'Holiday';

imp = predictorImportance(model);
figure;
bar(imp);
title('Feature Importance');
ylabel('Estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = featureNames;
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';
