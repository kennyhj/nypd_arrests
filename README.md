rough draft outline: NYPD Arrests (2006 - 2023)

publicly available dataset from [NYC Open Data](https://data.cityofnewyork.us/Public-Safety/NYPD-Arrests-Data-Historic-/8h9b-rp9u/about_data)
nycopendata image
Tools used: Excel csv, Data dictionary provided by NYC Open Data, MySQL, Tableau

1. First did a quick examinination of the data structure in excel
- contains over 5 million rows of data, arrest_key primary key, with relevant data in perp demographics, location, as well as the type of crime
image

2. Used the header info to create a table in MYSQL and load the data
- dropped unneeded columns
- cleaned & grouped values and nulls
image

3. Cleaned dataset imported into Tableau for visualized insights ([Link To Public Tableau Dashboard](https://public.tableau.com/app/profile/kenny.jeong/viz/NYPDHistoricArrests/NYPDArrestDashboard))
- dashboard contains: nyc heatmap, demographics chart, yearly arrest rate line graph, crime type chart
  
- Top 3 types of crime (drugs, assault, and theft)
- in 2023, assault became the most common
image

- Created a heatmap representign the number of crimes organized by borough, as well as labels for crime rates in precincts
- (# of arrests ordered: Brooklyn, Manhattan, Bronx, Queens, Staten Island)
image

- For demographics data, I created a chart that includes Race, Gender, as well as age group
- Therefore was able to more accurately conclude that Black males aged 25-44 have the highest # of arrests, followed by White-Hispanic males aged 25-44
- (in this dataset, there is no sole Hispanic category, rather it is divided into White-Hispanic and Black Hispanic)
- image
- examined census data from 2020 of NYC categorized by borough

- arrests over the years 2006 - 2023
- generally trended downwards in the 2010s, however saw a significant rise starting in 2020
- despite this recent trend, it is still overall half as much as the peaks of this dataset, which occured around 2009-2010, which is coincidentally post-2008 financial crisis

4. Conclusions
- I would suggest further stuidy into the effects of the covid-19 on crime, as well as economic distressors in general
- further study intersecting racial demographics
