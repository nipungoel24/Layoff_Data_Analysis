-- 2. Standardize the Data



-- To remove the white space in the company names
SELECT company, TRIM(company)
FROM world_layoffs.layoffs_staging2; 

UPDATE layoffs_staging2
SET company = TRIM(company);


-- see diff industry to standardize the name
SELECT DISTINCT(industry)
FROM world_layoffs.layoffs_staging2
ORDER BY 1;


-- there were many with diff name of crypto
SELECT * 
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


SELECT DISTINCT country 
FROM layoffs_staging2
ORDER BY 1;

-- this was to change the Diff name for same country
UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';
-- It also does it but theres one more way

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1; 

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- Changing `date` to date format
SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

-- It will still show text as format
-- To now change the data type
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

