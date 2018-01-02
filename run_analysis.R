library(dplyr)

## Read data and name variables
#test
x_test = read.table('X_test.txt')
y_test = read.table('Y_test.txt')
subject_test = data.frame(subject = readLines('subject_test.txt'))

#train
x_train = read.table('X_train.txt')
y_train = read.table('Y_train.txt')
subject_train = data.frame(subject = readLines('subject_train.txt'))


# features
features = readLines('C://Users//k.anthis//Desktop//Rmarkdown&Leaflet//ReproducibleRechearch//UCI HAR Dataset//features.txt')

# bind X with Y
test = bind_cols(x_test,y_test,subject_test)
train = bind_cols(x_train,y_train,subject_train)

# Name variables with descriptive title
names(test) = c(features,"Activities","subject")
names(train) = c(features,"Activities","subject")

# bind train and test set
full_dataset = bind_rows(train,test)

# name activities
full_dataset$Activities = factor(full_dataset$Activities, 
                        levels = c(1:6), 
                        labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))

full_dataset$subject = factor(full_dataset$subject)

# question 4

mean_set <- full_dataset %>% select(contains('mean()'))
std_set <-  full_dataset %>% select(contains('std()'))
only_set <- bind_cols(mean_set,std_set)

# 5 second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_dataset <- full_dataset %>% group_by(Activities,subject) %>% summarise_all(funs(mean))

## write csv
write.table(tidy_dataset, 'tidy_dataset.txt', row.name = F)
