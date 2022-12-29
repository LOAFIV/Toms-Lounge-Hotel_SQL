/*
Toms Lounge database creation. Multiple tables uploaded into the database. 
EDA to answer stakeholder Questions.
1. Is the company turning a profit every year?
2. If so, which specific hotels are making profit?
3. Should we increase our parking lot size?
4. What trends can we see in the data?


Skills used: 
Union 
Temp Table/CTE 
Aggregate Functions
Joins
*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--5 Tables imported

SELECT * 
From [Toms Lounge]..Toms_2018

SELECT * 
From [Toms Lounge]..Toms_2019

SELECT * 
From [Toms Lounge]..Toms_2020

SELECT * 
From [Toms Lounge]..[Toms_market_segment]

SELECT * 
From [Toms Lounge]..[Toms_meal_cost]


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--First we Combine yearly tables using UNION function

SELECT * 
From [Toms Lounge]..Toms_2018
UNION
SELECT * 
From [Toms Lounge]..Toms_2019
UNION
SELECT * 
From [Toms Lounge]..Toms_2020

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1- Is the company turning a profit every year? 

-- First create a CTE to query all 3 tables simultaneously
WITH Toms_lounge as (
SELECT * 
From [Toms Lounge]..Toms_2018
UNION
SELECT * 
From [Toms Lounge]..Toms_2019
UNION
SELECT * 
From [Toms Lounge]..Toms_2020
)

-- No revenue column in table so we create one.
--SELECT (stays_in_weekend_nights + stays_in_week_nights) * adr as Revenue
--From Toms_lounge

-- Show revenue growth over the years. 
SELECT arrival_date_year,
Round(Sum((stays_in_weekend_nights + stays_in_week_nights) * adr),2) as Revenue
From Toms_lounge
group by arrival_date_year

--We can conclusively answer question 1. Yes, profit is growing each year. 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2- If so, which specific hotels are making profit?


-- We can use the same CTE to query all 3 tables simultaneously
WITH Toms_lounge as (
SELECT * 
From [Toms Lounge]..Toms_2018
UNION
SELECT * 
From [Toms Lounge]..Toms_2019
UNION
SELECT *
From [Toms Lounge]..Toms_2020
)

--To answer the question 2 we can just add the 'hotel' column to the query.
SELECT arrival_date_year, hotel,
Round(Sum((stays_in_weekend_nights + stays_in_week_nights) * adr),2) as Revenue
From Toms_lounge
group by arrival_date_year, hotel

--This gives a breakdown of the annual profit based on the hotel type, which answers question 2.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Consolidating the other tables in the database for further analysis. 

WITH Toms_lounge as (
SELECT * 
From [Toms Lounge]..Toms_2018
UNION
SELECT * 
From [Toms Lounge]..Toms_2019
UNION
SELECT *
From [Toms Lounge]..Toms_2020
)

--Using the 'Left Join' statement, we can combine the other tables in the database with our CTE
SELECT *
From Toms_lounge
left join [Toms Lounge]..Toms_market_segment
on Toms_lounge.market_segment = Toms_market_segment.market_segment
left join [Toms Lounge]..Toms_meal_cost
on Toms_lounge.meal = Toms_meal_cost.meal

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Data will be transfered to Power BI. Questions 3 and 4 will be answered as well as further analysis and visualizations.  
--This concludes our EDA and this segment of the analysis process. All comments are welcome. Thank You!