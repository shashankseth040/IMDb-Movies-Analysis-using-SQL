-- Anything in SQL begins with -- or come after -- will be treated as command and it will not execute, we can use this statements to explain our query 

-- On MySQL Screen we have Schemas Panel, SQL Query Editor, Result Grid and OutPut Panel 
-- Schema Panel = Shows all the Schemas or Database currently present and on expanding them it shown information about Tables, Views, Stored Procedures or Fuctions created in that database
-- On Query Editor we write our SQL query to execute and work with schemas
-- Result Grid shows the result of our query 
-- OutPut Panel shows if query was successful or not, if there is any error it will give error number with the response messgae like details of error 
-- and if executed it will show ahow many rows got pulled in querry and what was the response time of query 

-- To create database we will use command 
create database moviesdb; -- This will create the database 
create database if not exists moviesdb; -- This will first check if the database already exist, if yes it will give warning instead of error or else it will create the database for you 
-- 1007 Can't create database 'moviesdb'; database exists

-- To use the database we will use command
use moviesdb; -- It will allow you to use this database 

-- To see all the tables in the database we will use command 
show tables; -- It will allow you to see all the existing taables in database

-- To see the structure or schema of any table
desc actors;
desc movies;
desc movie_actor;

-- If you are in any other database let's say and you want to show some info in any other database then you have to explicitly mention the database name before table name database.table in this format 
select * from trendytech.students;
-- Here trendytech is one database and I need info from students table and currently I'm in moviesdb so if i'll not mention the database name it will throw error as
-- Table moviedb.students doesn't exist because it will try to pull this table fromc urrent working database
-- Or else you can manually select the database from right side schema panel, select the database you want to work upon right click on it and select Set as Default Schema 

-- Now let's see some data retrival query 
-- The search filters are case insensitive

select * from movies;  -- Full list of all the details of movies
select * from movies where industry = 'bollywood' ; -- All the details of Bollywood movies
select * from movies where industry = 'BolLWood' ; -- This will also work as search filter is case insensitive in SQL 
select title, industry, release_year from movies ; -- To pull only few coloumns 
select title, industry, release_year from movies where industry = 'Hollywood'; - -- To pull only few coloumns for Hollywood movies

-- To Get the count of all the movies 
select count(*) from movies; -- It will show total entries in movies 
select count(*) from movies where industry = 'Hollywood'; -- It will show total counts of hollywood movies in movies table 

-- LIKE operator for wildcard search
select * from movies where title like '%THOR%'; -- All the movies with title containing THOR anywhere in it 
select * from movies where title like '_____'; -- All the 5 letters movies 
select * from movies where title like '________'; -- All the 8 letters movies 
select * from movies where title like 'S_%'; -- All the movie starts with S
select * from movies where title like '%_enger_%'; -- All the movies contains engers anywhere in it 
select * from movies where title like '%_r'; -- All the movies end with R
select * from movies where title like '__or%'; -- All the movies whoes third and fourth character are or 
select * from movies where title like '%or%'; -- All the movies containing or anywhere
select * from movies where title like '%:%'; -- All the movies containing :

-- Now if I wanto search anymovies containing % sign it as name I have to use \ as escape charachter before %
select * from movies where title like '%\%%'; -- All the movies containing % in it as character in name
select * from movies where title like '___\%%'; -- All the movies containing % at 4 character in its name 

-- NOT LIKE operators 
select * from movies where title like '%THOR%'; -- It will show all the movies contains thor in it
select * from movies where title not like '%THOR%';  -- It will show all the movies that not contains thor in it 

-- Now lets say I want to get all the movie title whose studio info is not available 
select * from movies where studio = ""; --  Here I have not used is NULL becase this field is not null but empty which means here we have data as empty string
-- An empty string in SQL is set by ""


-- Exercise 1) Print all the Movie titles and release year for all the Marver Studios movies?
select title, release_year, studio from movies where studio like '%marvel%';

-- Exercise 2) Print all the Movie have Avengers in their name 
select * from movies where title like '%avengers%';

-- Exercise 3) Print the year when the movie 'The Godfather' was release 
select release_year from movies where title = 'The Godfather';

-- Exercise 4) Print all the distinct studio in Bollywood Industry 
select distinct studio from movies where industry = 'Bollywood';

-- Let's say I want to get all the movies name with IMDb rating greater then 9 
select * from movies;
select title, imdb_rating from movies where imdb_rating >= 9;
select title, imdb_rating from movies where imdb_rating <= 5;
select title, imdb_rating from movies where imdb_rating >=5 and imdb_rating <=8 order by imdb_rating desc;
select title, imdb_rating from movies where imdb_rating between 7 and 8 ;
select title, imdb_rating from movies where imdb_rating <= 5 or imdb_rating >=9 order by imdb_rating;
select title, imdb_rating, release_year from movies where release_year = 2019 or release_year = 2022;
select title, imdb_rating, release_year from movies where release_year in (2017,2018,2019,2020) order by release_year, imdb_rating desc;
select title, imdb_rating, release_year, studio from movies where studio in ('Marvel Studios', 'Zee Studios') order by release_year, imdb_rating desc;

-- retrive null and not null values 
select * from movies where imdb_rating is NULL;
select * from movies where imdb_rating is NOT NULL;

-- Retrive Top 5 highest movies 
select * from movies order by imdb_rating desc limit 5;

-- Lowest 5 movies
select * from movies order by imdb_rating asc limit 5;

-- Omit first 5 and give second top 5 movies 
select * from movies order by imdb_rating desc limit 5 offset 5;

-- Omit first 5 and give second top 2 movies 
select * from movies order by imdb_rating desc limit 5,2;

-- Exercise 5) Print all movies in the order of their release year (latest first)
select * from movies order by release_year desc;

-- Exercise 6) All movies released in the year 2022
select * from movies where release_year = 2022;

-- Exercise 7) Now all the movies released after 2020
select * from movies where release_year > 2020;

-- Exercise 8) All movies after the year 2020 that have more than 8 rating
select * from movies where release_year > 2020 and imdb_rating > 8;

-- Exercise 9) Select all movies that are by Marvel studios and Hombale Films
select * from movies where studio in ('Marvel Studios','Hombale Films');

-- Exercise 10) Select all THOR movies order by their release year
select * from movies where title like '%THOR%' order by release_year desc;

-- Exercise 10) Select all movies that are not from Marvel Studios
select * from movies where studio != 'Marvel Studios';

-- MAX and MIN functions
select max(imdb_rating) as MAXRATING from movies where industry = 'bollywood';
select min(imdb_rating) as MINRATING from movies where industry = 'hollywood';


-- AVG FUNCTION
select avg(imdb_rating) as AVG_RATING_OF_BOLLYWOOD_MOVIES from movies where industry = 'bollywood';

-- ROUND AVG TO TWO DECIMAL PLACE 
select ROUND(avg(imdb_rating),2) as AVG_RATING_OF_BOLLYWOOD_MOVIES from movies where industry = 'bollywood';

-- ROUND AVG TO THREE DECIMAL PLACE 
select ROUND(avg(imdb_rating),3) as AVG_RATING_OF_BOLLYWOOD_MOVIES from movies where industry = 'bollywood';

-- TRUNCATE AVG TO THREE DECIMAL PLACE 
select TRUNCATE(avg(imdb_rating),3) as AVG_RATING_OF_BOLLYWOOD_MOVIES from movies where industry = 'bollywood';

-- print minimum rating, maximum rating and average rating of marvel movies 
select min(imdb_rating) as min_rating, max(imdb_rating) as max_rating, round(avg(imdb_rating),2) as avg_rating from movies where studio = 'Marvel Studios';

-- group by clause
select * from movies;
select count(*), industry from movies group by industry;
select count(*) as Total_Movies, studio from movies group by studio order by Total_Movies desc;
select count(*) as Total_Movies, studio from movies where studio != '' group by studio order by Total_Movies desc;

-- Exercise 11) How many movies were released between 2015 and 2022?
select count(*) from movies where release_year between 2015 and 2022;
select count(*) from movies where release_year >= 2015 and release_year <= 2022;

-- Exercise 12) Print max and min movie year 
select max(release_year), min(release_year) from movies;

-- Exercise 13) Print a year and how many movies were released in that year starting with the latest year
select count(*) as Number_of_movies, release_year from movies group by release_year order by release_year desc;

-- HAVING CLAUSE
-- Get all the years in which 3 or more then 3 movies are released
select count(*) as Number_of_movies, release_year from movies group by release_year having Number_of_movies >=3;

-- To get currentdate and year from current date
select curdate();
select year(curdate());

-- Find age of actors
select name, (year(curdate()) - birth_year) as age from actors;

select revenue, budget, (revenue - budget) as profit from financials;

 -- IF Condition
 -- IF (CONDITION, TRUE, FALSE)
 
 select * from financials;
 
 select *, IF (currency = 'usd', revenue*77, revenue) as revenue_in_inr from financials order by revenue_in_inr desc;
 
 select *, IF (currency = 'usd', budget*77, budget) as budget_in_inr, 
 IF(currency = 'USD', revenue*77, revenue) as revenue_in_inr from financials;
 
 select distinct unit from financials;
 
 select *, (CASE
 WHEN unit = 'Billions' THEN  revenue*1000
 when unit = 'Thousands' THEN revenue/1000
 else revenue
 end) as revenue_in_millions
 from financials order by unit;
 
 --  Print profit % for all the movies
 
 select * from financials;
 
 select *, 
 (revenue-budget) as profit, 
 ((revenue-budget)/revenue)*100 as profit_percentage from financials;
 
 select * from movies where title like 'The_%';
 select * from customers where customer_id % 2 != 0;
 
 select * from movies where movie_id % 2 = 1;
 select * from movies where movie_id % 2 != 0;
 
 SELECT count(distinct imdb_rating), STDDEV(imdb_rating) from movies;
 
 -- Want revenue, budget, unit of all the movies in bollywood 
 
 select movies.title, movies.industry, movies.release_year, financials.budget, financials.revenue, financials.unit from movies
 join financials on movies.movie_id = financials.movie_id
 order by industry;
 
 select movies.title, movies.industry, movies.release_year, financials.budget, financials.revenue, financials.unit from movies
 inner join financials on movies.movie_id = financials.movie_id
 order by industry;
 
 -- Show all the movies with their language names
 show tables;
 
 select * from languages;
 select * from movies;
 
 select m.title, m.industry, l.name from movies m 
 join languages l using (language_id);
 
 --  Show all Telugu movie names (assuming you don't know the language id for Telugu)
 select * from movies m 
 join languages l using (language_id) 
 where l.name = 'Telugu';
 
 use moviesdb;
select m.title, m.industry, f.budget, f.revenue, f.unit, (revenue-budget) as profit from movies m 
join financials f using (movie_id);

select m.title, m.industry, f.budget, f.revenue, f.unit, (revenue-budget) as profit from movies m 
join financials f using (movie_id) where industry = 'bollywood' order by profit desc;

select m.title, m.industry, f.budget, f.revenue, f.unit,
case
when unit = "Thousands" then (revenue-budget)/1000
when unit = "Billions" then (revenue-budget)*1000
else (revenue-budget)
end as profit_mln
from movies m 
join financials f using (movie_id) where industry = 'bollywood' ;


select title, industry, CASE
when industry = "Bollywood" then "Hindustan ke Movie"
when industry = "Hollywood" then "Videsh ke Movie"
END as Category 
from movies order by Category; 

show tables;

select m.title as Movie_Title, group_concat(a.name separator " , ") as Actors
from movies m 
join movie_actor ma on m.movie_id = ma.movie_id
join actors a on a.actor_id = ma.actor_id
group by m.title;

select * from actors;
select * from movie_actor;

select a.name, group_concat(m.title) as Movies
from actors a 
join movie_actor ma on a.actor_id = ma.actor_id
join movies m on m.movie_id = ma.movie_id
group by name;


select a.name, count(m.title) as Movie_Count, group_concat(m.title) as Movies
from actors a 
join movie_actor ma on a.actor_id = ma.actor_id
join movies m on m.movie_id = ma.movie_id
group by name;

select a.name, count(m.title) as Movie_Count, group_concat(m.title) as Movies
from actors a 
join movie_actor ma on a.actor_id = ma.actor_id
join movies m on m.movie_id = ma.movie_id
group by name 
having Movie_Count < 3
order by Movie_Count desc;

-- Generate a report of all Hindi movies sorted by their revenue amount in millions Print movie name, revenue, currency, and unit

select * from languages;

select * from financials;

select m.title, l.name, f.budget, f.revenue, f.unit, 
CASE
when unit = 'Thousands' then (revenue-budget)/1000
when unit = 'billions' then (revenue-budget)*1000
when unit = 'millions' then (revenue-budget)
END as profit
from movies m 
join languages l on m.language_id = l.language_id
join financials f on m.movie_id = f.movie_id
where l.name = "Hindi"
order by profit desc;


select title, industry, imdb_rating from movies where imdb_rating = (select max(imdb_rating) from movies);

select * from movies where imdb_rating in (
(select max(imdb_rating) from movies),
(select min(imdb_rating) from movies)
);

-- select all teh actors whose age between 70 and 85

select * from actors;
select * from 
(select name, (year(curdate()) - birth_year) as Age from actors) as actors_age 
where age between 70 and 85 order by age;


-- select all actors who acted in any of these movies (101, 110, 121)
select * from movies;
select * from actors;

select m.movie_id, group_concat(a.name) from movies m
join movie_actor ma using (movie_id)
join actors a using (actor_id) 
where m.movie_id in (101,110,121)
group by m.movie_id;

select * from actors where actor_id in (select actor_id from movie_actor where movie_id in (101,110,121));
select * from actors where actor_id = ANY(select actor_id from movie_actor where movie_id in (101,110,121));

# SELECT ALL MOVIES WHOSE RATING IS GREATER THEN ANY OF THE MARVEL MOVIES
select * from movies where imdb_rating > ANY(select imdb_rating from movies where studio = "Marvel STudios") and studio != "Marvel Studios"
order by imdb_rating desc;

select * from movies where imdb_rating > (select MIN(imdb_rating) from movies where studio = "Marvel STudios") and studio != "Marvel Studios"
order by imdb_rating desc;

# Select all movies whose rating is greater then all of the marvel movies 

select * from movies where imdb_rating > (select max(imdb_rating) from movies where studio = "Marvel STudios") and studio != "Marvel Studios"
order by imdb_rating desc;

select * from movies where imdb_rating > ALL(select imdb_rating from movies where studio = "Marvel STudios") and studio != "Marvel Studios"
order by imdb_rating desc;

# Co related subquery 
-- select the actor id, actor name and the total number of movies they acted in.

select * from actors;
select a.actor_id, a.name, count(a.name) as total from actors a
join movie_actor ma using(actor_id)
group by a.actor_id
order by total desc;


select actor_id, name,
(select count(*) from movie_actor 
where actor_id = actors.actor_id) as movies_count
from actors 
order by movies_count desc;

-- Select all the movies with minimum and maximum release_year. Note that there
-- can be more than one movie in min and a max year hence output rows can be more than 2
select * from movies;
select movie_id, title, release_year from movies where release_year in (
(select min(release_year) from movies),
(select max(release_year) from movies))
order by release_year;

-- 2. Select all the rows from the movies table whose imdb_rating is higher than the average rating of all the movies

select * from movies where imdb_rating > (select avg(imdb_rating) from movies);

 
 select count(movie_id) as Num_of_Movies, l.name from movies m 
 join languages l using (language_id)
 group by l.name 
 order by Num_of_Movies desc;
 
 
-- Common Table Expression (or CTE) is a way to store the results of an SQL query temporarily 
-- so that you can use that in further complex queries as if it is a table.

-- Movies that done 500 percent profit despite there rating is less then average of all the movies

-- Part1 of problem
select *, 
(revenue-budget)*100/budget as profit_percentage from financials
where (revenue-budget)*100/budget > 500;

-- Part2 of problem 
select * from movies where imdb_rating < (select avg(imdb_rating) from movies);

-- Now to get our final answer we need to join both these query consider part 1 as table x and part 2 as table y 
-- Let's achieve this first using join and subquery then we will able to understand CTE

SELECT * FROM 
(select *, 
(revenue-budget)*100/budget as profit_percentage from financials
where (revenue-budget)*100/budget > 500) X
join
(select * from movies where imdb_rating < (select avg(imdb_rating) from movies)) Y 
on X.movie_id = Y.movie_id ;

-- Now to make it more readable I will select the coloumns I want and I can use our where clause outside the query as well and that way I can use 
-- profit_percentage in where clause instead of whole mathematical expression

SELECT X.movie_id, y.title, X.profit_percentage, Y.imdb_rating FROM 
(select *, 
(revenue-budget)*100/budget as profit_percentage from financials) X
join
(select * from movies where imdb_rating < (select avg(imdb_rating) from movies)) Y 
on X.movie_id = Y.movie_id
where profit_percentage > 500;

-- Now achieve it with CTE

With 
  X as (select *, 
    (revenue-budget)*100/budget as profit_percentage from financials),
  Y as (select * from movies where imdb_rating < (select avg(imdb_rating) from movies))
select x.movie_id, x.profit_percentage, y.title, y.imdb_rating
from X
join Y 
on x.movie_id = Y.movie_id
where profit_percentage >= 500;

-- Benefits for CTE is it makes complex querry easy and makes query more readable
-- Same result set can be referenced multiple times within the scope of with statement 
-- It gives potential candidates for views 

-- Select all Hollywood movies released after the year 2000 that made more than 500 million $ profit or more profit. 
-- Note that all Hollywood movies have millions as a unit hence you don't need to do the unit conversion. 
-- Also, you can write this query without CTE as well but you should try to write this using CTE only

WITH 
A as
(select * from movies where Industry = 'Hollywood'),
B as 
(select *, (revenue-budget) as Profit from financials)
select A.movie_id, A.title, A.Industry, B.profit from A
JOIN B
ON A.movie_id = B.movie_id
WHERE Profit > 500;
use trendytech;


show tables;
drop table languages;
select * from employee;


create database testmovie ;

use testmovie;

create table languages (
language_id tinyint primary key auto_increment,
language_name varchar(10) unique key not null
);

select * from languages;

create table movie (
movie_id int primary key auto_increment,
movie_title varchar(30) not null,
industry enum('Bollywood', 'Hollywood'),
Release_year year,
Imdb_rating decimal(4,2),
production_house varchar(30),
lang int,
foreign key (lang) references languages(language_id)
);













 