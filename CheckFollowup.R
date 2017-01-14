#Create data for checking of follow up VL for cases and controls

library(dplyr)
library(tidyr)
library(magrittr)


df <- read.csv2("FullData_10_13_2016.csv",header = TRUE, sep = ';')


df <- filter(df, df$case_control___1 == 'Case' |  df$case_control___2 == 'Control') 
df <- arrange(df, dt_cd4_enroll)

new <- select(df, patient_id, hiv_rna_enroll, dt_hiv_rna_enroll,cd4_enroll,dt_cd4_enroll, case_control___1, case_control___2) %>% unite(case, case_control___1, case_control___2,sep='', remove=TRUE)

newdf <- data.frame(lapply(new, as.character), stringsAsFactors=FALSE)
write.csv(newdf, file="checkfollowup_10_13_2016.csv")

