% This file is used to combine all years data and to add some additional
% parameters and also to change/classify some values and features

% Collect all years' data
combined2011 = dataExtract(2011);
combined2012 = dataExtract(2012);
combined2013 = dataExtract(2013);
combined2014 = dataExtract(2014);
combined2015 = dataExtract(2015);
combined2016 = dataExtract(2016);

% Combine all data
featureData = [combined2011; combined2012; combined2013; combined2014; combined2015; combined2016];

% Seperate labels data from feature data
all_labels = featureData(:, 7);
all_labels = [all_labels ones(size(all_labels, 1), 1)];

% Count the number of occurences of the bike rental frequencies in order to
% divide the labels into classes
[i,~,j]  = unique(all_labels(:, 1), 'rows');
countStats = [i, accumarray(j, all_labels(:, 2), [], @sum)];

plot(countStats(:,1), countStats(:, 2)); % Can see the logarithmic distribution here

all_labels = all_labels(:, 1);

% Classify the labels
all_labels(all_labels >= 1    & all_labels <= 40 )   = 1; % Can't see any bikes around
all_labels(all_labels >  40   & all_labels <= 200 )  = 2; % Very few bikes
all_labels(all_labels >  200  & all_labels <= 400 )  = 3; % Less busy
all_labels(all_labels >  400  & all_labels <= 600 )  = 4; % Normal
all_labels(all_labels >  600  & all_labels <= 800 )  = 5; % Busy
all_labels(all_labels >  800  & all_labels <= 1100 ) = 6; % Very Busy
all_labels(all_labels >  1100 & all_labels <= 2000 ) = 7; % Perfect time for biking for everyone

% Combine the data
featureData = [featureData(:, 1:6) all_labels(:, 1) featureData(:, 8:12)];

% Construct the data to enter holiday information (0 or 1)
holidays = zeros(size(featureData, 1), 1);
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==1 & featureData(:, 4)==17)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==2 & featureData(:, 4)==21)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==4 & featureData(:, 4)==15)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==5 & featureData(:, 4)==30)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==7 & featureData(:, 4)==04)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==9 & featureData(:, 4)==05)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==10 & featureData(:, 4)==10)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==11 & featureData(:, 4)==11)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==11 & featureData(:, 4)==24)=1;
holidays(featureData(:, 2) == 2011 & featureData(:, 3)==12 & featureData(:, 4)==26)=1;

holidays(featureData(:, 2) == 2012 & featureData(:, 3)==1 & featureData(:, 4)==2)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==1 & featureData(:, 4)==16)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==2 & featureData(:, 4)==20)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==4 & featureData(:, 4)==16)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==5 & featureData(:, 4)==28)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==7 & featureData(:, 4)==04)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==9 & featureData(:, 4)==03)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==10 & featureData(:, 4)==08)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==11 & featureData(:, 4)==12)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==11 & featureData(:, 4)==22)=1;
holidays(featureData(:, 2) == 2012 & featureData(:, 3)==12 & featureData(:, 4)==25)=1;

holidays(featureData(:, 2) == 2013 & featureData(:, 3)==1 & featureData(:, 4)==1)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==1 & featureData(:, 4)==20)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==1 & featureData(:, 4)==21)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==2 & featureData(:, 4)==18)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==4 & featureData(:, 4)==16)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==5 & featureData(:, 4)==27)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==7 & featureData(:, 4)==04)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==9 & featureData(:, 4)==02)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==10 & featureData(:, 4)==14)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==11 & featureData(:, 4)==11)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==11 & featureData(:, 4)==28)=1;
holidays(featureData(:, 2) == 2013 & featureData(:, 3)==12 & featureData(:, 4)==25)=1;

holidays(featureData(:, 2) == 2014 & featureData(:, 3)==1 & featureData(:, 4)==1)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==1 & featureData(:, 4)==20)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==2 & featureData(:, 4)==17)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==4 & featureData(:, 4)==16)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==5 & featureData(:, 4)==26)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==7 & featureData(:, 4)==04)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==9 & featureData(:, 4)==01)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==10 & featureData(:, 4)==13)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==11 & featureData(:, 4)==11)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==11 & featureData(:, 4)==27)=1;
holidays(featureData(:, 2) == 2014 & featureData(:, 3)==12 & featureData(:, 4)==25)=1;

holidays(featureData(:, 2) == 2015 & featureData(:, 3)==1 & featureData(:, 4)==1)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==1 & featureData(:, 4)==19)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==2 & featureData(:, 4)==16)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==4 & featureData(:, 4)==16)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==5 & featureData(:, 4)==25)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==7 & featureData(:, 4)==03)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==9 & featureData(:, 4)==07)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==10 & featureData(:, 4)==12)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==11 & featureData(:, 4)==11)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==11 & featureData(:, 4)==26)=1;
holidays(featureData(:, 2) == 2015 & featureData(:, 3)==12 & featureData(:, 4)==25)=1;

holidays(featureData(:, 2) == 2016 & featureData(:, 3)==1 & featureData(:, 4)==1)=1;
holidays(featureData(:, 2) == 2016 & featureData(:, 3)==1 & featureData(:, 4)==18)=1;
holidays(featureData(:, 2) == 2016 & featureData(:, 3)==2 & featureData(:, 4)==15)=1;
holidays(featureData(:, 2) == 2016 & featureData(:, 3)==4 & featureData(:, 4)==15)=1;
holidays(featureData(:, 2) == 2016 & featureData(:, 3)==5 & featureData(:, 4)==30)=1;

featureData = [featureData holidays];

% Shuffle the data
idx=randperm(size(featureData, 1));

% Split it into training and test - features and labels data
bikes_train_all = featureData(idx(1:40000), :);
bikes_test_all = featureData(idx(40001:46936), :);

labels_train = bikes_train_all(:, 7);
bikes_train = [bikes_train_all(:, 1:6) bikes_train_all(:, 8:13)];

labels_test = bikes_test_all(:, 7);
bikes_test = [bikes_test_all(:, 1:6) bikes_test_all(:, 8:13)];

% Mark the weekends also as holidays to increase accuracy
bikes_train((bikes_train(:, 6) == 1 | bikes_train(:, 6) == 7), 12) = 1;
bikes_test((bikes_test(:, 6) == 1 | bikes_test(:, 6) == 7), 12) = 1;

% Save the mat file to use directly in other methods
save('bikeShareData.mat', 'bikes_train', 'labels_train', 'bikes_test', 'labels_test');

% Loading the final feature names into an array of cells for future use.
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