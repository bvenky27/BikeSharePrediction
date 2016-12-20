% Code for implementation of ensemble rotation forest using fitctree and
% parameter splitCreterion selected as 'deviance' - accuracy around 78.5

load 'bikeShareData.mat';

m = 100; % number of sub-sample spaces that has to be created
p = 7; % parameter of random forest model - not used here

train_all = [bikes_train labels_train];
Coeffs = cell(m, 1);
models = cell(m, 1);
for k = 1:m
    n = randi([15000 40000], 1, 1); % size of individual sub-sample space
    subspace_train = datasample(train_all, n);
    labels_train_pca = subspace_train(:, 13);
    coeff = pca(subspace_train(:, 1:12));
    subspace_train = subspace_train(:, 1:12) * coeff;
    Coeffs{k} = coeff;
    model = fitctree(subspace_train, labels_train_pca, 'SplitCriterion', 'deviance');
    models{k} = model;
end
accuracy = 0;
y = zeros(size(labels_test, 2), 1);
for t = 1:size(labels_test, 1)
    y_model = zeros(m, 1);
    for k = 1:m
        bikes_test_pca = bikes_test*Coeffs{k};
        y_model(k, 1) = predict(models{k}, bikes_test_pca(t, :));
    end
    y(t, 1) = mode(y_model);
    if y(t, 1) == labels_test(t)
        accuracy = accuracy + 1;
    end
end
accuracy = 100*accuracy/size(labels_test, 1);