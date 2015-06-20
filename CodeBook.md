---
title: "Codebook for Course Project [Coursera: Getting and Cleaning Data]"
author: "Zhi Xiong"
date: "20 June 2015"
output:
  html_document:
    keep_md: yes
---
 
## Project Description
Read README.md
 
##Study design and data processing
1) A main data frame is created by combining all values from 6 files:
	* "test/subject_test.txt"
	* "test/y_test.txt"
	* "test/X_test.txt"
	* "train/subject_train.txt"
	* "train/y_train.txt"
	* "train/X_train.txt"

	"subject" files inform of the subjects observed (representing the observations)
	"y" files contain the activities done by the subjects
	"X" files contain all the observations for 561 features (e.g. tBodyAcc, fBodyAcc, etc.)

2) From the main data frame, only the "mean" and "standard deviation" features are selected. This is done by identifying the features from "features.txt" file, then mapping into the data set. 

3) Labelling the data set was carried out appropriately and properly. 

4) The dataset was then tidied and exported on a different, independent data set. Only average/mean of the observations was logged for each individual subject and each activity carried out. 

	* This was done using the "reshape2" library. The "melt" function converts the wide dataset into long dataset, where all observations for "feature" variables are piled up into 1 column. 

	* The "dcast" function converst the long dataset back into wide dataset, but with "mean" function run on the overlapping "feature" variables. 
