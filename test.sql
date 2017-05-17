-- use 'test';

-- create table Department(dep_id integer, name varchar(20));

-- create table Employee(emp_id integer, dep_id integer, manager_id integer, name varchar(20), salary integer);

-- create table Bonus(bonus_id integer, emp_id integer, ga_id integer, amount integer, date timestamp);

-- create table GrantingAuthority(ga_id integer, emp_id integer, dep_id integer);

-- insert into department (dep_id, name)
-- values (1, "technology"), (2, "marketing"), (3, "sales"), (4, "finance")
-- ;

-- insert into employee (emp_id, dep_id, manager_id, name, salary)
-- values (1, 1, 1, "Fredrik", 200000), (2, 1, 1, "Kevin", 180000), (3, 1, 1, "Martin", 200000), (4, 1, 3, "Leah", 130000),
--        (5, 2, 5, "Sasha", 130000), (6, 2, 5, "Mike", 120000), (7, 2, 5, "Jack", 120000), (8, 2, 5, "Jess", 125000),
--        (9, 3, 9, "Lauren", 90000), (10, 3, 9, "Fatima", 70000), (11, 3, 9, "Rosa", 75000), (12, 3, 9, "Sydney", 65000),
--        (13, 4, 13, "Hugo", 160000), (14, 4, 13, "Paige", "120000"), (15, 4, "Kelly", 130000), (16, 4, "Tod", 110000)
-- ;

-- insert into employee (emp_id, dep_id, manager_id, name, salary)
-- (select floor(10 + 90*random()) as emp_id, floor(10 + 90*random()) as dep_id, )
-- ;

-- insert into bonus (bonus_id, emp_id, amount)
-- (select floor(10 + 90*random()) as bonus_id, floor(10 + 90*random()) as emp_id, floor(10 + 90*random()) as amount from generate_series(1, 1000))
-- ;

use test;

drop table department;
CREATE TABLE department(
  dep_id integer,
  name text
);

drop table employee;
CREATE TABLE employee(
  emp_id integer,
  dep_id integer,
  manager_id integer,
  name text,
  salary integer
);

drop table bonus;
CREATE TABLE bonus(
  bonus_id integer,
  emp_id integer,
  ga_id integer,
  amount integer,
  date date
);

drop table granting_authority;
CREATE TABLE granting_authority(
  ga_id integer,
  emp_id integer,
  dept_id integer
);

WITH temp as (
  SELECT 'math' UNION
  SELECT 'science'
)

INSERT INTO department (
  dep_id,
  name
) (
    SELECT
      floor(10 + 90*random()) as dep_id,
      md5(random()::text) as name
     FROM generate_series(1, 1000)
);

INSERT INTO employee (
  dep_id,
  emp_id,
  manager_id,
  name,
  salary
) (
    SELECT
      floor(10 + 90*random()) as dep_id,
      floor(10 + 90*random()) as emp_id,
      floor(10 + 90*random()) as manager_id,
      md5(random()::text) as name,
      floor(10 + 90*random()) as salary
     FROM generate_series(1, 1000)
);

INSERT INTO bonus (
  bonus_id,
  emp_id,
  ga_id,
  amount
) (
    SELECT
      floor(10 + 90*random()) as bonus_id,
      floor(10 + 90*random()) as emp_id,
      floor(10 + 90*random()) as ga_id,
      floor(10 + 90*random()) as amount
     FROM generate_series(1, 1000)
);

INSERT INTO granting_authority (
  ga_id,
  emp_id,
  dept_id
) (
    SELECT
      floor(10 + 90*random()) as ga_id,
      floor(10 + 90*random()) as emp_id,
      floor(10 + 90*random()) as dept_id,
     FROM generate_series(1, 1000)
);

SET enable_mergejoin = ON;
EXPLAIN ANALYZE SELECT
  b.emp_id, sum(b.amount), e.name
FROM
  bonus b
LEFT OUTER JOIN employee e
ON b.emp_id = e.emp_id
GROUP BY
  b.emp_id, e.name;

-- * What is the total bonus amount for each employee?
select e.name, sum(b.amount)
from bonus as b
inner join employee as e on (e.emp_id = b.emp_id)
group by b.emp_id
;

select b.emp_id, sum(b.amount)
from bonus as b
group by b.emp_id
;

-- * Which employees received the highest total compensation last year, and how much was it?

select e.name
from employee as e
order by e.salary desc
limit 5
;

-- * What is the total bonus amount awarded by department?

select d.name, sum(b.amount)
from employee as e
inner join bonus as b on (e.emp_id = b.emp_id)
inner join department as d on (e.dep_id = d.dep_id)
group by d.name
;

-- * Which employees earn more salary than their managers?
-- * In which departments did employees earn more total compensations than their managers last year?
-- * What are the names of the employees who were invalidly awarded their bonuses?


