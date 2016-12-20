# BikeSharePrediction
Predict the bnumber of bikes that will be booked using bike-share data

CMSC 678 - Machine Learning - Fall 2016 - Final Project


Student Names:

Phanindra Kumar Kannaji (pkanna1)
Venkata Rami Reddy Bujunuru (bo26494)


The project files consists of following parts:

1. data: The bike Share data and the weather data individual files per year and the final generated .mat file with the entire combined data.

bike_<year>.csv
weather_<year>.csv
bikeShareData.mat - entire data


2. images: The outputs of different plots with the name of the file indicating the algorithm used and the parameters are set while running it.
3. matlab: The matlab code consisting of code written by us and a very little auto-generated code.
4. Slides: Our presentation slides and final paper.
5. Readme.md and Readme: *this

Matlab Code: 

*) dataExtract.m: A function to extract the data from bike share data and weather data and combine them based on time in an hourly based fashion.
*) dataCombine.m: This is to combine the data from all the years and do the preprocessing and postprocessing steps to classify and organize the data before feeding it to the machine learning models.
*) bikeSharePredictCTree.m: Simple Classification tree with no parameters set and with entire data.
*) bikeSharePredictKNN.m: Simple K-Nearest Neighbours implementation with plot for varying k and respective accuracy.
*) bikeSharePredictSVM.m: Simple Support Vector Machines implementation with no parameters for entire data.
*) bikeSharePredictSVR.m: Simple Support Vector Regression implementation with no parameters for entire data. This is a classification problem, thus not so good accuracy for the regression.
*) bikeSharePredictTreeBagger.m: The TreeBagger is a class for implementing the Bagging method or BootStrap Aggregating method. This file demomnstartes the simple usage of the TreeBagger for our data.
*) bikeSharePredictTBRF.m: This is same as the Bagging but with Random Forest method.
*) bikeSharePredictOptNTrees.m: This is for running the TreeBagger for varying number of decision trees to get the optimal value.
*) bikeSharePredictOptPred.m: This is for running the TreeBagger for varying number of predictors.
*) trainClassifierCTree.m: This is auto-generated code for a function from Classifier app in Matlab.
*) ClassifierApp_CTree.m: This is stub code for trainClassifierCTree.
*) trainClassifierBaggedTreesEnsemble.m: This is auto-generated code for a function from Classifier app in Matlab.
*) ClassifierApp_Ensemble.m: This is stub code for trainClassifierBaggedTreesEnsemble.
*) RunEnsemble.m: This file runs the Classification tree using random forest model with ensemble method.
*) RunEnsembleSplitCriterion.m: This is same as RunEnsemble but with Split criterion selected as 'deviance' as explained in the paper.
*) RunEnsembleRotationForest.m: This matlab script runs the classification tree in rotation forest model using ensemble method.
*) RunEnsembleRotationForestWithSplitCriterion.m: This is same as running ensemble with rotation forest but with the Split criterion selected as 'deviance' as explained in the paper.

*) RunEnsembleRotationForestAll.m: THis file runs the ensemble rotation forest for all the varying PCA number of components and plot the graph for number of components in PCA vs Accuracy.
*) 

In Slides: 
The paper, slides and the tex file used to create the pdf is also included.

Steps to deploy the code:

1) Add the entire directory to path including subfolders.
2) Make sure you got installed the libsvm package and Math and Statistics App/Package.
3) Any file can now be automatically run and it will pick up the data and run.
4) For convenience, the starting point could be:

	RunQuickOnly.m : Runs the matlab code only for those scripts which gives immediate output. 
	RunAll.m : Runs every code, might take a day because of the number of computations. Please run individually instead.

