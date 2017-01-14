# (1)Copying follow up CD4 with dates into CD4 1-7 slots
# (2) CD4 <20 and VL CSP correction
# (3) Verify VL 124 corrections
# (4) Run a merge comparison of May spreadsheet
# (5)    Produce previous manuscripts’ tables in SAS and relevant SOPs for future use in Emory Box – will do after completing reporting


library(gtools)
library(gmodels)
df <- read.csv2("Fulldata_09_17_2016.csv",header = TRUE, sep = ',')
cD4DF <- select(df, contains("cd4"), patient_id)

cD4DF <- data.frame(lapply(cD4DF, as.character), stringsAsFactors=FALSE)

#Clear CD4_Enroll
cd40Valid <- filter(cD4DF, cD4DF$cd4_enroll != '' & !invalid(cD4DF$dt_cd4_enroll))
cd40InValidCD4 <- filter(cD4DF, cD4DF$cd4_enroll == '' & !invalid(cD4DF$dt_cd4_enroll))
cd40InValidDT <-filter(cD4DF, cD4DF$cd4_enroll != '' & invalid(cD4DF$dt_cd4_enroll))

#Clear CD4_1 
cd41Valid <- filter(cD4DF, cD4DF$cd4_1 != '' & !invalid(cD4DF$dt_cd4_1))
cd41InValidCD4 <- filter(cD4DF, cD4DF$cd4_1 == '' & !invalid(cD4DF$dt_cd4_1))
cd41InValidDT <-filter(cD4DF, cD4DF$cd4_1 != '' & invalid(cD4DF$dt_cd4_1))

#Clear CD4_2
cd42Valid <- filter(cD4DF, cD4DF$cd4_2 != '' & !invalid(cD4DF$dt_cd4_2))
cd42InValidCD4 <- filter(cD4DF, cD4DF$cd4_2 == '' & !invalid(cD4DF$dt_cd4_2))
cd42InValidDT <-filter(cD4DF, cD4DF$cd4_2 != '' & invalid(cD4DF$dt_cd4_2))

#Clear CD4_3
cd43Valid <- filter(cD4DF, cD4DF$cd4_3 != '' & !invalid(cD4DF$dt_cd4_3))
cd43InValidCD4 <- filter(cD4DF, cD4DF$cd4_3 == '' & !invalid(cD4DF$dt_cd4_3))
cd43InValidDT <-filter(cD4DF, cD4DF$cd4_3 != '' & invalid(cD4DF$dt_cd4_3))



#Check Followup CD4_Enroll
cd40ValidFollowup <- filter(cD4DF, cD4DF$cd4_enroll != cD4DF$cd4_enroll_follow)
cd40InValidCD4Followup <- filter(cD4DF, cD4DF$dt_cd4_enroll != cD4DF$dt_cd4_enroll_follow)


#Check Followup CD4_1
cd41ValidFollowup <- filter(cD4DF, cD4DF$cd4_1 != cD4DF$cd4_1_follow)
cd41InValidCD4Followup <- filter(cD4DF, cD4DF$dt_cd4_1 != cD4DF$dt_cd4_1_follow)

#Check Followup CD4_2
cd42ValidFollowup <- filter(cD4DF, cD4DF$cd4_2 != cD4DF$cd4_2_follow)
cd42InValidCD4Followup <- filter(cD4DF, cD4DF$dt_cd4_2 != cD4DF$dt_cd4_2_follow)

#Enrollment Issue ****Waiting to hear from vince****
cd4EnrollIssue <- filter(cD4DF, cD4DF$cd4_1 != cD4DF$cd4_enroll)
cd4EnrollIssue <- select(cd4EnrollIssue, patient_id, cd4_1, cd4_enroll )
cd4EnrollIssueDT <- filter(cD4DF, cD4DF$dt_cd4_1 != cD4DF$dt_cd4_enroll)
cd4EnrollIssueDT <- select(cd4EnrollIssueDT, patient_id, dt_cd4_1, dt_cd4_enroll )
summary(cD4DF)



