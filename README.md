Data Science Specialization: Getting and Cleaning Data
======================================================

## Introduction

In this file it's described the way to execute the run_analysis.R Script
to replicate the steps in order to get the tidy data.


## The instruction list/script

For this work it was only needed one script called run_analysis.R. In
this file the main function is `Serket.run` Serket is the __code_name__
for the project and the name of the Github Repo.

From that main method other auxiliar methods are called. Following the
auxiliar method list:

  * `LoadData`: Responsible for validate and load the raw data. It returns a
  list of raw tables including train and test sets. 
  * `ClipData`: Responsible for put together the subject, activity and
    measurement raw data. Subject and Activity data is added to keep
    consistence and be ready for the extraction fase.
  * `ExtractMeanAndStd`: Responsible for the Mean and Standard Deviation
    measurement extraction. In this step Subject and Activity data is
    added to keep consistency through the whole process
  * `ActivityLabels`: Responsible to prepare the activity label before
    merging with Mean and Std Data.
  * `MergeData`: Responsible for merge Mean, Std, Subject and Activity
    Data
  * AddSelfExplainNames: Responsible for add Human readable and
    Self-explain Variable Names to the MergedData.


