/*
Creating a database & table that matches the csv columns and locally importing the NYPD Arrest data
https://data.cityofnewyork.us/Public-Safety/NYPD-Arrests-Data-Historic-/8h9b-rp9u/about_data
*/

USE nypd;
CREATE TABLE nypd_arrests
(
	ARREST_KEY int,
    ARREST_DATE text,
    PD_CD int,
    PD_DESC text,
    KY_CD int,
    OFNS_DESC text,
    LAW_CODE text,
    LAW_CAT_CD text,
    ARREST_BORO text,
    ARREST_PRECINCT int,
    JURISDICTION_CODE int,
    AGE_GROUP text,
    PERP_SEX text,
    PERP_RACE text,
    X_COORD_CD int,
    Y_COORD_CD int,
    Latitude double,
    Longitude double,
    Lon_Lat text
);

LOAD DATA LOCAL INFILE 'C:/Users/Kenny/Desktop/DATA_PORTFOLIO_PROJECTS/NYPD_ARRESTS_HISTORIC/NYPD_Arrests_Data_Historic_2024.csv'
INTO TABLE nypd_arrests
CHARACTER SET utf8
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 LINES
SET ARREST_DATE = str_to_date(ARREST_DATE, '%m/%d/%Y');


SELECT * FROM nypd_arrests LIMIT 50;

SELECT COUNT(*) FROM nypd_arrests;

/*
Referring to the Data Dictionary from NYCOpenData to decide if there are any columns that can be dropped:
PD_CD, PD_DESC, KY_CD, LAW_CODE, JURISDICTION_CODE, X_COORD_CD, Y_COORD_CD, Lon_Lat
*/
ALTER TABLE nypd_arrests
DROP COLUMN PD_CD,
DROP COLUMN PD_DESC,
DROP COLUMN KY_CD,
DROP COLUMN LAW_CODE,
DROP COLUMN JURISDICTION_CODE,
DROP COLUMN X_COORD_CD,
DROP COLUMN Y_COORD_CD,
DROP COLUMN Lon_Lat;

-- checking for duplicate arrest keys:
SELECT ARREST_KEY, COUNT(*) FROM nypd_arrests
GROUP BY ARREST_KEY
HAVING COUNT(*) > 1;
-- no duplicates returned

-- counting nulls in each column as well as total
SELECT
SUM(CASE WHEN ARREST_KEY is null THEN 1 ELSE 0 END) AS nullkey,
SUM(CASE WHEN ARREST_DATE is null THEN 1 ELSE 0 END) AS nulldate,
SUM(CASE WHEN OFNS_DESC is null THEN 1 ELSE 0 END) AS nullofns,
SUM(CASE WHEN LAW_CAT_CD is null THEN 1 ELSE 0 END) AS nullcat,
SUM(CASE WHEN ARREST_BORO is null THEN 1 ELSE 0 END) AS nullboro,
SUM(CASE WHEN ARREST_PRECINCT is null THEN 1 ELSE 0 END) AS nullprecinct,
SUM(CASE WHEN AGE_GROUP is null THEN 1 ELSE 0 END) AS nullage,
SUM(CASE WHEN PERP_SEX is null THEN 1 ELSE 0 END) AS nullsex,
SUM(CASE WHEN PERP_RACE is null THEN 1 ELSE 0 END) AS nullrace,
SUM(CASE WHEN Latitude is null THEN 1 ELSE 0 END) AS nulllat,
SUM(CASE WHEN Longitude is null THEN 1 ELSE 0 END) AS nulllong, 
	( SELECT COUNT(*) from nypd_arrests
    WHERE ARREST_KEY IS NULL OR
	ARREST_DATE IS NULL OR
	OFNS_DESC IS NULL OR
	LAW_CAT_CD IS NULL OR
	ARREST_BORO IS NULL OR
	ARREST_PRECINCT IS NULL OR
	AGE_GROUP IS NULL OR
	PERP_SEX IS NULL OR
	PERP_RACE IS NULL OR
	Latitude IS NULL OR
	Longitude IS NULL
    ) AS nulltotal
FROM nypd_arrests;
-- it says there are 0 nulls in any column, which I know is incorrect 
-- # of nulls: OFNS_DESC - 9169, LAW_CAT_CODE - 23600, Boro - 8, Age - 17, latitude - 2, longitude - 2, total - 32596

-- There are empty fields, setting all empty fields to null, then checking above again
UPDATE nypd_arrests SET ARREST_KEY = null WHERE ARREST_KEY = '';
UPDATE nypd_arrests SET ARREST_DATE = null WHERE ARREST_DATE = '';
UPDATE nypd_arrests SET OFNS_DESC = null WHERE OFNS_DESC = '';
UPDATE nypd_arrests SET LAW_CAT_CD = null WHERE LAW_CAT_CD = '';
UPDATE nypd_arrests SET ARREST_BORO = null WHERE ARREST_BORO = '';
UPDATE nypd_arrests SET ARREST_PRECINCT = null WHERE ARREST_PRECINCT = '';
UPDATE nypd_arrests SET AGE_GROUP = null WHERE AGE_GROUP = '';
UPDATE nypd_arrests SET PERP_SEX = null WHERE PERP_SEX = '';
UPDATE nypd_arrests SET PERP_RACE = null WHERE PERP_RACE = '';
UPDATE nypd_arrests SET Latitude = null WHERE Latitude = '';
UPDATE nypd_arrests SET Longitude = null WHERE Longitude = '';

-- inspecting rows with null data
SELECT * FROM nypd_arrests
WHERE ARREST_KEY IS NULL OR
ARREST_DATE IS NULL OR
OFNS_DESC IS NULL OR
LAW_CAT_CD IS NULL OR
ARREST_BORO IS NULL OR
ARREST_PRECINCT IS NULL OR
AGE_GROUP IS NULL OR
PERP_SEX IS NULL OR
PERP_RACE IS NULL OR
Latitude IS NULL OR
Longitude IS NULL;

/* 
Rather than just deleting rows with any nulls outright..............
*/

SELECT ARREST_DATE from nypd_arrests ORDER BY ARREST_DATE LIMIT 100;
SELECT ARREST_DATE from nypd_arrests ORDER BY ARREST_DATE DESC LIMIT 100;
-- data is from 2006 to 2023

-- viewing all unique values in ofns_desc
SELECT DISTINCT OFNS_DESC from nypd_arrests ORDER BY OFNS_DESC; 
-- there are many fields that can be combined, typos, as well as a (nulls) value
UPDATE nypd_arrests SET OFNS_DESC = 'Unknown' WHERE OFNS_DESC = '(null)' OR OFNS_DESC IS NULL;
UPDATE nypd_arrests SET OFNS_DESC = 'ADMINISTRATIVE CODES' WHERE OFNS_DESC = 'ADMINISTRATIVE CODE';
UPDATE nypd_arrests SET OFNS_DESC = 'CHILD ABANDONMENT/NON SUPPORT' WHERE OFNS_DESC = 'CHILD ABANDONMENT/NON SUPPORT 1';
UPDATE nypd_arrests SET OFNS_DESC = 'CRIMINAL MISCHIEF & RELATED OFFENSES' WHERE OFNS_DESC = 'CRIMINAL MISCHIEF & RELATED OF';
UPDATE nypd_arrests SET OFNS_DESC = 'DISRUPTION OF A RELIGIOUS SERVICE' WHERE OFNS_DESC = 'DISRUPTION OF A RELIGIOUS SERV';
UPDATE nypd_arrests SET OFNS_DESC = 'HARASSMENT' WHERE OFNS_DESC = 'HARRASSMENT 2';
UPDATE nypd_arrests SET OFNS_DESC = 'DISRUPTION OF A RELIGIOUS SERVICE' WHERE OFNS_DESC = 'DISRUPTION OF A RELIGIOUS SERV';
UPDATE nypd_arrests SET OFNS_DESC = 'HOMICIDE-NEGLIGENT,UNCLASSIFIED' WHERE OFNS_DESC = 'HOMICIDE-NEGLIGENT,UNCLASSIFIE';
UPDATE nypd_arrests SET OFNS_DESC = 'INTOXICATED/IMPAIRED DRIVING' WHERE OFNS_DESC = 'INTOXICATED & IMPAIRED DRIVING';
UPDATE nypd_arrests SET OFNS_DESC = 'KIDNAPPING & RELATED OFFENSES' WHERE OFNS_DESC = 'KIDNAPPING' OR OFNS_DESC = 'KIDNAPPING AND RELATED OFFENSES';
UPDATE nypd_arrests SET OFNS_DESC = 'LOITERING/GAMBLING (CARDS, DICE, ETC)' WHERE OFNS_DESC = 'LOITERING/GAMBLING (CARDS, DIC';
UPDATE nypd_arrests SET OFNS_DESC = 'MURDER & NON-NEGL. MANSLAUGHTER' WHERE OFNS_DESC = 'MURDER & NON-NEGL. MANSLAUGHTE';
UPDATE nypd_arrests SET OFNS_DESC = 'NYS LAWS-UNCLASSIFIED' WHERE OFNS_DESC = 'NYS LAWS-UNCLASSIFIED FELONY' OR OFNS_DESC = 'NYS LAWS-UNCLASSIFIED VIOLATION';
UPDATE nypd_arrests SET OFNS_DESC = 'OFF. AGNST PUB ORD SENSBLTY & RGHTS TO PRIV' WHERE OFNS_DESC = 'OFF. AGNST PUB ORD SENSBLTY &';
UPDATE nypd_arrests SET OFNS_DESC = 'OFFENSES AGAINST PUBLIC ADMINISTRATION' WHERE OFNS_DESC = 'OFFENSES AGAINST PUBLIC ADMINI';
UPDATE nypd_arrests SET OFNS_DESC = 'OTHER OFFENSES RELATED TO THEFT' WHERE OFNS_DESC = 'OTHER OFFENSES RELATED TO THEF';
UPDATE nypd_arrests SET OFNS_DESC = 'OTHER STATE LAWS (NON PENAL LAW)' WHERE OFNS_DESC = 'OTHER STATE LAWS (NON PENAL LA';
UPDATE nypd_arrests SET OFNS_DESC = 'POSSESSION OF STOLEN PROPERTY' WHERE OFNS_DESC = 'POSSESSION OF STOLEN PROPERTY 5';
UPDATE nypd_arrests SET OFNS_DESC = 'UNAUTHORIZED USE OF A VEHICLE' WHERE OFNS_DESC = 'UNAUTHORIZED USE OF A VEHICLE 3 (UUV)';
UPDATE nypd_arrests SET OFNS_DESC = 'UNLAWFUL POSS. WEAP. ON SCHOOL GROUNDS' WHERE OFNS_DESC = 'UNLAWFUL POSS. WEAP. ON SCHOOL';

/*
Checking values in LAW_CAT_CD
*/
SELECT DISTINCT LAW_CAT_CD FROM nypd_arrests;
-- LAW_CAT_CD normally has F, M, V, I, but also contains nulls, (null), and 9
SELECT * FROM nypd_arrests WHERE LAW_CAT_CD = '9' OR LAW_CAT_CD = '(null)' OR LAW_CAT_CD is null;
-- 24669 rows but they all still contain location and demographic info
UPDATE nypd_arrests SET LAW_CAT_CD = 'Unknown' WHERE LAW_CAT_CD = '9' OR LAW_CAT_CD = '(null)' OR LAW_CAT_CD IS NULL;
-- replacing the LAW_CAT_CD codes (F, M, V, I) with FELONY, MISDEMEANOR, VIOLATION, INFRACTION
UPDATE nypd_arrests
SET LAW_CAT_CD = REPLACE(REPLACE(REPLACE(REPLACE(LAW_CAT_CD, 'F', 'Felony'), 'M', 'Misdemeanor'), 'V', 'Violation'), 'I', 'Infraction');


/*
LOCATION DATA
*/
-- checking precinct values
SELECT ARREST_PRECINCT, COUNT(*) FROM nypd_arrests
GROUP BY ARREST_PRECINCT ORDER BY ARREST_PRECINCT DESC;
-- there is only one row for precinct 27, which doesn't exist, just going to delete this
DELETE FROM nypd_arrests WHERE ARREST_PRECINCT = 27;

-- checking boro values
SELECT DISTINCT ARREST_BORO FROM nypd_arrests;
-- there are null boro values, but these can be set based on the precinct value
-- match the precincts with the correct boroughs in the dataset according to https://www.nyc.gov/site/nypd/bureaus/patrol/precincts-landing.page
-- when making the tableau heatmap, noticed errors where certain precincts didn't match with the correct boro, so this needed to be done regardless of nulls
UPDATE nypd_arrests
SET ARREST_BORO = 'Manhattan'
WHERE ARREST_PRECINCT BETWEEN 1 AND 34;
UPDATE nypd_arrests
SET ARREST_BORO = 'Bronx'
WHERE ARREST_PRECINCT BETWEEN 40 AND 52;
UPDATE nypd_arrests
SET ARREST_BORO = 'Brooklyn'
WHERE ARREST_PRECINCT BETWEEN 60 AND 94;
UPDATE nypd_arrests
SET ARREST_BORO = 'Queens'
WHERE ARREST_PRECINCT BETWEEN 100 AND 115;
UPDATE nypd_arrests
SET ARREST_BORO = 'Staten Island'
WHERE ARREST_PRECINCT BETWEEN 120 AND 123;

-- When creating the Tableau heatmap with Latitude & Longitude, I found that there are many Latitude values that are not possible in New York City
SELECT Latitude FROM nypd_arrests ORDER BY Latitude DESC LIMIT 1000;
-- latitude values upwards of 62 don't make sense, maybe I am misunderstanding something but this coordinate would be far above new york
-- I've decided to delete lat and long and just use precinct/boro geography data for the heatmap
ALTER TABLE nypd_arrests
DROP COLUMN Latitude,
DROP COLUMN Longitude;

/*
Demographics Data
*/

-- AGE DATA
SELECT DISTINCT AGE_GROUP FROM nypd_arrests;
SELECT AGE_GROUP, COUNT(*) FROM nypd_arrests GROUP BY AGE_GROUP;
-- there are some weird values in the age groups
SELECT * FROM nypd_arrests WHERE AGE_GROUP NOT IN ('<18', '18-24', '25-44', '45-64', '65+') OR AGE_GROUP IS NULL;
-- going to set all the weird/null values to unknown
UPDATE nypd_arrests SET AGE_GROUP = 'Unknown' WHERE AGE_GROUP NOT IN ('<18', '18-24', '25-44', '45-64', '65+') OR AGE_GROUP IS NULL;

-- SEX DATA
SELECT DISTINCT PERP_SEX FROM nypd_arrests;
SELECT PERP_SEX, COUNT(*) FROM nypd_arrests GROUP BY PERP_SEX;
-- Going to replace M, F, U, with Male, Female, and Unknown
UPDATE nypd_arrests SET PERP_SEX = REPLACE(REPLACE(REPLACE(PERP_SEX, 'M', 'Male'), 'F', 'Female'),'U', 'Unknown');

-- RACE DATA
SELECT PERP_RACE, COUNT(*) FROM nypd_arrests GROUP BY PERP_RACE;

/*
Once data cleaning is complete, this database is going to connect to Tableau for visualizations
*/




