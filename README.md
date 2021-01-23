# UW-Virtual-Brain-Project

_Karen B. Schloss, Melissa A. Schoenlein, Ross Tredinnick, Simon Smith, Nathaniel Miler, Chris Racey, Christian Castro, Bas Rokers_

The UW Virtual Project aims to create interactive 3D narrated diagrams for lessons about the perceptual systems of the brain. In this project, we evaluated two lessons, the Virtual Visual System and Virtual Auditory System with two in-lab experiments and a classroom implementation. In the lab, we found that the lessons were effective for content-based learning outcomes when presented in VR or when presented on a computer monitor (PC). However, participants found the VR lessons easier to use and more enjoyable than the PC lessons. In the classroom, students reported that the VR lessons helped them make moderate to substantial progress on course learning outcomes. These results suggest that VR can be an effective educational tool in the classroom. 

---
## FOLDER: VB-DataFiles
### Data files 

STEM CONTENT: 

`STEM-Exp1A.csv`, `STEM-Exp1B.csv`, `STEM-Exp2.csv`: store the data from the Paper/Looking Glass drawing/labeling test for each of the in-lab experiments. Columns for all 3 include:
- `Subj`: participant number 
- `Condition`: order/pairing of VR/PC & visual/auditory test
      - 2DV3DA = Visual system on PC then auditory system in VR
      - 3DV2DA = Visual system in VR then auditory system on PC 
      - 2DA3DV = Auditory system on PC then visual system in VR
      - 3DA2DV = Auditory system in VR then visual system on PC
- `Lesson1.Pre`: Score on lesson 1 pre-test (range: 0-18)
- `Lesson1.Post`: Score on lesson 1 post-test (range: 0-18)
- `Lesson2.Pre`: Score on lesson 2 pre-test (range: 0-18)
- `Lesson2.Post`: Score on lesson 2 post-test (range: 0-18)
- `DeviceOrderC`:  0 = PC then VR, 1 = VR then PC
- `SystemOrderC`: 0 = Visual then Auditory, 1 = Auditory then Visual
- `SystemDeviceC`: 0 = Visual in VR, 1 = Auditory in VR
- `Lesson1`: Change in performance score for lesson 1 (Post-Pre) (range: -18 to 18)
- `Lesson2`: Change in performance score for lesson 2 (Post-Pre) (range: -18 to 18)
- `PCLesson`: Change in performance score for lesson completed on PC (Post-Pre) (range: -18 to 18)
- `VRLesson`: Change in performance score for lesson completed in VR(Post-Pre) (range: -18 to 18)
- `VisualLesson`: Change in performance score for lesson on Visual System(Post-Pre) (range: -18 to 18)
- `AuditoryLesson`: Change in performance score for lesson on Auditory System (Post-Pre) (range: -18 to 18)
- `Visual.Pre`: Pre-test score for lesson on Visual System (range: 0 to 18)
- `Auditory.Pre`: Pre-test score for lesson on Auditory System (range: 0 to 18)

`STEM-All.csv`: stores the combined data for the 3 experiments above. In addition to the columns above, there are two additional columns: 
- `Experiment`:  1a, 1b, or 2 corresponding to which experiment
- `TestingDevice`: 0 = Paper testing (Exp1A & 1B), 1 = Looking Glass testing (Exp2)



EXPERIENCE QUESTIONNAIRE

`Experience-Exp1A.csv`, `Experience-Exp1B.csv`, `Experience-Exp2.csv`: store the data from the experience questionnaire. Each participant rated the 7 items using a Likert scale from 1 (“Not at all”) to 7 (“Very much”).  Each item has a column for ratings made on the VR experience (item.VR) and one column for the PC experience (item.PC) (12 columns total).  Additional columns include
- `Subj`: participant number
- `AveEnjoy` = average of 6 items excluding EaseControl(column for each device)



SIMULATOR SICKNESS QUESTIONNAIRE

`SSQ-Exp1A.csv`, `SSQ-Exp1B.csv`, `SSQ-Exp2.csv`: store the data from the simulator sickness questionanires. Each participant rated the 4 items (headache repeated in Exp1A and Exp1B and is marked as timepoint.Headache1 & timepoint.Headache2) by circling "None", "Slight", "Moderate", "Severe", coded as 1-4. The columns include one column for each of the 4 items at each timepoint (timepoints marked as Q1, Q2, Q3). Additional columns include:
- `Subj`: participant number
- `AveHeadache` = average of two headache ratings for each timepoint. Note Exp2 only had headache presented once, but we include this column for consistency across experiments when performing the analyses. 



CLASSROOM REPORTS

`ClassroomReports.csv`: stores the data from the classroom implementation. Students rated each learning outcome (sensory input, system pathways, system purpose) for both the Visual and auditory system (V, A). Columns include ratings for each outcome for each system, labeled as system.outcome (i.e., V.input), and whether they participated in the given lesson. Additional columns include: 
-`Subj` = participant number

`ClassFreeResponse1-WhatContributed` and `ClassFreeResponse2-WhatWouldMakeMoreUseful`: contain the transcribed free response answers from the student evaluation 

`ClassFreeResponseThemes.csv`: stores the free response data sorted into themes for both two free-response questions (Tab 1: whatContributed & Tab 2: moreUseful). Columns indicate the theme. Each row represents one student's response. For each response, if it "fit" a given theme (according to at least 2 of the coders), a "1" was placed in the cell. 


### R scripts

`PlottingFigures.R`: R script for plotting data from all 3 experiments. Takes files above as inputs.

### SPSS Scripts

`VB-Analyses.sps`: Contains script for running the analyses for all 3 experiments (ANOVAs, t-tests). Takes files above as inputs. 


## FOLDER: VB-TestingMaterials

`PaperTests.pdf` provide the visual and auditory paper drawing/labeling tests used in Experiment 1. These paper tests were adapted to be used on the Looking Glass for Experiment 2.

`PaperTestInstructions.pdf`provides the full instructions given to participants to complete the paper drawing/labeling tests for Experiment 1. These instructions were also used with slight adaptations to fit the tasks for Experiment 2. 

`PaperTestGradingDetails.pdf` and `LookingGlassTestGradingDetails.pdf` provide the full rubrics used by the coders to grade the paper drawing/labeling and Looking Glass drawing/labeling tests, respectively. 







