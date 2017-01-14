setwd("~/Box Sync/demo")

library(dplyr)
library(RCurl)
library(RJSONIO)
require(sjPlot) # load package
library(tidyr)

#!/usr/bin/env Rscript
library(RCurl)
result <- postForm(
  uri='https://redcap.emory.edu/api/',
  #token here
  content='record',
  format='json',
  type='flat',
  'forms[0]'='demographics',
  rawOrLabel='label',
  rawOrLabelHeaders='label',
  exportCheckboxLabel='true',
  exportSurveyFields='true',
  exportDataAccessGroups='false',
  returnFormat='json'
)
print(result)






#JSON to Data Frame

json_file <- fromJSON(result) #JSON to List
df <- do.call("rbind", json_file) %>%  as.data.frame.matrix(df) #List to DF
class(df)

#Filter
reduced <- filter(df,df$study_site == 'Bethesda' |  df$study_site == 'RK Khan')
reduced <- select(reduced, -c(patient_id,
                              case_control___1, 
                              case_control___2,
                              dt_visit, 
                              foll_st_dt, 
                              dob,
                              nevirapine_dt,
                              demographics_complete, 
                              address, 
                              redcap_data_access_group, 
                              redcap_survey_identifier, 
                              demographics_timestamp )) 


#Data Question

# simple frequency table
sjt.frq(reduced)








