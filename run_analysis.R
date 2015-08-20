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

  names(subject.train) <- c("subject_id")
  names(subject.test) <- c("subject_id")

  full.train <- cbind(x.train, subject.train, y.train)
  full.test <- cbind(x.test, subject.test, y.test)

  FD <- rbind(full.train, full.test)

  return(FD)
}


Serket.run <- function() {
  raw.data <- LoadData()

  FD <- MergeData(raw.data)

  print( dim(FD) )
}

Serket.run()

