use sakila;
select * from actor;
select actor_id, first_name, last_name from actor where actor_id in (5,7);
select actor_id, first_name, last_name from actor where actor_id between 5 and 7;
select actor_id, first_name, last_name from actor where actor_id > 5 and actor_id < 7;

