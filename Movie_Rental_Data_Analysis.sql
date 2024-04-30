use sakila;

/*TASK 1 -Display the full names of actors available in the database */
Select concat(first_name,' ',last_name) as Actor_Full_name from actor;

/* 2.1  Display the number of times each first name appears in the database*/
select first_name, count(*) as frequency
from actor group by first_name order by frequency desc;

/*TASK 2.2-What is the count of actors that have unique first names
 in the database?Display the first names of all these actors*/
Select first_name from actor 
group by first_name having count(*)=1;
    
/*TASK 3.1-Display the number of times each last name appears in the database*/
select last_name,count(*) as frequency from actor 
group by last_name order by frequency desc;

/*TASK 3.2-display all unique last names in the database*/
select distinct last_name from actor;

/* TASK 4.1- Display the list of records for the movies with the rating "R"*/
select title,rating from 
film where rating='R';

/* TASK 4.2-Display the list of records for the movies that are not rated "R"*/
select title,rating from 
film where rating!='R';

/*TASK4.3-Display the list of records for the movies 
that are suitable for audience below 13 years of age*/
select title,rating from 
film where rating='G' or rating='PG';

/*TASK 5.1-Display the list of records for the 
  movies where the replacement cost is up to $11*/
select title,replacement_cost from film where replacement_cost<=11;

/* TASK 5.2 Display the list of records for the movies
   where the replacement cost is between $11 and $20*/
 select title,replacement_cost from film where 
 replacement_cost > 11 and replacement_cost<=20;
 
/*TASK 5.3-Display the list of records for the all movies 
in descending order of their replacement costs*/
select title, replacement_cost from 
film order by replacement_cost desc;

/*TASK 6- Display the names of the top 3 movies
 with the greatest number of actors*/
select f.title, count(*) as actor_count
from film f join film_actor fa on f.film_id=fa.film_id 
group by f.title order by actor_count desc limit 3;

/* TASK 7 -Display the titles of the movies 
starting with the letters 'K' and 'Q*/
select title from film where title like 'K%' or title like 'Q%';

/* TASK 8-The film 'Agent Truman' has been a great success,Display 
		the names of all actors who appeared in this film*/
select a.first_name,a.last_name from actor a join film_actor fa on a.actor_id=fa.actor_id
join film f on f.film_id=fa.film_id where f.title='Agent Truman';

/* TASK 9- Identify all the movies categorized as family films*/
select f.title from film f join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id=c.category_id where c.name='Family';

/* TASk 10.1 - Display the maximum, minimum, and average rental 
			   rates of movies based on their ratings*/
select rating ,max(rental_rate) as max_rate,min(rental_rate) as min_rate,
avg(rental_rate) as avg_rate from film group by rating order by avg_rate desc;

/* TASK 10.2-Display the movies in descending order of their rental frequencies,
			so the management can maintain more copies of those movies*/ 
select f.title ,count(r.inventory_id) as rental_frequency from film f
left join inventory i on f.film_id=i.film_id left join rental r
on r.inventory_id=i.inventory_id group by f.title order by rental_frequency desc;

/*  TASK 11-In how many film categories, the difference between the average film 
         replacement cost and the average film rental rate is greater than $15*/
select c.name as category, 
avg(f.replacement_cost) as avg_replacement_cost, 
avg(f.rental_rate) as avg_rental_rate
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
group by c.name
having (avg(replacement_cost) - avg(rental_rate)) > 15;

/* TASK 12- Display the film categories in which the number of movies is greater than 70*/
select c.name as category,count(f.title) as movie_count from film f,film_category fc,category c
 where f.film_id=fc.film_id and fc.category_id=c.category_id group by c.name having count(f.film_id)>70;