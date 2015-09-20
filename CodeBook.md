trainset: contains data from X_train.txt.
trainlabel: contains data from y_train.txt.
trainsubject: contains data from subject_train.txt.
testset: contains data from X_test.txt.
testlabel: contains data from y_train.txt.
testsubject: contains data from subject_test.txt.
features: contains data from features.txt.
activity: contains data from activity_labels.txt.
traindata: contains trainset, trainlabel and trainsubject data. trainlabel data in traindata are formatted from Key to Text. Column names are renamed based on features. 
testdata: contains testset, testlabel and testsubject data. testlabel data in traindata are formatted from Key to Text. Column names are renamed based on features. 
finaldata: contains traindata and testdata. It is filtered down to only keep mean (.mean) and standard deviation (.std) results.
averagedata: contains the mean of finaldata results grouped by Activity and Subject. The results are written to an output file named tidydata.txt.