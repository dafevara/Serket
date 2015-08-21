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

MergeData <- function(raw.data = NULL){
  x.train       <- raw.data$x.train
  subject.train <- raw.data$subject.train
  y.train       <- raw.data$y.train

  x.test        <- raw.data$x.test
  subject.test  <- raw.data$subject.test
  y.test        <- raw.data$y.test

  names(subject.train)  <- c("subject_id")
  names(subject.test)   <- c("subject_id")
  names(y.train)        <- c("activity_label_id")
  names(y.test)         <- c("activity_label_id")

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
  activities.data <- input.data$activity_label_id

  extracted.data <- cbind(mean.data, std.data, activity_label_id=activities.data)
}

AddActivityLabels <- function(input.data = null, file.path=''){
  if(!file.exists(file.path)){
    print("Please provide an existing file path for activity labels")
    stop()
  }

  activity.labels <- read.table(file.path)
  names(activity.labels) <- c('activity_label_id', 'activity_label')

  merge.data <- merge(input.data, activity.labels, by.x="activity_label_id", by.y="activity_label_id", sort=FALSE)

  return(merge.data)

}


Serket.run <- function() {
  raw.data <- LoadData()

  dataset.baseline <- MergeData(raw.data)

  print( dim(dataset.baseline) )

  extracted.data <- ExtractMeanAndStd(dataset.baseline)

  print(dim(extracted.data))

  merged.data <- AddActivityLabels(extracted.data, paste(DATA_DIR, 'activity_labels.txt', sep='/'))

  print(dim(merged.data))

}

Serket.run()

