/*
Average age, weight, and height for each sport
*/
SELECT sport AS "Sport", ROUND(AVG(age),1) AS "Average Age", ROUND(AVG(weight),1) AS "Average Weight", ROUND(AVG(height),1) AS "Average Height" 
FROM athlete
GROUP BY sport;

/*
Top 10 Athletes with the most medals
*/
SELECT athlete.name AS "Name", country.region AS "Country",
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
GROUP BY athlete.name, country.region
ORDER BY "Total Medals" DESC
LIMIT 10;

/*
Medals won by age group
*/
SELECT (CASE WHEN age < 18 THEN 'Under 18'
	WHEN age BETWEEN 18 AND 22 THEN '18 - 22'
	WHEN age BETWEEN 23 AND 27 THEN '23 - 27'
	WHEN age BETWEEN 28 AND 32 THEN '28 - 32'
	WHEN age BETWEEN 33 AND 37 THEN '33 - 37'
	WHEN age >= 38 THEN '38+'
	END) AS "Age Group",
COUNT(CASE WHEN medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN medal = 'Gold' OR medal = 'Silver' OR medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
WHERE age IS NOT NULL
GROUP BY "Age Group"
ORDER BY "Age Group" ASC;

/*
Top 10 Countries with the most medals
*/
SELECT country.region AS "Country",
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
GROUP BY country.region
ORDER BY "Total Medals" DESC
LIMIT 10;

/*
Top 10 years with the most medals won by a single country
*/
SELECT country.region AS "Country", athlete.year AS "Year",
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
GROUP BY country.region, athlete."year"
ORDER BY "Total Medals" DESC
LIMIT 10;

/*
USA total medals won each competition year
*/
SELECT country.region AS "Country", athlete.year AS "Year",
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
WHERE country.noc = 'USA'
GROUP BY country.region, athlete."year"
ORDER BY athlete.year;

/*
USA years with most medals won
*/
SELECT athlete.year AS "Year", 
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
WHERE country.noc = 'USA'
GROUP BY athlete.year
ORDER BY "Total Medals" DESC
LIMIT 10;

/*
USA events with most medals won
*/
SELECT athlete.event AS "Event", 
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
WHERE country.noc = 'USA'
GROUP BY athlete.event
ORDER BY "Total Medals" DESC
LIMIT 10;

/*
Total medals from each country during each competition year 
*/
SELECT athlete.year AS "Year", country.region AS "Country",
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
GROUP BY athlete.year, country.region
ORDER BY athlete.year ASC, "Total Medals" DESC;

/*
Country with the most medals in each olympic year
*/
WITH country_medals AS
(SELECT athlete.year AS "Year", country.region AS "Country",
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
GROUP BY athlete.year, country.region
ORDER BY athlete.year ASC, "Total Medals" DESC)
SELECT "Year", "Country", "Total Medals"
FROM country_medals
WHERE ("Year", "Total Medals") IN (SELECT "Year", MAX("Total Medals") FROM country_medals GROUP BY "Year");

/*
Athlete medals won during each competition year 
*/
SELECT athlete.year AS "Year", athlete.name AS "Name", country.region AS "Country",
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
GROUP BY athlete.year, athlete.name, country.region
ORDER BY athlete.year ASC, "Total Medals" DESC;

/*
Athlete with the most medals in each olympic year
*/
WITH athlete_medals AS (
SELECT athlete.year AS "Year", athlete.name AS "Name", country.region AS "Country",
COUNT(CASE WHEN athlete.medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN athlete.medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN athlete.medal = 'Gold' OR athlete.medal = 'Silver' OR athlete.medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
JOIN country ON country.noc = athlete.noc
GROUP BY athlete.year, athlete.name, country.region
ORDER BY athlete.year ASC, "Total Medals" DESC)
SELECT "Year", "Name", "Total Medals"
FROM athlete_medals
WHERE ("Year", "Total Medals") IN (SELECT "Year", MAX("Total Medals") FROM athlete_medals GROUP BY "Year");

/*
Athlete table with medal counts
*/
SELECT name, sex, age, height, weight, team, noc, games, year, season, city, sport, event, medal,
COUNT(CASE WHEN medal = 'Gold' THEN 1 ELSE null END) AS "Gold",
COUNT(CASE WHEN medal = 'Silver' THEN 1 ELSE null END) AS "Silver",
COUNT(CASE WHEN medal = 'Bronze' THEN 1 ELSE null END) AS "Bronze",
COUNT(CASE WHEN medal = 'Gold' OR medal = 'Silver' OR medal = 'Bronze' THEN 1 ELSE null END) AS "Total Medals"
FROM athlete
GROUP BY name, sex, age, height, weight, team, noc, games, year, season, city, sport, event, medal
ORDER BY year ASC;
