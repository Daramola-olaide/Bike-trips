--- DATA CLEANING  in MYSQL 
SELECT* 
FROM trips.bike;

---- 1. Create another copy of a table
Create TABLE bike2 
LIKE bike;

SELECT * 
FROM bike2;

INSERT bike2
SELECT *
FROM bike;  

--- 2. Breaking out into individual column (date, time)
SELECT 
DATE(start_date) AS the_start_date,
TIME(start_date) AS the_start_time
FROM trips.bike;      

ALTER TABLE trips.bike
ADD COLUMN the_start_date DATE;

UPDATE trips.bike
SET the_start_date =  DATE(start_date); 

ALTER TABLE trips.bike
ADD COLUMN the_start_time TIME;

UPDATE trips.bike
SET the_start_time = TIME(start_date);

SELECT * 
FROM trips.bike;

SELECT 
DATE(end_date) AS the_end_date,
TIME(end_date) AS the_end_time
FROM trips.bike;     

ALTER TABLE trips.bike
ADD COLUMN the_end_date DATE;

UPDATE trips.bike
SET the_end_date =  DATE(end_date); 

ALTER TABLE trips.bike
ADD COLUMN the_end_time TIME;

UPDATE trips.bike
SET the_end_time = TIME(end_date);

------ 3. CREATE A NEW DUPLICATE TABLE
Create TABLE bike2 
LIKE bike;

SELECT * 
FROM bike2;

INSERT bike2
SELECT *
FROM bike;  

--- 4. standardize data and convert text to date format
SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM bike;

UPDATE bike2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

ALTER TABLE bike2
MODIFY COLUMN `date` DATE; 

------- 5. DROP UNUSED COLUMN
SELECT *
FROM trips.bike;

ALTER TABLE trips.bike
DROP COLUMN start_date;

ALTER TABLE trips.bike
DROP COLUMN end_date;

ALTER TABLE trips.bike
DROP COLUMN the_end_date;

--------- 4. Removing duplicates 
WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY trip_id,
			bike_id,
			from_station_name,
			from_station_id,
            to_station_name,
			to_station_id,
            ride_length,
            usertype) AS row_num
            FROM trips.bike
            )
            SELECT *
            FROM duplicate_cte
            WHERE row_num > 1
            