--Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA--
SELECT name 
FROM city 
WHERE countryCode = 'USA' AND Population > 120000;

--Query all columns (attributes) for every row in the CITY table.
SELECT *
FROM city;

--Query all columns for a city in CITY with the ID 1661.
SELECT *
FROM city
WHERE ID = "1661";

--Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT *
FROM city
WHERE countrycode = "JPN";

--Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT name
FROM city
WHERE countrycode = "JPN";

--Query a list of CITY and STATE from the STATION table.
SELECT city, state
FROM station;

--Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
SELECT DISTINCT city
FROM station
WHERE id % 2 = 0;

--Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT count(*) - count(distinct city) AS difference
FROM station;

--Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
WITH name_length AS (select city, length(city) len,
               max(length(city)) over() maxlen,
               min(length(city)) over() minlen
          FROM station)
SELECT min(city), len
 FROM (name_length)
 WHERE len in(minlen,maxlen)
 GROUP BY len;
 
 --Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
 SELECT DISTINCT city
FROM station
WHERE (city LIKE 'a%')
OR (city LIKE 'e%')
OR (city LIKE 'i%')
OR (city LIKE 'o%')
OR (city LIKE 'u%');

--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE (city LIKE '%a')
OR (city LIKE '%e')
OR (city LIKE '%i')
OR (city LIKE '%o')
OR (city LIKE '%u');

--Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT distinct CITY 
FROM STATION 
WHERE (CITY LIKE 'a%' 
    OR CITY LIKE 'e%' 
    OR CITY LIKE 'i%' 
    OR CITY LIKE 'o%'
    OR CITY LIKE 'u%') 
AND (CITY LIKE '%a' 
    OR CITY LIKE '%e'
    OR CITY LIKE '%i'
    OR CITY LIKE '%o'
    OR CITY LIKE '%u')
    
--Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE city NOT LIKE 'a%'
AND city NOT LIKE 'e%'
AND city NOT LIKE 'i%'
AND city NOT LIKE 'o%'
AND city NOT LIKE 'u%';

--Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE city NOT LIKE '%a'
AND city NOT LIKE '%e'
AND city NOT LIKE '%i'
AND city  NOT LIKE '%o'
AND city NOT LIKE '%u';

--Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
SELECT distinct CITY 
FROM STATION 
WHERE (CITY NOT LIKE 'a%' 
    AND CITY NOT LIKE 'e%' 
    AND CITY NOT LIKE 'i%' 
    AND CITY NOT LIKE 'o%'
    AND CITY NOT LIKE 'u%') 
OR (CITY NOT LIKE '%a' 
    AND CITY NOT LIKE '%e'
    AND CITY NOT LIKE '%i'
    AND CITY NOT LIKE '%o'
    AND CITY NOT LIKE '%u');
    
--Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY 
FROM STATION
WHERE CITY NOT LIKE 'a%' 
AND CITY NOT LIKE 'e%'
AND CITY NOT LIKE 'i%'
AND CITY NOT LIKE 'o%'
AND CITY NOT LIKE 'u%'
AND CITY NOT LIKE '%a' 
AND CITY NOT LIKE '%e'
AND CITY NOT LIKE '%i'
AND CITY NOT LIKE '%o'
AND CITY NOT LIKE '%u';

--Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT NAME 
FROM STUDENTS 
WHERE Marks > 75 
ORDER BY RIGHT(NAME, 3), ID ASC;

--Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
SELECT NAME
FROM EMPLOYEE 
ORDER BY NAME ASC;

--Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month who have been employees for less than  months. Sort your result by ascending employee_id.
SELECT NAME
FROM EMPLOYEE
WHERE MONTHS < 10
AND SALARY > 2000
ORDER BY EMPLOYEE_ID ASC;

--A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
SELECT ROUND(lat_n,4)
FROM (
     SELECT lat_n,
     ROW_NUMBER() OVER(ORDER BY lat_n ) AS row_num
     FROM station
     )  AS new_table
WHERE row_num = (
                SELECT CEIL(AVG(row_num)) 
                FROM (
                      SELECT 
                      ROW_NUMBER() OVER(ORDER BY lat_n ) AS row_num
                      FROM station
                      )  AS new_table);