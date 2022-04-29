# CodeClan - PHS RShiny Dashboard Group Project
## April 2022

___

## Project Description Outline

### Group Members:

Colin Scotland, Mahri Stewart, Kahlen Cheung, Jerry Balloch


### Roles & responsibilities of each member

*Colin*
<br>
Colin worked on viewing the percentage of beds occupied by acute care patients
across the 14 Health Boards in Scotland both before and during COVID times.
Statistical analysis of this data was also calculated using independent
means tests with permutation to generate null distributions. He also drew up a
dashboard wireframe, worked on creating the dashboard itself, and regularly
updated Trello.
<br>

*Mahri*
<br>
Mahri worked on demographic data both before and during COVID times. Whilst
considering Scotland as a whole, the differences in total monthly/ quarterly
admissions/ stays for acute care patients was observed between:
* age groups
* sex (Male/Female)
* and SIMD quintlies (Scottish Index of Multiple Deprivation quintiles:
1(Most Deprived) - 5(Least Deprived)).
<br>
Statistical analysis of the three were also calculated for both pre-COVID and
during COVID times.
<br>
Creating and updating a Trello project board with to-do tasks and scheduled
meetings, and working on the presentation and README file.
<br>
     
*Kahlen*
<br>
Kahlen worked on A&E admissions both before and during COVID times across 
Scotland as a whole. She also considered the differences in waiting times (4 
hours, 8+ hours, and 12+ hours) in A&E across Scotland and the same time 
frame. Statistical analysis on the differences between the mean of total A&E 
admissions _before_ COVID, and the mean of total A&E admissions _after_ COVID of 
this data was also calculated.
<br>

*Jerry*
<br>
Jerry worked on the dashboard skeleton, appearance, and input of relevant data 
and widgets. Creating a colour palette from the PHS logo and Scotland as a whole, 
helped in keeping the overall aesthetics of individual visualisations uniform. 
Geographical information for total COVID cases was shown on maps created using 
the leaflet() function in RShiny. It involved merging shapefile data, containing 
the Polygon data of the different health board regions, with another data set 
containing COVID case counts across each region. The data was able to be joined 
using the health board reference id across both data sets.
<br>

*Everyone*
<br>
Everyone worked together with regards to coming up with a direction for this
project. Though we had our individual roles, we regularly presented what we had
each achieved and our next steps were decided upon in group discussions.
Combining the individual analyses into the dashboard so that it had a uniform
aesthetic and an outline for our presentation was also decided upon as a group.
Group meetings were attended by all and Trello was updated regularly with how
everyone was getting on/ our to do list.

___

### Brief description of dashboard topic

We were interested in considering whether there is a "Winter Crisis" as
portrayed by the media by comparing data from before the pandemic (2016-2019)
with the data for COVID times (2020 to 2021).

<br>

Our dashboard contains information on bed occupancy across Scottish Health
Boards, demographics (age, sex, and deprivation scores), and A&E admissions and
waiting times from Summer 2016 to Summer 2021. As a user, you are able to change
the dates (yearly quarters) so as to zoom in on a time period of your choice.
A map of Scotland's Health Boards is also available with a note of the total
COVID cases to date for each.
<br>

### Stages of the project

* Taking time to individually view available datasets and consider routes of
investigation
* Choosing datasets
* Planning & dashboard wireframe
* Cleaning and analysis of data with regards to our interests
* Statistical investigation
* Geographical inputs on map
* Git branching & version control
* Construction of dashboard skeleton
* Combining of individual work on dashboard
* Testing dashboard
* Presentation slides drawn up
* Assigning presentation topics

### Which tools were used in the project

* Zoom - initial and weekend stand-ups
* Trello - planning & task allocation
* Git/GitHub - collaboration & version control
* Rstudio - cleaning and analysis of data
* Excalidraw - creating and editing dashboard wirefame
* Slack for communication

### How did you gather and synthesise requirements for the project?

Investigation of open data provided by Public Health Scotland was undertaken by
each group member individually with the project questions in mind.
Group discussions were had with regards to which data sets could be condsidered
and after cleaning and analysis, the project was brought together with clean
data that provided a story to answer our question.
<br> 
We prioritised having a working process. Whilst data was being cleaned and
analysed, the dashboard skeleton was being created so that everything could be
brought together quickly and efficiently.


### Motivations for using the data you have chosen

We used the dataset on bed occupancy to answer the question of how genuine
the so-called "winter crisis" is and because it was a simple and clear metric
with which to compare the demand on hospital beds depending on time of year.
The bed occupancy was also given as a *percentage* of total available beds which
meant that it was already normalised and comparable between different health boards
regardless of their total overall bed count.

### Data quality and potential bias, including a brief summary of data cleaning and transformations

According to the About tab on the dataset page/dedicated page online, the data
hosted on the Scottish Health and Social Care Open Data platform follows the
open data standards set out by Public Health Scotland, ensuring consistency
across the platform.
<br> (https://www.opendata.nhs.scot/about)
<br>
All NHS Scotland organisations can use
this platform to publish and share their open datasets that meet the
requirements set out in the Scottish Government Open Data Strategy (2015).
<br>
Further, feedback is requested from users as to which data they wish to see in
the future and how their experiences of using the available data, and before
data is released on the open data platform it is first assessed for statistical
disclosure.

To clean the datasets we;

* Determined as a group what questions we wanted to answer
* Worked individually on separate datasets to remove unnecessary data and to 
transform the remaining data into relevant, usable objects that could provide an
insight into the questions we were asking.  Specifically;
  
  * Dates and timelines were adjusted between months/quarters/seasons as 
  appropriate to facilitate comparisons between different datasets.
  * Common variables were used to allow data to be joined (e.g. health board 
  codes, health board names, etc) to give a better overall idea of what was
  happening in the bigger picture.

Cleaning and transformation was all
done in RStudio, predominantly using the `tidyverse` and `janitor` packages.

### How is the data stored and structured

The data is in the form of cleaned .csv files saved into a `clean_data` folder
within the Github repository.  Each data set contains a time reference of some 
kind (month or quarter) or a reference to a health board.

This means that the data can be linked by month/quarter or by health board 
information to allow for further analysis and interpretation.

Benefits of storing the data like this are;

 * The data is already clean
 * Further analysis can be initiated simply by reading in the .csv
 * By maintaining date and location data the datasets can be added to in future
 to look for developing trends in different locations over longer periods.

### Ethical and legal considerations of the data

There are no ethical considerations, because the datasets are covered by the 
Open Government License (provided by Public Health Scotland), which means you are 
encouraged to use and adapt, combine, explore, distribute, and publish in your 
own project the information that is available under this licence freely and 
flexibly. Data is anonymised at Public Health Scotland before being made 
available as open source, there is no personal information or id documents included 
in the datasets. You must, however, acknowledge the source of the information in 
your product or application by including or linking to any attribution statement 
specified by the Information Provider(s) and, where possible, provide a link to 
this licence: 
https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/
