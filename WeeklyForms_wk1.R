setwd("~/Box Sync")

library(dplyr)
library(magrittr)
library(RCurl)
library(RJSONIO)
library(sjPlot)


#!/usr/bin/env Rscript
#!/usr/bin/env Rscript
library(RCurl)
result <- postForm(
  uri='https://redcap.emory.edu/api/',
  #Token here
  content='record',
  format='json',
  type='flat',
  'fields[0]'='study_site',
  'forms[0]'='alt_treatmentspiritual',
  'forms[1]'='concomitant_medications',
  'forms[2]'='medication_adherence',
  'forms[3]'='psychosocial_factors',
  'forms[4]'='sesaccess_healthcare',
  rawOrLabel='label',
  rawOrLabelHeaders='label',
  exportCheckboxLabel='true',
  exportSurveyFields='true',
  exportDataAccessGroups='true',
  returnFormat='json'
)





#JSON to Data Frame

json_file <- fromJSON(result) #JSON to List
df <- do.call("rbind", json_file) #List Clean
dataFrame <- as.data.frame.matrix(df) #List to DF
class(dataFrame)

#Clean Data

cats <- names(dataFrame)
categories <- dataFrame[, cats]
categories <- filter(categories, categories$redcap_data_access_group == "DRSS")
cats <- names(categories)


#Categorical data tables
categories[, cols <-
             cats] <- lapply(categories[, cols <- cats], unlist)
categories[, cols <-
             cats] <- lapply(categories[, cols <- cats], as.factor)
class(categories$income)
sjt.df(categories)

#Drop unused
categories <- select(categories, -contains("dt"))
categories <- select(categories, -contains("redcap"))
categories <- categories[, colSums(is.na(categories)) < nrow(categories)]
categories <- select(categories, -contains("timestamp"))

#Rerun tables
sjt.frq(categories)


#Clean Data frame

reduced <- filter(dataFrame, study_site == "Bethesda" | study_site == "RK Khan" )
reduced$hiv_rna1 <- as.numeric(as.character(reduced$hiv_rna1))
reduced$hiv_rna2 <- as.numeric(as.character(reduced$hiv_rna2))
reduced$hiv_rna3 <- as.numeric(as.character(reduced$hiv_rna3))
reduced$hiv_rna_enroll <- as.numeric(as.character(reduced$hiv_rna_enroll))

#Data Question



#Write To File
finalDF <- data.frame(lapply(reduced, as.character), stringsAsFactors=FALSE)
write.csv(finalDF, file="Fulldata_11_10_2016.csv")


