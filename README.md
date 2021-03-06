---
title: "README"
author: "Konstantinos"
date: "28 December 2017"
output: 
  html_document: 
    keep_md: true
---


# Read train and test data and feature names

```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```


##test

```r
x_test = read.table('C://Users//k.anthis//Desktop//Rmarkdown&Leaflet//ReproducibleRechearch//UCI HAR Dataset//test//X_test.txt')
y_test = read.table('C://Users//k.anthis//Desktop//Rmarkdown&Leaflet//ReproducibleRechearch//UCI HAR Dataset//test//Y_test.txt')
subject_test = data.frame(subject = readLines('C://Users//k.anthis//Desktop//Rmarkdown&Leaflet//ReproducibleRechearch//UCI HAR Dataset//test//subject_test.txt'))
```

##train

```r
x_train = read.table('C://Users//k.anthis//Desktop//Rmarkdown&Leaflet//ReproducibleRechearch//UCI HAR Dataset//train//X_train.txt')
y_train = read.table('C://Users//k.anthis//Desktop//Rmarkdown&Leaflet//ReproducibleRechearch//UCI HAR Dataset//train//Y_train.txt')
subject_train = data.frame(subject = readLines('C://Users//k.anthis//Desktop//Rmarkdown&Leaflet//ReproducibleRechearch//UCI HAR Dataset//train//subject_train.txt'))
```

## features

```r
features = readLines('C://Users//k.anthis//Desktop//Rmarkdown&Leaflet//ReproducibleRechearch//UCI HAR Dataset//features.txt')
```
# Merge the training and the test sets to create one data set.


```r
test = bind_cols(x_test,y_test,subject_test)
train = bind_cols(x_train,y_train,subject_train)
full_dataset = bind_rows(train,test)
```

```
## Warning in bind_rows_(x, .id): Unequal factor levels: coercing to character
```

```
## Warning in bind_rows_(x, .id): binding character and factor vector,
## coercing into character vector

## Warning in bind_rows_(x, .id): binding character and factor vector,
## coercing into character vector
```
# Appropriately labels the data set with descriptive variable names.


```r
names(full_dataset) = c(features,"Y","subject")
```




# Uses descriptive activity names to name the activities in the data set


```r
full_dataset$Y = factor(full_dataset$Y, 
                        levels = c(1:6), 
                        labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
full_dataset$subject = factor(full_dataset$subject)
```

# Extracts only the measurements on the mean and standard deviation for each measurement.


```r
mean_set <- full_dataset %>% select(contains('mean()'))
std_set <-  full_dataset %>% select(contains('std()'))
only_set <- bind_cols(mean_set,std_set)
```

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


```r
tidy_dataset <- full_dataset %>% group_by(Y,subject) %>% summarise_all(funs(mean))
```

