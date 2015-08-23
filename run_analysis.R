library(dplyr)

DATA_DIR <- "./UCI\ HAR\ Dataset"

LoadData <- function() {
  if(!file.exists(DATA_DIR)){
    print("Data dir do not exist. Please provide the Dataset Dir")
    stop()
  }

  # X_train data
  XL <- read.table(paste(DATA_DIR, 'train/X_train.txt', sep='/'))
  #Subject Train Data
  SL <- read.table(paste(DATA_DIR, 'train/subject_train.txt', sep='/'))
  #activity id Data
  YL <- read.table(paste(DATA_DIR, 'train/y_train.txt', sep='/'))


  # X_train data
  XT <- read.table(paste(DATA_DIR, 'test/X_test.txt', sep='/'))
  #Subject Train Data
  ST <- read.table(paste(DATA_DIR, 'test/subject_test.txt', sep='/'))
  #activity id Data
  YT <- read.table(paste(DATA_DIR, 'test/y_test.txt', sep='/'))


  return(list(x.train=XL, subject.train=SL, y.train=YL,
              x.test=XT, subject.test=ST, y.test=YT))
}

ClipData <- function(raw.data = NULL){
  x.train       <- raw.data$x.train
  subject.train <- raw.data$subject.train
  y.train       <- raw.data$y.train

  x.test        <- raw.data$x.test
  subject.test  <- raw.data$subject.test
  y.test        <- raw.data$y.test

  names(subject.train)  <- c("SubjectId")
  names(subject.test)   <- c("SubjectId")
  names(y.train)        <- c("ActivityLabelId")
  names(y.test)         <- c("ActivityLabelId")

  full.train <- cbind(x.train, subject.train)
  full.test <- cbind(x.test, subject.test)

  dataset.baseline <- rbind(full.train, full.test)

  y.data <- rbind(y.train, y.test)

  dataset.baseline <- cbind(dataset.baseline, y.data)

  return(dataset.baseline)
}

FeaturesIndex <- function(feature.pattern = '', file.path = ''){
  if(!file.exists(file.path)){
    print("Please provide an existing feature files path")
    stop()
  }

  file.data <- read.table(file.path)
  measure.index <- grep(feature.pattern, file.data$V2, ignore.case=FALSE, value=FALSE)

  return(measure.index)
}

ExtractMeanAndStd <- function(input.data = NULL){
  mean.index  <- FeaturesIndex('mean', paste(DATA_DIR, 'features.txt', sep='/'))
  std.index   <- FeaturesIndex('std', paste(DATA_DIR, 'features.txt', sep='/'))

  mean.data       <- input.data[, mean.index]
  std.data        <- input.data[, std.index]

  # Activity and Subject data is added with the purpose of keep consistency
  # through the whole process even though it's required only mean and std data.
  activities.data <- input.data$ActivityLabelId
  subjects.data   <- input.data$SubjectId

  extracted.data <- cbind(mean.data, std.data, ActivityLabelId=activities.data, SubjectId=subjects.data)
}

ActivityLabels <- function(file.path=''){
  if(!file.exists(file.path)){
    print("Please provide an existing file path for activity labels")
    stop()
  }

  activity.labels <- read.table(file.path)
  names(activity.labels) <- c('ActivityLabelId', 'ActivityLabel')

  return(activity.labels)
}

MergeData <- function(input.data = NULL, activity.data = NULL){
  merge.data <- merge(input.data, activity.data, by.x="ActivityLabelId", by.y="ActivityLabelId", sort=FALSE)

  return(merge.data)
}

AddSelfExplainNames <- function(dataset, featurelist.path){
  dataset.names <- names(dataset)

  if(!file.exists(featurelist.path)){
    print("Please provide an existing file path for features list")
    stop()
  }

  features <- read.table(featurelist.path)
  raw.colnames <- dataset.names[!dataset.names %in% c("ActivityLabelId", 'ActivityLabel', 'SubjectId')]
  target.names <- gsub("V", "", raw.colnames)

  raw.feat.names <- features[as.numeric(target.names), ]
  raw.feat.names$V2 <- sapply(raw.feat.names$V2, FUN=GenerateHumanReadableName)

 for(x in raw.feat.names$V1){ 
    position <- match(paste("V", x, sep=''), dataset.names)
    new.name <- raw.feat.names[raw.feat.names$V1 == x,]$V2
    #num.row <- as.numeric(sub("V", '', x))

    names(dataset)[position] <- new.name
  }

  #Arrange in favor of readability
  dataset <- arrange(dataset, SubjectId, ActivityLabelId)

  return(dataset)
}


GenerateHumanReadableName <- function(not.readable = NULL){

  tokens <- list(
                "Body" = "Body",
                "Acc" = "Acceleration",
                "Gyro" = "Gyroscope",
                "Jerk" = "Jerk",
                "mean()" = "Mean",
                "std()" = "StandardDeviation",
                "meanFreq()" = "MeanFreq",
                "Mag" = "Magnitude",
                "-" = '',
                "-X" = "AtXAxis",
                "-Y" = "AtYAxis",
                "-Z" = "AtZAxis",
                "BodyBody" = "Body",
                "FrequencyFrequency" = "Frequency"
             )

  measure.key <- substr(not.readable, 0,1)
  not.readable <- toString(not.readable)
  
  if( measure.key %in% c('t', 'f')){
    not.readable <- substr(not.readable, 2, nchar(not.readable))

    if (measure.key == 't'){
      not.readable <- paste(not.readable, "Time", sep='')
    }

    if (measure.key == 'f') {
      not.readable <- paste(not.readable, "Frequency", sep='')
    }
  }

  for(token in names(tokens)){
    not.readable <- sub(token, tokens[token], not.readable, fixed=TRUE, ignore.case=FALSE)
  }

  return(not.readable)

}

CreateSummarized <- function(input.data = NULL){
  group.input.data <- group_by(input.data, SubjectId, ActivityLabelId, ActivityLabel)
  summ.data <- summarise_each(group.input.data, funs(mean))

  return(summ.data)
}

Serket.run <- function() {
  
  # Step 1
  raw.data <- LoadData()
  dataset.baseline <- ClipData(raw.data)

  ## Step 2
  extracted.data <- ExtractMeanAndStd(dataset.baseline)
  ## Step 3
  activity.data <- ActivityLabels(paste(DATA_DIR, 'activity_labels.txt', sep='/'))
  merged.data <- MergeData(input.data=extracted.data, activity.data=activity.data)

  # Step 4
  human.readable.dataset <- AddSelfExplainNames(merged.data, paste(DATA_DIR, 'features.txt', sep='/'))

  # Step 5
  summ.data <- CreateSummarized(human.readable.dataset)

  return(summ.data)
}

Serket.run()

