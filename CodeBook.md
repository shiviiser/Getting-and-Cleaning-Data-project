# Courser Course Getting and Cleaning Data Course Project
 data was taken from 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
all discription about data can be found here.

Data for the project 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 variables used in the project are 
1) train_data 2)train_label 3) train_subject all three  extracted from train data avilabel in above zip file with read.table commmand

4) test_data 5) test_label 6) test_subject all three  extracted from test data avilabel in above zip file with read.table commmand
7) activity type of ctivity extracted from zip file of data
 
1st I joined test_data with train_data by rbind and did same for label and subject of both data sets. then renamed the data, and join all togather to form tidy data.

