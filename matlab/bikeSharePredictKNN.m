% Implement KNN

load 'bikeShareData.mat'

K_values = [1:15];
accuraciesKNN = zeros(15, 1);
for k = 1:size(K_values, 2)
    modelKNN = fitcknn(bikes_train, labels_train,'NumNeighbors',K_values(k));
    predicted = predict(modelKNN, bikes_test);
    accuracyKNN = 0;
    for t = 1:size(labels_test, 1)
        if (predicted(t) == labels_test(t))
            accuracyKNN = accuracyKNN + 1; 
        end
    end
    accuraciesKNN(k, 1) = 100*accuracyKNN/size(labels_test, 1);
end
plot(K_values, accuraciesKNN); % highest at k = 2