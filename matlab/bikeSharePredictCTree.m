load 'bikeShareData.mat';
% accuracy = 76%
tree = fitctree(bikes_train, labels_train,'OptimizeHyperparameters','auto');
predicted = predict(tree, bikes_test);

accuracyCTree = 0;
for i = 1:size(labels_test)
    if (predicted(i) == labels_test(i))
        accuracyCTree = accuracyCTree + 1; 
    end
end

accuracyCTree = (accuracyCTree/size(labels_test,1))*100;