How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

select count(runner_id),(extract('week' from registration_date)) as cnt from pizza_runner.runners
group by 2 order by 1 asc
-------------------------------------------------------------------------------------------------------
