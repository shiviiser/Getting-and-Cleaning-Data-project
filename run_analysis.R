# for part 1 i.e merging data
train_data <- read.table("./data/train/X_train.txt")
train_label <- read.table("./data/train/y_train.txt")
train_subject <- read.table("./data/train/subject_train.txt")
test_data <- read.table("./data/test/X_test.txt")
test_label <- read.table("./data/test/y_test.txt")
test_subject <- read.table("./data/test/subject_test.txt")
join_data <- rbind(train_data, test_data)
join_label <- rbind(train_label, test_label)
join_subject <- rbind(train_subject, test_subject)
# extracting only the mesurments on the mean and standard
features <- read.table("./data/features.txt")
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
join_data <- join_data[, mean_std_indices]
# naming and cleaning data, removing () and -, captilizing M and S
names(join_data) <- gsub("\\(\\)", "", features[mean_std_indices, 2])
names(join_data) <- gsub("mean", "Mean", names(join_data))
names(join_data) <- gsub("std", "Std", names(join_data))
names(join_data) <- gsub("-", "", names(join_data))
# naming the activity in the data set
activity <- read.table("./data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activity_label <- activity[join_label[, 1], 2]
join_label[, 1] <- activity_label
# labeling the data and writing 1st dataset
names(join_label) <- "activity"
names(join_subject) <- "subject"
cleaned_data <- cbind(join_subject, join_label, join_data)
write.table(cleaned_data, "merged_data.txt")

# creating second tidy data set with avg of each variable for each activity and subject
sub_len <- length(table(join_subject))
act_len <- dim(activity)[1]
col_len <- dim(cleaned_data)[2]
result <- matrix(NA, nrow= sub_len * act_len, ncol = col_len)
result <- as.data.frame(result)
colnames(result) <- colnames(cleaned_data)
row <- 1
for(i in 1:sub_len){
        for(j in 1:act_len){
                result[row, 1] <- sort(unique(join_subject)[, 1])[i]
                result[row, 2] <- activity[j, 2]
                bool1 <- i == cleaned_data$subject
                bool2 <- activity[j, 2] == cleaned_data$activity
                result[row, 3:col_len] <- colMeans(cleaned_data[bool1&bool2, 3:col_len])
                row <- row +1
        }
}
# write 2nd data
write.table(result, "data_with_means.txt")