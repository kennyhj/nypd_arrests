# NYPD Historic Arrests Case Study
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/nypd%20logo.jpg" width="300">

This project performs exploratory data analysis on the arrest dataset from the NYPD from 2006 - 2023, publicly avaiable on [NYC Open Data.](https://data.cityofnewyork.us/Public-Safety/NYPD-Arrests-Data-Historic-/8h9b-rp9u/about_data)
nycopendata image
- Tools used: MySQL, Tableau
- [Link to a more detailed slideshow presentation of this case study](https://github.com/kennyhj/nypd_arrests/blob/main/NYPD%20Historic%20Arrests%20Case%20Study.pdf)

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
-- A couple of query examples cleaning the data
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

- Clustered stacked bar chart of demographics data: race, gender, and age group
- Black males age 25-44 have the highest arrest rates, followed by White-Hispanic males age 25-44
- (There is no sole Hispanic race value in this dataset, it is divided as White-Hispanic and Black-Hispanic) 
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/demographics.jpg" width="600">

- Stacked bar chart of the NYC 2020 Census displaying populations by race per borough
- The black population accounts for the 3rd highest population in NYC despite having the highest arrest rates
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/census_2020_nyc.jpg" width="600">

- Line graph of # of arrests per year (2006 - 2023)
- A downward trend in the 2010s, but then saw a significant rise starting in 2020
<img src="https://github.com/kennyhj/nypd_arrests/blob/main/images/yearly.jpg" width="550">

## 4. Conclusions
- Black men account for the highest number of arrests, despite being the 3rd highest population in NYC
  - This discrepancy highlights a possible racial bias in policing
  - I would also cross examine financial/housing data with racial demographics
- Arrest rates spiked in 2020 after about a decade of decline
  - I would suggest further stuidy into the effects of the covid-19 on crime
