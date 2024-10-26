# NYPD Historic Arrests Case Study
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/nypd%20logo.jpg" width="300">

This project performs exploratory data analysis on the arrest dataset from the NYPD from 2006 - 2023, publicly avaiable on [NYC Open Data.](https://data.cityofnewyork.us/Public-Safety/NYPD-Arrests-Data-Historic-/8h9b-rp9u/about_data)
nycopendata image
- Tools used: MySQL, Tableau

## 1. Examining the data structure in Excel
- Observed the column headers as well as their types for this dataset of over 5 million rows
- Found that the data includes info on types of crime, perp demographics, as well as lat/long location

<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/excel_data.jpg" width="750">

## 2. Importing and cleaning the data in MySQL
- Created a table with specifications based on what I observed in the csv file
- Dropped unneeded columns
- Cleaned null values (opted to not drop those rows outright)
- Observed values in each column to clean/group values (e.g. crime types often had typos, as well as having values that overlapped with each other)
```SQL
UPDATE nypd_arrests SET OFNS_DESC = 'KIDNAPPING & RELATED OFFENSES' WHERE OFNS_DESC = 'KIDNAPPING' OR OFNS_DESC = 'KIDNAPPING AND RELATED OFFENSES';

UPDATE nypd_arrests SET OFNS_DESC = 'HOMICIDE-NEGLIGENT,UNCLASSIFIED' WHERE OFNS_DESC = 'HOMICIDE-NEGLIGENT,UNCLASSIFIE';
```
[(Click here to view all of the SQL queries)](https://github.com/kennyhj/nypd_arrests/blob/main/nypd_arrests.sql)


## 3. Imported the cleaned dataset into Tableau for visualized insights ([Link To Dashboard](https://public.tableau.com/app/profile/kenny.jeong/viz/NYPDHistoricArrests/NYPDArrestDashboard)) 
(Dashboard can be filtered by year)

- Top 10 Types of Crime Bar Chart
- Drug offenses and assaults account for the most arrests
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/top_10_crimes.jpg" width="750">

- Heatmap of arrests per precinct/borough
- Boros ranked most to least arrests: Brooklyn, Manhattan, Bronx, Queens, Staten Island
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/heatmap.jpg" width="500">

- Stacked bar chart of demographics data: race, gender, and age group
- Black males age 25-44 have the highest arrest rates, followed by White-Hispanic males age 25-44
- (There is no sole Hispanic race value in this dataset, it is divided as White-Hispanic and Black-Hispanic) 
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/demographics.jpg" width="600">

- examined census data from 2020 of NYC categorized by borough

- Line graph of # of arrests per year (2006 - 2023)
- A downward trend in the 2010s, but then saw a significant rise starting in 2020
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/yearly.jpg" width="550">

4. Conclusions
- I would suggest further stuidy into the effects of the covid-19 on crime, as well as economic distressors in general
- further study intersecting racial demographics
