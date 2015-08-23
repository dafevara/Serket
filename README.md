Data Science Specialization: Getting and Cleaning Data
======================================================

Author: Daniel Valencia
Email: dafevara[at]gmail[dot]com
Date: 2015-08-22



## Introduction

In this file it's described the way to execute the run_analysis.R Script
to replicate the steps in order to get the tidy data.


## The Script Methods Description

For this work it was only needed one script called run_analysis.R. In
this file the main function is `Serket.run` Serket is the __code_name__
for the project and the name of the Github Repo.

The run_analysis.R script use a `DATA_DIR` global variable which stores
the Data Directory where the input data set is ready to be used.

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
  * `AddSelfExplainNames`: Responsible for add Human readable and
    Self-explain Variable Names to the MergedData. This method calls an
    other helper method called `GenerateHumanReadableName` which is
    responsible for generate a easy to read and understand variable name
    using the keywords from the original variable name.
  * `CreateSummarized`: Responsible for create the final tidy data set.
    This method groups and summarize (using the mean over each
    measures) the data based on SubjectId,
    ActivityLabelId and ActivityLabel Variables.

## The instructions List

To execute the analysis, there's only needed to suply the `DATA_DIR`
value which is a directory system path to the `UCI HAR Dataset` data.


After that, Please run the `run_analysis.R` script with Rscript or
within a R console.

The tidy data will be print as output.

## Dependencies

This analysis depends on the following packages:

  * `dplyr` 

