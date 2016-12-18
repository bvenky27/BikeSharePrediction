% Code for implementation of ensemble using fitctree

load 'bikeShareData.mat';

m = 100; % number of sub-sample spaces that has to be created
n = 20000; % size of individual sub-sample space
p = 7; % parameter of random forest model

train_all = [bikes_train labels_train];

models = cell(m, 1);
for k = 1:m
    subspace_train = datasample(train_all, n);
    model = fitctree(subspace_train(:, 1:12), subspace_train(:, 13));
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
