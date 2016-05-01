Can entropy-based image alignment metrics offer image aggregation of tissue density for mammographic risk assessment?
----

## Introduction

This is the README file for the above project, also refered to as 'Enantiomorph' for short.

This project aims to utilise 2 different fuzzy entropy metrics, and standard shannon entropy, for aligning mammographic images. Whilst this project focuses on mammograms, in theory this technique can be applied to any greyscale dataset.

---

## Directory Structure
In-depth information on the functions and scripts within this project can be found in the Final Report in Appendix C.

    project:
    - /binaryCongeal.m
    - /CONGEAL_SUPPORT/
        - computeXfrmImg.m
        - computeXfrmImgs.m
        - fastEntLookup.m
        - getXfrm.m
        - getXfrms.m
    - /Enantiomorph.mlappinstall
    - /GUI/
        - Enantiomorph.fig
        - Enantiomorph.m
        - Enantiomorph.prj
        - removeMarker.fig
        - removeMarker.m
    - /HYBRID_ENTROPY/
        - hybrid.m
        - TESThybrid.m
        - mdb136.pgm
    - /incrTrans.m
    - /IO/
        - loadSeries.m
        - pgm2bigPgm.m
        - README
        - readpgm.m
        - saveSeries.m
        - /scans/
            - sample .pgm files
        - ser2Im.m
        - TESTpgmCreation.m
    - /MEMBERSHIP/
        - Copy_of_hybridMembership.m
        - Copy_of_membership.m
        - hybridMembership.m
        - mdb136.pgm
        - membership.m
        - TESTmembership.m
    - /NON_PROB_ENTROPY/
        - nonProbabilistic.m
        - TESTnonProb.m
    - README.md
    - /sample-data/
        - /sample/
            - .pgm files
        - /sample_2/
            - .pgm files
        - /sample_3/
            - .pgm files
        - /sample_4/
            - .pgm files
        - /all-mias/
            - Mini-MIAS dataset
    - /testCongeal.m
    - /UTILITY/
        - showSer.m

---

## Installation

### MATLAB users

Users who have MATLAB installed on their PC can use the file ```Enantiomorph.mlappinstall``` found in the main directory to install the application directly into their workspace. This will automatically open the main GUI - ```Enantiomorph.fig```, as found in the source code.

Another way in which MATLAB users can open the project would be to import the entire project into MATLAB, navigate to the ```GUI``` directory, and run ```Enantiomorph.fig``` from there.

#### MATLAB Packages required

The following MATLAB Toolboxes are required to run this project. They can either be purchased, or are available on a 1 month trial basis:

* Fuzzy Logic Toolbox
* Image Processing Toolbox

### Non-MATLAB users

Non-MATLAB users can access the source code from any standard text-editor, OS X users can also utilise Xcode. However they will be unable to run the code from here. An executable is available under the name *hopefully something here.exe* for opening the project at the main GUI.

---

## Sample data

The Mini-MIAS dataset <http://peipa.essex.ac.uk/info/mias.html> has been leveraged in this project.

All image datasets can found in ```/sample-data/```.

All the files can be found in ```/sample-data/all-mias/ ``` in directories corresponding to their BI-RADS classification or if they contain masses.

Directories which specifically set-up for this project include:
* ```sample``` - contains 4 BI-RADS I scans + pre-compiled large .pgm file
* ```sample_2``` - contains 6 BI-RADS II scans
* ```sample_3``` - contains 8 BI-RADS III scans
* ```sample_4``` - contains 5 BI-RADS IV scans + pre-compiled large .pgm file

The user can either choose to leverage the pre-compiled .pgm files in ```sample``` or ```sample_4```,

**OR**

 generate the large .pgm in ```sample_2``` or ```sample_3``` when testing the application.

---

## How to run the unit tests

MATLAB users can run MATLAB tests by navigating to the project directory and issuing the command below:

``` results = runtests(pwd, 'IncludeSubfolders', true); ```

Followed by:

```rt = table(results)```

to view the results in a table.
