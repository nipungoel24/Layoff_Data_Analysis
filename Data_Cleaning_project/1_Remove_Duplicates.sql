-- **DATA CLEANING PROJECT**

SELECT *
FROM world_layoffs.layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove any Columns

-- 1. Remove Duplicates

CREATE TABLE Layoffs_staging
LIKE layoffs;

INSERT INTO Layoffs_staging
SELECT *
FROM layoffs;

-- THIS WILL GIVE ALL THE ROW NUMBERS AND IF 
-- THERE ARE DUPLICATE ROWS THEN IT WILL GIVE THEM NUMBER BASED ON COUNT
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY company, industry, 
location, total_laid_off, 
percentage_laid_off, `date`,
country, stage,
funds_raised_millions) AS row_num
FROM Layoffs_staging;

-- MAKING A CTE's TO FIND DUPLICATE
WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY company, industry, 
location, total_laid_off, 
percentage_laid_off, `date`,
country, stage,
funds_raised_millions) AS row_num
FROM Layoffs_staging
)
SELECT *
FROM duplicate_cte 
WHERE row_num > 1;



-- MAKE ANOTHER TABLE WITH row_num to delete the duplicates
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
	FROM world_layoffs.layoffs_staging2;

INSERT INTO world_layoffs.layoffs_staging2
	SELECT *, 
	ROW_NUMBER() OVER (PARTITION BY company, industry, 
	location, total_laid_off, 
	percentage_laid_off, `date`,
	country, stage,
	funds_raised_millions) AS row_num
	FROM Layoffs_staging;
    
-- SEEING IF IT WORKS AND SHOWS THE DUPLICATE
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE row_num > 1;

-- DELETE THE DUPLICATES NOW
DELETE
FROM world_layoffs.layoffs_staging2
WHERE row_num > 1;




