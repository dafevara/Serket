
Data Science Specialization: Getting and Cleaning Data
======================================================

Codebook
=========

## Study Design

For this study, the input dataset contains training and test data regarding
Accelerometer and Gyroscope measurements using Samsung Galaxy S devises
with the help of 30 subjects. This data was collected regarding 6
different activities (please see activity_labels.txt file).

The input data is separated in training and test directories. Inside both
directories there's a `Inertial Signals` directory which is no relevant
for the purpose of the analysis, because of that it's descarted.

The input data is organized as follows:

  * `UCI HAR Dataset/train/X_train.txt`: Measurements.
  * `UCI HAR Dataset/train/subject_train.txt: Subjects id.
  * `UCI HAR Dataset/train/y_train.txt`: Activity Ids.

  * `UCI HAR Dataset/test/X_test.txt`: Measurements.
  * `UCI HAR Dataset/test/subject_test.txt: Subjects id.
  * `UCI HAR Dataset/test/y_test.txt`: Activity Ids.

Due that the input data is splitted into test and training sets, the first
approach was to understand what measures are store in each file. In both sets, the
observations were the same in terms of accelerator and
gyroscope measurements. However, this separation represents a study obstacle.

In order to accomplish the tidy data principles, that separation is the right way to share a dataset for
scientific purpose, but in favor of the current study case, it's need to
have activity, subject and measures data together. To do
that, the activity and subject data was clipped for each test and
training sets as first step.

Once each dataset contains activity and subject data, the
following step was to bind both datasets by rows. As result, a big dataset
with all needed measures, activities and subject data was generated.

At that point, current dataset dimension were rows: 10299, cols: 563

With the data together, the next step was to extract only Mean and
Standard Deviation Variables. Following the features description in
features.txt and features_info.txt.

To accomplish that, the method `ExtractMeanAndStd` is used. As result, dataset dimmensions were 10299x81.

At this point, the dataset includes ActivityLabelId column. However, it isn't easy to
recognize what is the activity or what means the `ActivityLabelId`.
Because of that, and using the data on the file: `activity_labels.txt`,
that data was merged into the actual dataset. After that operation
the actual dataset dimmensions were 10299x82.

At this point, the measure variable names are not easy to read and
understand, in order to fix that, and using the features_info.txt, the
method `AddSelfExplainNames` is applied to the actual dataset.

AddSelfExplainNames get advantage of keywords on the features names. i.e
`Acc`, `Gyro`, `Mean`, `Frecuency` and so on.

Please see the following keyword and translations list:

    "Body" = "Body",
    "Acc" = "Acceleration",
    "Gyro" = "Gyroscope",
    "Jerk" = "Jerk",
    "mean()" = "Mean",
    "std()" = "StandardDeviation",
    "meanFreq()" = "MeanFrequency",
    "Mag" = "Magnitude",
    "-" = '',
    "-X" = "AtXAxis",
    "-Y" = "AtYAxis",
    "-Z" = "AtZAxis",
    "t" = "Time",
    "f" = "Frequency"

with that translation list, a feature name like: 't -  - BodyAcc-mean()-X' is
translated into: ' -  - BodyAccelerationMeanAtXAxisTime'. It's a longer name,
but it's descriptive and self-explained.

Once the actual dataset have descriptive variable names, the next and
final step was to group and summarize the data, to do that the method:
`CreateSummarized` creates a separated tidy dataset grouping by
SubjectId, ActivityLabelId and ActivityLabel. With that, the summarize
process was only applied to a measures variables.

As result of this steps, the tidy dataset dimmensions were:

Rows: 180, Cols: 82



## Dataset Description

Data Frame: 180 obs. of  82 variables:
 - SubjectId                                              : int 1:30
 - ActivityLabelId                                        : int  1 2 3 4 5 6
 - ActivityLabel                                          : Factor w/ 6 levels WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING ,STANDING, LAYING
- BodyAccelerationMeanAtXAxisTime                         : Float, Average, Unit: Seconds
- BodyAccelerationMeanAtYAxisTime                         : Float, Average, Unit: Seconds
- BodyAccelerationMeanAtZAxisTime                         : Float, Average, Unit: Seconds
- GravityAccelerationMeanAtXAxisTime                      : Float, Average, Unit: Seconds
- GravityAccelerationMeanAtYAxisTime                      : Float, Average, Unit: Seconds
- GravityAccelerationMeanAtZAxisTime                      : Float, Average, Unit: Seconds
- BodyAccelerationJerkMeanAtXAxisTime                     : Float, Average, Unit: Seconds
- BodyAccelerationJerkMeanAtYAxisTime                     : Float, Average, Unit: Seconds
- BodyAccelerationJerkMeanAtZAxisTime                     : Float, Average, Unit: Seconds
- BodyGyroscopeMeanAtXAxisTime                            : Float, Average, Unit: Seconds
- BodyGyroscopeMeanAtYAxisTime                            : Float, Average, Unit: Seconds
- BodyGyroscopeMeanAtZAxisTime                            : Float, Average, Unit: Seconds
- BodyGyroscopeJerkMeanAtXAxisTime                        : Float, Average, Unit: Seconds
- BodyGyroscopeJerkMeanAtYAxisTime                        : Float, Average, Unit: Seconds
- BodyGyroscopeJerkMeanAtZAxisTime                        : Float, Average, Unit: Seconds
- BodyAccelerationMagnitudeMeanTime                       : Float, Average, Unit: Seconds
- GravityAccelerationMagnitudeMeanTime                    : Float, Average, Unit: Seconds
- BodyAccelerationJerkMagnitudeMeanTime                   : Float, Average, Unit: Seconds
- BodyGyroscopeMagnitudeMeanTime                          : Float, Average, Unit: Seconds
- BodyGyroscopeJerkMagnitudeMeanTime                      : Float, Average, Unit: Seconds
- BodyAccelerationMeanAtXAxisFrequency                    : Float, Average, Unit: Hz
- BodyAccelerationMeanAtYAxisFrequency                    : Float, Average, Unit: Hz
- BodyAccelerationMeanAtZAxisFrequency                    : Float, Average, Unit: Hz
- BodyAccelerationMeanFreqAtXAxisFrequency                : Float, Average, Unit: Hz
- BodyAccelerationMeanFreqAtYAxisFrequency                : Float, Average, Unit: Hz
- BodyAccelerationMeanFreqAtZAxisFrequency                : Float, Average, Unit: Hz
- BodyAccelerationJerkMeanAtXAxisFrequency                : Float, Average, Unit: Hz
- BodyAccelerationJerkMeanAtYAxisFrequency                : Float, Average, Unit: Hz
- BodyAccelerationJerkMeanAtZAxisFrequency                : Float, Average, Unit: Hz
- BodyAccelerationJerkMeanFreqAtXAxisFrequency            : Float, Average, Unit: Hz
- BodyAccelerationJerkMeanFreqAtYAxisFrequency            : Float, Average, Unit: Hz
- BodyAccelerationJerkMeanFreqAtZAxisFrequency            : Float, Average, Unit: Hz
- BodyGyroscopeMeanAtXAxisFrequency                       : Float, Average, Unit: Hz
- BodyGyroscopeMeanAtYAxisFrequency                       : Float, Average, Unit: Hz
- BodyGyroscopeMeanAtZAxisFrequency                       : Float, Average, Unit: Hz
- BodyGyroscopeMeanFreqAtXAxisFrequency                   : Float, Average, Unit: Hz
- BodyGyroscopeMeanFreqAtYAxisFrequency                   : Float, Average, Unit: Hz
- BodyGyroscopeMeanFreqAtZAxisFrequency                   : Float, Average, Unit: Hz
- BodyAccelerationMagnitudeMeanFrequency                  : Float, Average, Unit: Hz
- BodyAccelerationMagnitudeMeanFreqFrequency              : Float, Average, Unit: Hz
- BodyAccelerationJerkMagnitudeMeanFrequency              : Float, Average, Unit: Hz
- BodyAccelerationJerkMagnitudeMeanFreqFrequency          : Float, Average, Unit: Hz
- BodyGyroscopeMagnitudeMeanFrequency                     : Float, Average, Unit: Hz
- BodyGyroscopeMagnitudeMeanFreqFrequency                 : Float, Average, Unit: Hz
- BodyGyroscopeJerkMagnitudeMeanFrequency                 : Float, Average, Unit: Hz
- BodyGyroscopeJerkMagnitudeMeanFreqFrequency             : Float, Average, Unit: Hz
- BodyAccelerationStandardDeviationAtXAxisTime            : Float, Average, Unit: Seconds
- BodyAccelerationStandardDeviationAtYAxisTime            : Float, Average, Unit: Seconds
- BodyAccelerationStandardDeviationAtZAxisTime            : Float, Average, Unit: Seconds
- GravityAccelerationStandardDeviationAtXAxisTime         : Float, Average, Unit: Seconds
- GravityAccelerationStandardDeviationAtYAxisTime         : Float, Average, Unit: Seconds
- GravityAccelerationStandardDeviationAtZAxisTime         : Float, Average, Unit: Seconds
- BodyAccelerationJerkStandardDeviationAtXAxisTime        : Float, Average, Unit: Seconds
- BodyAccelerationJerkStandardDeviationAtYAxisTime        : Float, Average, Unit: Seconds
- BodyAccelerationJerkStandardDeviationAtZAxisTime        : Float, Average, Unit: Seconds
- BodyGyroscopeStandardDeviationAtXAxisTime               : Float, Average, Unit: Seconds
- BodyGyroscopeStandardDeviationAtYAxisTime               : Float, Average, Unit: Seconds
- BodyGyroscopeStandardDeviationAtZAxisTime               : Float, Average, Unit: Seconds
- BodyGyroscopeJerkStandardDeviationAtXAxisTime           : Float, Average, Unit: Seconds
- BodyGyroscopeJerkStandardDeviationAtYAxisTime           : Float, Average, Unit: Seconds
- BodyGyroscopeJerkStandardDeviationAtZAxisTime           : Float, Average, Unit: Seconds
- BodyAccelerationMagnitudeStandardDeviationTime          : Float, Average, Unit: Seconds
- GravityAccelerationMagnitudeStandardDeviationTime       : Float, Average, Unit: Seconds
- BodyAccelerationJerkMagnitudeStandardDeviationTime      : Float, Average, Unit: Seconds
- BodyGyroscopeMagnitudeStandardDeviationTime             : Float, Average, Unit: Seconds
- BodyGyroscopeJerkMagnitudeStandardDeviationTime         : Float, Average, Unit: Seconds
- BodyAccelerationStandardDeviationAtXAxisFrequency       : Float, Average, Unit: Hz
- BodyAccelerationStandardDeviationAtYAxisFrequency       : Float, Average, Unit: Hz
- BodyAccelerationStandardDeviationAtZAxisFrequency       : Float, Average, Unit: Hz
- BodyAccelerationJerkStandardDeviationAtXAxisFrequency   : Float, Average, Unit: Hz
- BodyAccelerationJerkStandardDeviationAtYAxisFrequency   : Float, Average, Unit: Hz
- BodyAccelerationJerkStandardDeviationAtZAxisFrequency   : Float, Average, Unit: Hz
- BodyGyroscopeStandardDeviationAtXAxisFrequency          : Float, Average, Unit: Hz
- BodyGyroscopeStandardDeviationAtYAxisFrequency          : Float, Average, Unit: Hz
- BodyGyroscopeStandardDeviationAtZAxisFrequency          : Float, Average, Unit: Hz
- BodyAccelerationMagnitudeStandardDeviationFrequency     : Float, Average, Unit: Hz
- BodyAccelerationJerkMagnitudeStandardDeviationFrequency : Float, Average, Unit: Hz
- BodyGyroscopeMagnitudeStandardDeviationFrequency        : Float, Average, Unit: Hz
- BodyGyroscopeJerkMagnitudeStandardDeviationFrequency    : Float, Average, Unit: Hz
