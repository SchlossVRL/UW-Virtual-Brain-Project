* Encoding: UTF-8.

*------------------------------------------------------------

*STEM content-based learning outcomes
*FILES: 
*    STEM-Exp1a.csv
*    STEM-Exp1b.csv
*    STEM-Exp2.csv
*    STEM-All.csv

* paired samples t-test for Visual and Auditory lesson pre-test scores.
T-TEST PAIRS=Visual.Pre WITH Auditory.Pre (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.


* independent samples t-test for PC and VR lessons (testing change in performance against zero). 
T-TEST
  /TESTVAL=0
  /MISSING=ANALYSIS
  /VARIABLES=PCLesson VRLesson
  /CRITERIA=CI(.95).


* paired samples t-test comparing PC and VR lessons.
T-TEST PAIRS=PCLesson WITH VRLesson (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.


*mixed design ANOVA: 2 devices (PC vs VR; within-subjects) x 2 percceptual systems in VR (visual vs. auditory; between-subjects) x 2 device orders (PC-first vs. VR-first; between-subjects).
GLM PCLesson VRLesson BY DeviceOrderC SystemDeviceC
  /WSFACTOR=Device 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE ETASQ OPOWER PARAMATER
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Device
  /DESIGN=DeviceOrderC SystemDeviceC DeviceOrderC*SystemDeviceC.


*Exp1b only: *paired samples t-test comparing visual and auditory lessons.
T-TEST PAIRS=VisualLesson WITH AuditoryLesson (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.


*STEM-All.csv only: mixed design ANOVA comparing across Exp 1. and Exp 2: 2 lesson devices (PC vs. VR; within subjects) x 2 testing devices (Paper vs. Looking Glass; between subjects). 

GLM PCLesson VRLesson BY TestingMethod
  /WSFACTOR=LessonDevice 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=LessonDevice
  /DESIGN=TestingMethod.



*------------------------------------------------------------
*Experience-based learning outcomes
*FILES: 
*    Experience-Exp1a.csv
*    Experience-Exp1b.csv
*    Experience-Exp2.csv
*------------------------------------------------------------

*paired samples t-tests comparing VR and PC on AverageEnjoyment and ease of use.
T-TEST PAIRS=AveEnjoy.VR EaseControl.VR WITH AveEnjoy.PC EaseControl.PC (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.


*------------------------------------------------------------
*Classroom implementation reports (Exp 3)
*FILES: 
*    ClassroomReports-Exp3.csv
*------------------------------------------------------------

* repeated measures ANOVA: 3 learning outcomes (sensory input, system pathways, system purpose) x 2 perceptual systems (visual vs. auditory).
GLM Vinput Ainput Vpathways Apathways Vpurpose Apurpose
  /WSFACTOR=LearningOutcome 3 Polynomial PercpeptualSystem 2 Polynomial
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=LearningOutcome PercpeptualSystem LearningOutcome*PercpeptualSystem.



