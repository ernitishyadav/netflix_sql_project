CREATE DATABASE IF NOT Exists netflix;
USE netflix;

-- creating table

CREATE TABLE netflix_data(
show_id	varchar(10),
`type` varchar(30),
title varchar(300),
director varchar(208),	
cast varchar(1000),
country	varchar(150),
date_added varchar(50),	
release_year int,	
rating	varchar(10),
duration varchar(50),	
listed_in varchar(100),	
description varchar(250)
);
 
 
 select * from netflix_data;
LOAD DATA INFILE 'C:/netflix_titles.csv'
INTO TABLE netflix_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) as total_content FROM netflix_data;

select distinct type from netflix_data;


-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows

    SELECT `type`, COUNT(*) as total_content FROM netflix_data group by `type`;
    
-- 2. Find the most common rating for movies and TV shows
    
  select rating,`type` from
   ( 
		SELECT
             rating,`type`,
             COUNT(*) as rating_count,
             Rank() over(partition by `type` order by count(*) DESC) as Ranking
             FROM netflix_data group by 1,2) 
             
          as t1 
          where Ranking = 1;
             
    
-- 3. List all movies released in a specific year (e.g., 2020)
      
   
select `type`,release_year, count(`type`) from netflix_data group by 1,2  having release_year = 2020 AND `type` = "MOVIE";

select * from netflix_data where `type` = "Movie" And release_year = 2020;



-- 4. Find the top 5 countries with the most content on Netflix
select country, count(show_id) as counting from netflix_data group by 1 order by Counting desc limit 5;


select * from netflix_Data;

select unnest(String_to_Array(country,',')) as new_country from netflix_data;

-- 5. Identify the longest movie

select * from netflix_data
where `type` = "Movie" And duration = (select max(duration) from netflix_data);





-- 6. Find content added in the last 5 years


SELECT date_added 
FROM netflix_Data
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= date_sub(now(),interval 5 year);

select date_added from netflix_data where  date_sub(now(), interval 5 year);




-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

use netflix;
  select  
        `type`,
        director  
from netflix_data 
where  director like  '%Rajiv Chilaka%';



-- 8. List all TV shows with more than 5 seasons



 
 select * from netflix_Data where `type` Like "TV Show" And duration >5;


  


-- 9. Count the number of content items in each genre
select * from netflix_Data;
  select 
      unnest(String_to_Array(listed_in," ,")),
    count(show_id)
    from netflix_Data group by 1;
    
    
-- 10.Find each year and the average numbers of content release in India on netflix.
     
        SELECT 
    COUNT(*) AS count,
    YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) AS release_year
FROM netflix_Data
WHERE country = 'India'
 GROUP BY release_year;





-- 11. List all movies that are documentaries

select * from netflix_Data where listed_in like "%documentaries%";
-- 12. Find all content without a director

 select * from 
   netflix_data 
  where director is Null;
-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
 
 SELECT *
FROM netflix_Data
WHERE cast LIKE '%salman khan%' 
  AND YEAR(STR_TO_DATE(date_added, '%M %d, %Y')) > YEAR(DATE_SUB(NOW(), INTERVAL 1 YEAR));


