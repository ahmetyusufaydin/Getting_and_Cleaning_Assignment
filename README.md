
## README

There is a unique script in this repository, called "run_analysis.R".

This script requires "dplyr" package to run.

It first reads feature names, test and training data by assigning relevant 
column names. Then, it merges every data to obtain a single data set.

In the second step, it xtracts only the measurements on the mean and standard 
deviation for each measurement, and drops other variables.

In step 3, it reads activity labels for each activity number from the raw data,
merges them with the main data set, creates a factor variable with activity 
labels, and reorders data according to the subject ID and activities.

The obtained data set has appropriate descriptive variable names. 

As a last step, it calculates the average of each variable for each activity 
and each subject. Finally, it saves the final data as a text file. 


