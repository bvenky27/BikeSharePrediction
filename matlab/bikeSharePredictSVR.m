load 'bikeShareData.mat'
%for 20000 training data set accuracy = 40.0952
% 40.12 for 3000
% 40.19 for 2000
% 40.5998 for 1000
bikes_train1000 = bikes_train(1:20000, :);
labels_train1000 = labels_train(1:20000, :);
SvrMdl = fitrsvm(bikes_train1000, labels_train1000);
yfit = predict(SvrMdl, bikes_test);
yfit = round(yfit);
accuracySVR = 0;
for i = 1:size(labels_test)
    if (yfit(i) == labels_test(i))
        accuracySVR = accuracySVR + 1; 
    end
end

accuracy = (accuracySVR/size(labels_test,1))*100