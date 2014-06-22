# This file contains the R code necessary to analyze UCI's Machine Learning Repository.
# dataset for classifying human activity based on accelerometer and gyroscope data from .
# smartphones.

library(plyr)

# First, we read the training and data sets into the data frames train.df and test.df

train.df <- read.table("UCI HAR Dataset/train/X_train.txt")
train.subj.df <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names=c("SubjectId"))
train.act.df <- read.table("UCI HAR Dataset/train/y_train.txt", col.names=c("ActivityCode"))
test.df <- read.table("UCI HAR Dataset/test/X_test.txt")
test.subj.df <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names=c("SubjectId"))
test.act.df <- read.table("UCI HAR Dataset/test/y_test.txt", col.names=c("ActivityCode"))


# The first task is to merge the training set and test set into a single data frame
# First we join the three tables making up an observation into a single row, then
# we combine the rows from the training and test sets into a single data frame

train.all.df <- cbind(train.subj.df, train.act.df, train.df)
test.all.df <- cbind(test.subj.df, test.act.df, test.df)
combined.df <- rbind(train.all.df, test.all.df)

# The second task is to extract only the mean and stddev for each measurement.
# The third task is to use descriptive activity names instead of the activity codes.
# The fourth task is to label the columns nicely. It is convenient to do all
# of these at once, so we do so here.  We construct the tidy data set observations.df.

# The map below shows how the names in the combined.df data.frame should be
# called in observations.df.

map <- data.frame(origname=character(), goodname=character(), stringsAsFactors=FALSE)
#map[nrow(map)+1,] <- c("SubjectId", "SubjectId")
#map[nrow(map)+1,] <- c("ActivityCode", "ActivityCode")

map[nrow(map)+1,] <- c("V1", "tBodyAccX-mean")
map[nrow(map)+1,] <- c("V2", "tBodyAccY-mean")
map[nrow(map)+1,] <- c("V3", "tBodyAccZ-mean")
map[nrow(map)+1,] <- c("V4", "tBodyAccX-std")
map[nrow(map)+1,] <- c("V5", "tBodyAccY-std")
map[nrow(map)+1,] <- c("V6", "tBodyAccZ-std")

map[nrow(map)+1,] <- c("V41", "tGravityAccX-mean")
map[nrow(map)+1,] <- c("V42", "tGravityAccY-mean")
map[nrow(map)+1,] <- c("V43", "tGravityAccZ-mean")
map[nrow(map)+1,] <- c("V44", "tGravityAccX-std")
map[nrow(map)+1,] <- c("V45", "tGravityAccY-std")
map[nrow(map)+1,] <- c("V46", "tGravityAccZ-std")

map[nrow(map)+1,] <- c("V81", "tBodyAccJerkX-mean")
map[nrow(map)+1,] <- c("V82", "tBodyAccJerkY-mean")
map[nrow(map)+1,] <- c("V83", "tBodyAccJerkZ-mean")
map[nrow(map)+1,] <- c("V84", "tBodyAccJerkX-std")
map[nrow(map)+1,] <- c("V85", "tBodyAccJerkY-std")
map[nrow(map)+1,] <- c("V86", "tBodyAccJerkZ-std")

map[nrow(map)+1,] <- c("V121", "tBodyGyroX-mean")
map[nrow(map)+1,] <- c("V122", "tBodyGyroY-mean")
map[nrow(map)+1,] <- c("V123", "tBodyGyroZ-mean")
map[nrow(map)+1,] <- c("V124", "tBodyGyroX-std")
map[nrow(map)+1,] <- c("V125", "tBodyGyroY-std")
map[nrow(map)+1,] <- c("V126", "tBodyGyroZ-std")

map[nrow(map)+1,] <- c("V161", "tBodyGyroJerkX-mean")
map[nrow(map)+1,] <- c("V162", "tBodyGyroJerkY-mean")
map[nrow(map)+1,] <- c("V163", "tBodyGyroJerkZ-mean")
map[nrow(map)+1,] <- c("V164", "tBodyGyroJerkX-std")
map[nrow(map)+1,] <- c("V165", "tBodyGyroJerkY-std")
map[nrow(map)+1,] <- c("V166", "tBodyGyroJerkZ-std")

map[nrow(map)+1,] <- c("V201", "tBodyAccMag-mean")
map[nrow(map)+1,] <- c("V202", "tBodyAccMag-std")

map[nrow(map)+1,] <- c("V214", "tGravityAccMag-mean")
map[nrow(map)+1,] <- c("V215", "tGravityAccMag-std")

map[nrow(map)+1,] <- c("V227", "tBodyAccJerkMag-mean")
map[nrow(map)+1,] <- c("V228", "tBodyAccJerkMag-std")

map[nrow(map)+1,] <- c("V240", "tBodyGyroMag-mean")
map[nrow(map)+1,] <- c("V241", "tBodyGyroMag-std")

map[nrow(map)+1,] <- c("V253", "tBodyGyroJerkMag-mean")
map[nrow(map)+1,] <- c("V254", "tBodyGyroJerkMag-std")

map[nrow(map)+1,] <- c("V266", "fBodyAccX-mean")
map[nrow(map)+1,] <- c("V267", "fBodyAccY-mean")
map[nrow(map)+1,] <- c("V268", "fBodyAccZ-mean")
map[nrow(map)+1,] <- c("V269", "fBodyAccX-std")
map[nrow(map)+1,] <- c("V270", "fBodyAccY-std")
map[nrow(map)+1,] <- c("V271", "fBodyAccZ-std")
#map[nrow(map)+1,] <- c("V294", "fBodyAccX-meanFreq")
#map[nrow(map)+1,] <- c("V295", "fBodyAccY-meanFreq")
#map[nrow(map)+1,] <- c("V296", "fBodyAccZ-meanFreq")

map[nrow(map)+1,] <- c("V345", "fBodyAccJerkX-mean")
map[nrow(map)+1,] <- c("V346", "fBodyAccJerkY-mean")
map[nrow(map)+1,] <- c("V347", "fBodyAccJerkZ-mean")
map[nrow(map)+1,] <- c("V348", "fBodyAccJerkX-std")
map[nrow(map)+1,] <- c("V349", "fBodyAccJerkY-std")
map[nrow(map)+1,] <- c("V350", "fBodyAccJerkZ-std")
#map[nrow(map)+1,] <- c("V373", "fBodyAccJerkX-meanFreq")
#map[nrow(map)+1,] <- c("V374", "fBodyAccJerkY-meanFreq")
#map[nrow(map)+1,] <- c("V375", "fBodyAccJerkZ-meanFreq")

map[nrow(map)+1,] <- c("V424", "fBodyGyroX-mean")
map[nrow(map)+1,] <- c("V425", "fBodyGyroY-mean")
map[nrow(map)+1,] <- c("V426", "fBodyGyroZ-mean")
map[nrow(map)+1,] <- c("V427", "fBodyGyroX-std")
map[nrow(map)+1,] <- c("V428", "fBodyGyroY-std")
map[nrow(map)+1,] <- c("V429", "fBodyGyroZ-std")
#map[nrow(map)+1,] <- c("V452", "fBodyGyroX-meanFreq")
#map[nrow(map)+1,] <- c("V453", "fBodyGyroY-meanFreq")
#map[nrow(map)+1,] <- c("V454", "fBodyGyroZ-meanFreq")

map[nrow(map)+1,] <- c("V503", "fBodyAccMag-mean")
map[nrow(map)+1,] <- c("V504", "fBodyAccMag-std")
#map[nrow(map)+1,] <- c("V513", "fBodyAccMag-meanFreq")

map[nrow(map)+1,] <- c("V516", "fBodyAccJerkMag-mean")
map[nrow(map)+1,] <- c("V517", "fBodyAccJerkMag-std")
#map[nrow(map)+1,] <- c("V526", "fBodyAccJerkMag-meanFreq")

map[nrow(map)+1,] <- c("V529", "fBodyGyroMag-mean")
map[nrow(map)+1,] <- c("V530", "fBodyGyroMag-std")
#map[nrow(map)+1,] <- c("V539", "fBodyGyroMag-meanFreq")

map[nrow(map)+1,] <- c("V542", "fBodyGyroJerkMag-mean")
map[nrow(map)+1,] <- c("V543", "fBodyGyroJerkMag-std")
#map[nrow(map)+1,] <- c("V552", "fBodyGyroJerkMag-meanFreq")

# Now we create the tidy data set observations.df.  We start with the
# special columns SubjectId and ActivityCode. We also map ActivityCodes
# to Activitys.

observations.df = data.frame(SubjectId =  combined.df[,"SubjectId"])
observations.df[,"ActivityCode"] <- combined.df[,"ActivityCode"]
observations.df[,"Activity"] <- "UNKNOWN"
observations.df[combined.df["ActivityCode"]==1,"Activity"] <- "WALKING"
observations.df[combined.df["ActivityCode"]==2,"Activity"] <- "WALKING_UPSTAIRS"
observations.df[combined.df["ActivityCode"]==3,"Activity"] <- "WALKING_DOWNSTAIRS"
observations.df[combined.df["ActivityCode"]==4,"Activity"] <- "SITTING"
observations.df[combined.df["ActivityCode"]==5,"Activity"] <- "STANDING"
observations.df[combined.df["ActivityCode"]==6,"Activity"] <- "LAYING"

# Finally, we copy over the other columns to the tidy data set, using the
# map to rename columns as appropriate.

for (i in 1:nrow(map)) {
   observations.df[,map[i,"goodname"]] <- combined.df[,map[i,"origname"]] 
}

# The fifth task is to create a tidy summary data set that just has the averages
# of each column, grouped by subject and activity.  We place the result in the
# data.frame summary.observations.df

summary.observations.df <- ddply(observations.df,.(SubjectId, Activity),numcolwise(mean,na.rm = TRUE))

# Finally, we need to export the summary.observations.df tidy data set to a CSV file for others to use.

write.csv(summary.observations.df, file="summary-observations.csv", row.names = FALSE)

