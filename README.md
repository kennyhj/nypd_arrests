# NYPD Arrests (2006-2023)
![alt text](link_to_image)

This project performs exploratory data analysis on the historic arrest dataset from the NYPD, publicly avaiable on [NYC Open Data.](https://data.cityofnewyork.us/Public-Safety/NYPD-Arrests-Data-Historic-/8h9b-rp9u/about_data)
nycopendata image
- Tools used: MySQL, Tableau

## 1. Examining the data structure in Excel
- Observed the column headers as well as their types for this dataset of over 5 million rows
- Found that the data includes info on types of crime, perp demographics, as well as lat/long location

![alt text](link_to_image)

## 2. Importing and cleaning the data in MySQL
- Created a table with specifications based on what I observed in the csv file
- Dropped unneeded columns
- Cleaned null values (opted to not drop those rows outright)
- Observed values in each column to clean/group values (e.g. crime types often had typos, as well as having values that overlapped with each other)
```SQL
UPDATE nypd_arrests SET OFNS_DESC = 'KIDNAPPING & RELATED OFFENSES' WHERE OFNS_DESC = 'KIDNAPPING' OR OFNS_DESC = 'KIDNAPPING AND RELATED OFFENSES';

UPDATE nypd_arrests SET OFNS_DESC = 'HOMICIDE-NEGLIGENT,UNCLASSIFIED' WHERE OFNS_DESC = 'HOMICIDE-NEGLIGENT,UNCLASSIFIE';
```


3. Cleaned dataset imported into Tableau for visualized insights ([Link To Public Tableau Dashboard](https://public.tableau.com/app/profile/kenny.jeong/viz/NYPDHistoricArrests/NYPDArrestDashboard))
- dashboard contains: nyc heatmap, demographics chart, yearly arrest rate line graph, crime type chart

![alt text](link_to_image)
- Top 3 types of crime (drugs, assault, and theft)
- in 2023, assault became the most common


![alt text](link_to_image)
- Created a heatmap representign the number of crimes organized by borough, as well as labels for crime rates in precincts
- (# of arrests ordered: Brooklyn, Manhattan, Bronx, Queens, Staten Island)

![alt text](link_to_image)
- For demographics data, I created a chart that includes Race, Gender, as well as age group
- Therefore was able to more accurately conclude that Black males aged 25-44 have the highest # of arrests, followed by White-Hispanic males aged 25-44
- (in this dataset, there is no sole Hispanic category, rather it is divided into White-Hispanic and Black Hispanic)
- image
- examined census data from 2020 of NYC categorized by borough
![alt text](link_to_image)
- arrests over the years 2006 - 2023
- generally trended downwards in the 2010s, however saw a significant rise starting in 2020
- despite this recent trend, it is still overall half as much as the peaks of this dataset, which occured around 2009-2010, which is coincidentally post-2008 financial crisis

4. Conclusions
- I would suggest further stuidy into the effects of the covid-19 on crime, as well as economic distressors in general
- further study intersecting racial demographics
