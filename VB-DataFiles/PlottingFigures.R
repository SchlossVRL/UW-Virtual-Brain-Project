
##################################
### UW Virtual Brain Project  ####
#################################

#This file contains code for creating plots of the data from the UW Virtual Brain Project. 



# STEM Content ------------------------------------------------------------

#This code plots a bar graph of mean change in performance ratings for STEM content learning for each device (VR, PC)

#Files:
#STEM-Exp1A.csv
#STEM-Exp1B.csv
#STEM-Exp2.csv

#Packages needed: 
library(reshape2)
library(lmSupport)
library(ggplot2)


#read in the data
d = read.csv("STEM-Exp1A.csv")

#Convert data to long format (drops unused variables) 
dL = melt(d, id.vars = c('Subj','Condition','DeviceOrderC', 'SystemOrderC', 'SystemDeviceC'), measure.vars = c('PCLesson','VRLesson'), 
          variable.name = 'DeviceLesson', value.name = 'Performance')
d = dL


# Bar graph of Performance by device (PC vs VR)
mPlot = lm(Performance ~ DeviceLesson, data=d) 
pY = data.frame(DeviceLesson = c('PCLesson','VRLesson')) 
pY = modelPredictions(mPlot, pY)

DeviceSTEM = ggplot(data=pY, aes(x = DeviceLesson, y = Predicted, fill = DeviceLesson)) +
  geom_bar(stat='identity', position=position_dodge(.9), width=.5) +
  geom_errorbar(aes(ymin = CILo, ymax = CIHi), position = position_dodge(.9), width=.2) +
  labs(y = 'Performance (Post-Pre)', x = 'Device') +
  theme(legend.position = 'none') 
DeviceSTEM




# Experience Questionnaire ------------------------------------------------

#This code plots a bar graph with mean ratings for each experience questionnaire item by device (PC vs VR).

#Files:
#Experience-Exp1A.csv
#Experience-Exp1B.csv
#Experience-Exp2.csv

#Packages needed
library(stringr)
library(reshape2)
library(lmSupport)
library(ggplot2)



#read in the data
d <-read.csv("Experience-Exp1A.csv")


#Convert to long format
dL = melt(d, id.vars = c('Subj'), measure.vars = c("AweInspiring.VR" , "Aesthetically.VR","Enjoy.VR", "OwnStudies.VR","RecLearn.VR","RecFun.VR","EaseControl.VR", "AveEnjoy.VR", "AweInspiring.PC" , "Aesthetically.PC","Enjoy.PC", "OwnStudies.PC","RecLearn.PC","RecFun.PC","EaseControl.PC", "AveEnjoy.PC"), 
          variable.name = 'Item', value.name = 'Rating')

#Create new variable for device (PC vs VR)
dL$Device = str_sub(dL$Item, -2, -1)  

#Clean name of items
dL$Item = str_sub(dL$Item, 1,5) 
                      


# Bar graph of each item
mPlot = lm(Rating~ Device*Item, data=dL) # make a model using string version of assignment variable
pY = expand.grid(Device = c('VR','PC'), Item = c("AweIn" , "Aesth","Enjoy", "OwnSt","RecLe","RecFu","EaseC", "AveEn")) # data frame with names of levels of IV
pY = modelPredictions(mPlot, pY)

DeviceExp = ggplot(data=pY, aes(x = Item, y = Predicted, fill = Device)) +
  geom_bar(stat='identity', position=position_dodge(.9), width=.5) +
  geom_errorbar(aes(ymin = CILo, ymax = CIHi), position = position_dodge(.9), width=.2) +
  labs(y = 'Rating', x = 'Device') +
  coord_flip() + 
  scale_y_continuous(breaks=seq(1,7,1))
DeviceExp




# Simulator Sickness Questionnaire ----------------------------------------

#This code plots line graphs of mean ratings for each simulator sickness symptom (headache, eyestrain, nausea, dizziness)
# by timepoint (1,2,3) and by order of device (PC first vs VR first) 

#Files:
#SSQ-Exp1A.csv
#SSQ-Exp1B.csv
#SSQ-Exp2.csv

#Packages needed
library(stringr)
library(reshape2)
library(lmSupport)
library(ggplot2)



#Read in the data
d <-read.csv("SSQ-Exp1A.csv")


#Convert to long format (drops repeated Headache measures- AveHeadache is the average of the two ratings)
dL = melt(d, id.vars = c('Subj', 'DeviceOrderC'), measure.vars = c("Q1.AveHeadache" , "Q1.eyestrain", "Q1.nausea", "Q1.dizziness", "Q2.AveHeadache" , "Q2.eyestrain", "Q2.nausea", "Q2.dizziness", "Q3.AveHeadache" , "Q3.eyestrain", "Q3.nausea", "Q3.dizziness"), 
          variable.name = 'Question', value.name = 'Rating')

#Create new variable for device (PC vs VR)
dL$Timepoint = str_sub(dL$Question, 1 ,2)  
dL$Timepoint = varRecode(dL$Timepoint, c("Q1", "Q2", "Q3"), c(1,2,3))


#Clean name of questions
dL$Question = str_sub(dL$Question, 4,18) 

#Create string labels for device order
dL$DeviceOrderStr = varRecode(dL$DeviceOrderC, c(0,1), c("PCFirst", "VRFirst"))
                              

#Line graph of each symptom at each timepoint 
mPlot = lm(Rating ~ Timepoint*Question*DeviceOrderStr, data=dL) # make a model using string version of assignment variable
pY = expand.grid(Timepoint = c(1,2,3), Question = c("AveHeadache", "eyestrain", "nausea", "dizziness"), DeviceOrderStr = c("PCFirst", "VRFirst")) # data frame with names of levels of IV
pY = modelPredictions(mPlot, pY)

SSQOrder = ggplot(data=pY, aes(x = Timepoint, y  = Predicted, color = DeviceOrderStr)) +
  geom_point(stat='identity')+ # position=position_dodge(.5)) +
  geom_line()+
  geom_errorbar(aes(ymin = CILo, ymax = CIHi), width = .08)+#, position = position_dodge(.5), width=.2) +
  labs(y = 'Rating', x = 'Time Point') +
  facet_wrap(~Question)+
  #theme(legend.position = 'none') +
  #coord_cartesian(expand=c(0,0))  +
  ylim(c(1,4))
SSQOrder





# Classroom Data ----------------------------------------------------------

#This code plots a bar graph of mean ratings for three classroom learning outcomes by each perceptual system (visual, auditory)

#Files:
#ClassroomReports-Exp3.csv

#Packages needed
library(stringr)
library(reshape2)
library(lmSupport)
library(ggplot2)



#Read in the data
d <-read.csv("ClassroomReports-Exp3.csv")


#Reshape to long (drops whether participated or not- all particpants in this file evaluated both systems)
dL = melt(d, id.vars = c('Subj'), measure.vars = c("V.input",	"V.pathways",		"V.purpose"	, "A.input",	"A.pathways",		"A.purpose"),
          variable.name = 'Outcome', value.name = 'Rating')

#Create new variable for system (visual vs auditory)
dL$System = str_sub(dL$Outcome, 1,1)

#Clean name of outcomes
dL$Outcome = str_sub(dL$Outcome, 3,10)


#Bar graph of each outcome by sensory sytem
mPlot = lm(Rating~ Outcome*System, dL)
pY = expand.grid(Outcome = c("input", "pathways" ,"purpose"), System = c("V","A"))
pY = modelPredictions(mPlot, pY)

ClassPlot = ggplot(pY, aes(x= Outcome, y= Predicted, fill= System)) +
  geom_bar(stat= 'identity', position = position_dodge(.9)) + 
  geom_errorbar(aes(ymin= CILo, ymax = CIHi), position = position_dodge(.9), width= .25) +
  labs(y = 'Rating', x = 'Learning Outcome') +
  theme(legend.position = 'none') +
  ylim(c(0,5))+
  coord_cartesian(expand=c(0,0)) 
ClassPlot
