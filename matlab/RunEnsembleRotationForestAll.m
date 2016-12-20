% Code for implementation of ensemble rotation forest using fitctree and
% rotation forest with varying p values
%
%
% Might take 4 hours to run
%
%
load 'bikeShareData.mat';

m = 100; % number of sub-sample spaces that has to be created
p = 7; % parameter of random forest model - not used here

% Default the value to 9 for faster execution, this might take 3 hours when
% run completely
P_Values = [3:12];
Accuracies = zeros(size(P_Values, 2), 1);
for p = 1:size(P_Values, 2)
    train_all = [bikes_train labels_train];
    Coeffs = cell(m, 1);
    models = cell(m, 1);
    for k = 1:m
        n = randi([15000 40000], 1, 1); % size of individual sub-sample space
        subspace_train = datasample(train_all, n);
        labels_train_pca = subspace_train(:, 13); % labels
        coeff = pca(subspace_train(:, 1:12), 'NumComponents', p); % Run PCA
        subspace_train = subspace_train(:, 1:12) * coeff; % Project onto training adta
        Coeffs{k} = coeff;
        model = fitctree(subspace_train, labels_train_pca); % Save model
        models{k} = model;
    end
    accuracy = 0;
    y = zeros(size(labels_test, 2), 1);
    for t = 1:size(labels_test, 1) %For each test data point
        y_model = zeros(m, 1); 
        for k = 1:m % Calculate prediction for each model
            bikes_test_pca = bikes_test*Coeffs{k}; % Project embeddings onto test data
            y_model(k, 1) = predict(models{k}, bikes_test_pca(t, :));
        end
        y(t, 1) = mode(y_model); % Take the . ode as final prediction
        if y(t, 1) == labels_test(t)
            accuracy = accuracy + 1;
        end
    end
    accuracy = 100*accuracy/size(labels_test, 1); 
    Accuracies(p, 1) = accuracy;
end

plot(P_Values, Accuracies);
title('Rotation Forest - PCA Number of components vs Accuracy');