use real_estate_db;
describe properties;

select*
from house_properties
limit 10;

select max(price) as average_price
from house_properties;

select location, total_sqft,size,price
from house_properties
order by price desc
limit 10;

select location, ROUND(avg(price),2) as average_price
from house_properties
group by location
order by average_price desc;

Select location,total_sqft,price, ROUND(price*100000/total_sqft) as price_per_sqft
from house_properties
where total_sqft>0;


select size , round(avg(price),2) as average_price
from house_properties
group by size
order by size
limit 10;

select *
from house_properties
where price between 50 and 100;

select price_category,
count(*) as total_properties
from(
select
CASE 
WHEN price <50 then 'budget'
when price<100 then 'Mid-range'
ELSE 'Premium' 
END as price_category
from house_properties) as categorized
group by price_category
order by total_properties desc;    

select location , total_sqft,
case 
when total_sqft <800 then 'Small'
when total_sqft <1500 then 'Medium'
ELSE 'large'
End as propert_size
from house_properties;


CREATE TABLE location_summary1
select location, round(avg(price),2) as average_location_price
from house_properties
group by location;

describe location_summary1;


select p.location,
p.size, l.average_location_price
from house_properties as p
join location_summary1 as l
on p.location =l.location
limit 20;


select p.location, p.size, p.total_sqft,p.price, l.average_location_price
from house_properties as p
join location_summary1 as l
on p.location = l.location 
where p.price > l.average_location_price 
order by p.price desc
limit 10; 

Select l.location,
round(l.average_location_price,2) as avg_price,
count(p.location) as property_count
from location_summary1 as l
join house_properties as p
on l.location = p.location
group by l.location, l.average_location_price
order by avg_price desc;

select location , size, price  


from house_properties
where price >(
select avg(price)
from house_properties)
order by price desc;

select location, size, price
from house_properties 
where price = (
select max(price)
from house_properties)
;

select location,  avg(price) as avg_price
from house_properties 
group by location 
having avg(price) > (
select avg(price)
from house_properties)
order by avg_price desc;

select p.location, p.total_sqft, p.size
from house_properties as p
where  p.price =(
select min(p2.price)
from house_properties as p2
where p2.location =p.location)
order by p.price ;
