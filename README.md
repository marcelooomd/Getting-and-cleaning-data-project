# Getting-and-cleaning-data-project

This repository contains the documentation and the R script used in the "Getting and cleaning data" course project of the data science specialization from Johns Hopkins at Coursera.

The files hosted are:
- README.md, which provides a general view of the contents and how they were created;
- Codebook.md, that describes the variables and the steps followed to generate them;
- run_analysis.R, the R script created to generate the tidy data set;
- tidy_data.txt, that is de final data set.

The R script works in the following way:
1. Download the data set;
2. Reads the data from features and activity info;
3. Reads the data from training and test data sets;
4. Reads the activity and subject data for each data set;
5. Merges both data sets (training and test) (step 1);
6. Extract the mean and standart deviation for each mesurement (step 2);
7. Naming and labeling the data set (steps 3 and 4);
8. Creating the final tidy data set (step 5).
