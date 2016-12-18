% Code for implementation of ensemble rotation forest using fitctree

load 'bikeShareData.mat';

m = 100; % number of sub-sample spaces that has to be created
n = 20000; % size of individual sub-sample space
p = 7; % parameter of random forest model - not used here

% Default the value to 9 for faster execution, this might take 3 hours
P_Values = [3:12];
Accuracies = zeros(size(P_Values, 2), 1);
for p = 1:size(P_Values, 2)
    train_all = [bikes_train labels_train];
    Coeffs = cell(m, 1);
    models = cell(m, 1);
    for k = 1:m
        subspace_train = datasample(train_all, n);
        labels_test_pca = subspace_train(:, 9);
        coeff = pca(subspace_train(:, 1:12), 'NumComponents', 12);
        subspace_train = subspace_train(:, 1:12) * coeff;
        Coeffs{k} = coeff;
        model = fitctree(subspace_train, labels_test_pca);
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
            bikes_test_pca = bikes_test*Coeffs{k};
            y_model(k, 1) = predict(models{k}, bikes_test_pca(t, :));
        end
        y(t, 1) = mode(y_model);
        if y(t, 1) == labels_test(t)
            accuracy = accuracy + 1;
        end
    end

    % Accuracy without Optimizing hyper parameters - 79.5%
    % Accuracy with Optimizing hyper parameters - 81.6%
    accuracy = 100*accuracy/size(labels_test, 1); 
    Accuracies(p, 1) = accuracy;
end

plot(P_Values, Accuracies);