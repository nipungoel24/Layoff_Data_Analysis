-- 3. Null Values or Blank Values

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL 
	OR 
    industry = ''; 

-- As we can see Airbnb industry can be populated from other values
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company = 'Airbnb';

-- by this way we have to do it many times for all the missing values
UPDATE layoffs_staging2
SET industry = 'Travel'
WHERE company = 'Airbnb';

-- so a easy way will be self join
SELECT t1.industry, t2.industry
FROM world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
	AND T2.industry IS NOT NULL;

UPDATE world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
	AND T2.industry IS NOT NULL;
    
    
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry ='';


SELECT *
FROM layoffs_staging2;