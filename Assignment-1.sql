              --  SQL PROJECT – HIRING ABC COMPANY (Real Question)

-- Task -1

create or replace table shopping_history(
product varchar not null,
quantity integer not null,
unit_price integer not null);

select * from shopping_history;

insert into shopping_history values ('milk', 3,10);
insert into shopping_history values ('bread', 7,3);
insert into shopping_history values ('bread', 5,2);
insert into shopping_history values ('cheese', 3,15);
insert into shopping_history values ('butter', 4,6);
insert into shopping_history values ('sprite', 4,20);
insert into shopping_history values ('cheese', 8,10);
insert into shopping_history values ('milk', 8,30);
insert into shopping_history values ('bread', 3,10);
insert into shopping_history values ('milk', 9,20);


-- Answer Query
select product, (sum(unit_price*quantity)) as total_price from shopping_history group by product order by product desc;

-- Output--
PRODUCT |	TOTAL_PRICE
----------------------
sprite	| 80
milk	  | 450
cheese	| 125
butter	| 24
bread	  | 61

-- Task -2
--Given 1:
create table phones (
name varchar(20) not null unique,
phone_number integer not null unique);


create table calls (
id integer not null,
caller integer not null,
callee integer not null,
duration integer not null,
unique(id));

insert into phones values('Jack',1234);
insert into phones values('Lena',3333);
insert into phones values('Mark',9999);
insert into phones values('Anna',7582);

select * from phones;

insert into calls values (25,1234,7582,8);
insert into calls values (7,9999,7582,1);
insert into calls values (18,9999,3333,4);
insert into calls values (2,7582,3333,3);
insert into calls values (3,3333,1234,1);
insert into calls values (21,3333,1234,1);

select * from calls;

-- Answer Query
select names from (select case when (sum(c.duration)>=10) then p.name end as names from phones p left outer join calls c on
                  p.phone_number = c.caller or p.phone_number = c.callee group by p.name) where names is not null order by names; 

--Ouput--
NAMES
-----
Anna
Jack




--Given 2:
create table phone2 (
name varchar(20) not null unique,
phone_number integer not null unique);

create table calls2 (
id integer not null,
caller integer not null,
callee integer not null,
duration integer not null,
unique(id));


insert into phone2 values('John',6356);
insert into phone2 values('Addison',4315);
insert into phone2 values('Kate',8003);
insert into phone2 values('Ginny',9831);

select * from phone2;

insert into calls2 values (65,8003,9831,7);
insert into calls2 values (100,9831,8003,3);
insert into calls2 values (145,4315,9831,18);

select * from calls2;

-- Answer Query
select names from (select case when (sum(c.duration)>=10) then p.name end as names from phone2 p left outer join calls2 c on
                                               p.phone_number = c.caller or p.phone_number = c.callee group by p.name) where names is not null order by names; 
                                               
 
 --Output--
 NAMES
-------
Addison
Ginny
Kate

--Task 3:
-- Given 1:

create table transactions(
amount integer not null,
date date not null);

--delete from transactions;
select * from transactions;
insert into transactions values(1000,'2020-01-06');
insert into transactions values(-10,'2020-01-14');
insert into transactions values(-75,'2020-01-20');
insert into transactions values(-5,'2020-01-25');
insert into transactions values(-4,'2020-01-29');
insert into transactions values(2000,'2020-03-10');
insert into transactions values(-75,'2020-03-12');
insert into transactions values(-20,'2020-03-15');
insert into transactions values(40,'2020-03-15');
insert into transactions values(-50,'2020-03-17');
insert into transactions values(200,'2020-10-10');
insert into transactions values(-200,'2020-10-10');



-- Answer Query
Select ( sum(a.total) - (12- count(b.cnt ))*5 ) as balance From  
(Select sum(amount) as total , 'A' as name from  transactions  ) as a  left join  
(Select  count(amount) as cnt  , 'A' as name
From transactions 
where amount <0 
group by month(date) 
having not(count(amount) <3 or  sum(amount) >-100) ) as b 
on a.name = b.name;

--Output--
BALANCE
--------
2746

-- Given 2:

create table transactions2(
amount integer not null,
date date not null);

select * from transactions2;
insert into transactions2 values(1,'2020-06-29');
insert into transactions2 values(35,'2020-02-20');
insert into transactions2 values(-50,'2020-02-03');
insert into transactions2 values(-1,'2020-02-26');
insert into transactions2 values(-200,'2020-08-01');
insert into transactions2 values(-44,'2020-02-07');
insert into transactions2 values(-5,'2020-02-25');
insert into transactions2 values(1,'2020-06-29');
insert into transactions2 values(1,'2020-06-29');
insert into transactions2 values(-100,'2020-12-29');
insert into transactions2 values(-100,'2020-12-30');
insert into transactions2 values(-100,'2020-12-31');


-- Answer Query
select balance from
(select count(*), a.total, ((a.total) - (12- count(b.cnt))*5 ) balance from
(Select sum(amount) as total , 'A' as name from  transactions2  ) as a  left join  
(Select  count(amount) as cnt  , 'A' as name
From transactions2 
where amount <0 
group by month(date) 
having not(count(amount) <3 or  sum(amount) >-100) ) as b 
on a.name = b.name
group by 2);


--Output--
BALANCE
--------
-612


-- Given 3:

create table transactions3(
amount integer not null,
date date not null);

insert into transactions3 values(6000,'2020-04-03');
insert into transactions3 values(5000,'2020-04-02');
insert into transactions3 values(4000,'2020-04-01');
insert into transactions3 values(3000,'2020-03-01');
insert into transactions3 values(2000,'2020-02-01');
insert into transactions3 values(1000,'2020-01-01');

-- Answer Query
select balance from
(select count(*), a.total, ((a.total) - (12- count(b.cnt))*5 ) balance from
(Select sum(amount) as total , 'A' as name from  transactions3  ) as a  left join  
(Select  count(amount) as cnt  , 'A' as name
From transactions3
where amount <0 
group by month(date) 
having not(count(amount) <3 or  sum(amount) >-100) ) as b 
on a.name = b.name
group by 2);

--Output--
BALANCE
--------
20940


