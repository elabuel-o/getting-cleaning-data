
##-----------------------------------------------------------------------------
## Title: Week 1 Quiz, Getting and Cleaning Data (Coursera)
## Date: January 11th, 2015
## Author: Armando Enriquez Z.
## ----------------------------------------------------------------------------

## setup
setwd("./week1")

##-----------------------------------------------------------------------------
## Question 1 
## The ACS distributes downloadable data about United States communities. 
## Download the 2006 microdata survey about housing for the state of Idaho 
## using download.file() from:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
## and load the data into R.

## How many properties are worth 1,000,000 or more?

url1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "./Idaho.csv")
idaho.data <- read.csv("Idaho.csv", header = TRUE)

## The variable "VAL" indicates the property value.
## Specifically, the variable value 24 indicates a worth >1,000,000
str(idaho.data$VAL)
oneM <- subset(idaho.data, VAL == 24)
dim(oneM) ## There are 53 properties worth >1,000,000.

##-----------------------------------------------------------------------------
## Question 2 
## Use the data you loaded form Q1. Consider the variable FES in the code book.
## Which of the "tidy data" principles does this variable violate?

## The "FES" actually considers two variables: Family type and Employment status

##-----------------------------------------------------------------------------
## Question 3 
## Download the excel spreadsheet on Natural Gas Aquisition Program:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
## Read rows 18-23 and columns 7-15 into R and assign the result to a variable
## called "dat".
## What is the value of the expression: sum(dat$Zip*dat$Ext, na.rm = T)?

library(xlsx)
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(url2, destfile = "./natgas.xlsx")

## We may read only the specified rows and cols
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("natgas.xlsx", sheetIndex = 1,
                 colIndex = colIndex, rowIndex = rowIndex)
sum(dat$Zip*dat$Ext, na.rm = TRUE) ## 36534720

##-----------------------------------------------------------------------------
## Question 4
## Read XML data on Baltimore restaurants from:
## https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
## How many restaurants have zipcode 21231?

library(XML)
url3 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(url3, useInternal =TRUE) ## do not use https! 
rootNode <- xmlRoot(doc) ## Displays the xml file

## We need to programmatically extract the zipcode node and sum
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == 21231) 
## There are 127 restaurants with zipcode 21231
